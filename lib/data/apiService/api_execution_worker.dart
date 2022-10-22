import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:navolaya_flutter/resources/value_key_resources.dart';
import 'package:queue/queue.dart';

import '../../core/failure.dart';
import '../../core/logger.dart';
import '../../core/string_extention_function.dart';
import '../../resources/string_resources.dart';
import 'network_api_service.dart';

class ApiExecutionWorker {
  late SendPort _sendPort;

  late Isolate _isolate;
  final queue = Queue();

  final _isolateReady = Completer<void>();

  final List<Map<String, dynamic>> _response = [];
  final Dio _dio;
  static String _deviceToken = '';

  ApiExecutionWorker(this._dio) {
    init();
  }

  Future<void> get isReady => _isolateReady.future;

  Future<Either<Failure, dynamic>> fetch(Map<String, dynamic> data) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final key = getRandomString(10);
    final responseMap = {
      ValueKeyResources.completerKey: key,
      ValueKeyResources.responseCompleter: Completer<Either<Failure, dynamic>>()
    };
    data.putIfAbsent(ValueKeyResources.responseHandlerKey, () => responseMap);
    _response.add(responseMap);
    int index = _response.indexWhere((element) => element[ValueKeyResources.completerKey] == key);
    _sendPort.send(data);
    logger.i('the number of responses in queue is ${_response.length}');
    return _response[index][ValueKeyResources.responseCompleter].future;
  }

  Future<void> init() async {
    _deviceToken = (await FirebaseMessaging.instance.getToken())!;
    logger.i('device Token : $_deviceToken');

    final receivePort = ReceivePort();
    final errorPort = ReceivePort();
    errorPort.listen(print);

    receivePort.listen(_handleConnectionAndResponse);
    _isolate = await Isolate.spawn(
      _isolateEntry,
      [receivePort.sendPort, _dio],
      onError: errorPort.sendPort,
    );
  }

  void _handleConnectionAndResponse(dynamic message) {
    if (message is SendPort) {
      _sendPort = message;
      _isolateReady.complete();
      return;
    }
    if (message is Map<String, dynamic>) {
      final response = message[ValueKeyResources.response];
      final completerMap = message[ValueKeyResources.responseHandlerKey];

      final key = completerMap[ValueKeyResources.completerKey];
      int index = _response.indexWhere((element) => element[ValueKeyResources.completerKey] == key);

      _response[index][ValueKeyResources.responseCompleter].complete(response);
      _response.remove(_response[index]);
      return;
    }
    _response.last[ValueKeyResources.responseCompleter]
        .complete(const Left(Failure(StringResources.errorTitle)));
  }

  static void _isolateEntry(List<dynamic> messages) {
    late SendPort sendPort;
    final receivePort = ReceivePort();
    final dio = messages[1];
    receivePort.listen((dynamic message) async {
      assert(message is Map<String, dynamic>);

      try {
        final responseHandler = message[ValueKeyResources.responseHandlerKey];
        final response = await _executeAPI(dio: dio, reqParams: message);

        final resultMap = {
          ValueKeyResources.responseHandlerKey: responseHandler,
          ValueKeyResources.response: response
        };
        sendPort.send(resultMap);
      } on Exception catch (e) {
        sendPort.send(left(Failure(e.toString())));
      }
    });

    sendPort = messages[0];
    sendPort.send(receivePort.sendPort);
  }

  static Future<Either<Failure, dynamic>> _executeAPI(
      {required Dio dio, required reqParams}) async {
    final url = reqParams[ValueKeyResources.apiURL];
    final queryParameters = reqParams[ValueKeyResources.queryParameters];
    final apiType = reqParams[ValueKeyResources.apiType];
    final isTokenNeeded = reqParams[ValueKeyResources.isTokenNeeded];
    //final formData = reqParams[ValueKeyResources.formData];
    final token = reqParams[ValueKeyResources.token];

    logger.i('Token : $token');
    logger.i('URL : $url \n Request:  $queryParameters');

    try {
      late Response response;

      final headerOptions = Options(
        contentType: 'multipart/form-data',
        headers: isTokenNeeded
            ? {
                "Authorization": 'Bearer $token',
                'device-token': _deviceToken,
                'device-type': Platform.isIOS ? 'ios' : 'android'
              }
            : {},
      );

      if (apiType == ApiType.GET) {
        response = queryParameters.isEmpty
            ? await dio.get(
                url,
                options: headerOptions,
              )
            : await dio.get(url,
                queryParameters: queryParameters,
                options: Options(
                  contentType: 'multipart/form-data',
                  headers: isTokenNeeded ? {"Authorization": 'Bearer $token'} : {},
                ));
      } else if (apiType == ApiType.POST) {
        response = await dio.post(url,
            data: FormData.fromMap(queryParameters),
            options: Options(
              contentType: 'multipart/form-data',
              headers: isTokenNeeded ? {"Authorization": 'Bearer $token'} : {},
            ));
      } else if (apiType == ApiType.PUT) {
        response = await dio.put(url,
            data: FormData.fromMap(queryParameters),
            options: Options(
              contentType: 'multipart/form-data',
              headers: isTokenNeeded ? {"Authorization": 'Bearer $token'} : {},
            ));
      } else if (apiType == ApiType.PATCH) {
        response = await dio.patch(url,
            data: FormData.fromMap(queryParameters),
            options: Options(
              contentType: 'multipart/form-data',
              headers: isTokenNeeded ? {"Authorization": 'Bearer $token'} : {},
            ));
      } else {
        response = await dio.delete(url,
            data: FormData.fromMap(queryParameters),
            options: Options(
              contentType: 'multipart/form-data',
              headers: isTokenNeeded ? {"Authorization": 'Bearer $token'} : {},
            ));
      }

      logger.i('URL : $url \n Response : ${response.data}');

      return right(response.data);
    } on DioError catch (e) {
      if (e.response != null) {
        late final String message;
        if (e.response!.statusCode == 400 ||
            e.response!.statusCode == 401 ||
            e.response!.statusCode == 403 ||
            e.response!.statusCode == 404 ||
            e.response!.statusCode == 402 ||
            e.response!.statusCode == 408 ||
            e.response!.statusCode == 500) {
          message = e.response!.data['message'].toString();
          logger.e(e.response!.data['message'].toString());
        } else {
          message = '${e.response!.statusCode!}  ${e.message}';
          logger.e('${e.response!.statusCode!}  ${e.message}');
        }
        return Left(
          Failure(
            message,
            statusCode: e.response!.statusCode!,
          ),
        );
      }
      return left(Failure(e.message));
    } on SocketException catch (e) {
      logger.e(e);
      return left(const Failure(StringResources.checkInternetConnection));
    } on TypeError catch (e) {
      logger.e(e);
      return left(const Failure(StringResources.responseTypeError));
    } on Exception catch (e) {
      logger.e(e);
      return left(const Failure(StringResources.unexpectedErrorOccurred));
    }
  }

  void dispose() {
    _isolate.kill();
  }
}
