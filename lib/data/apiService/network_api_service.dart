import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:navolaya_flutter/data/sessionManager/session_manager.dart';
import 'package:navolaya_flutter/resources/string_resources.dart';

import '../../core/failure.dart';
import '../../core/logger.dart';
import 'base_api_service.dart';

enum ApiType { get, post, put }

class NetworkAPIService implements BaseAPIService {
  final Dio dio;
  final Connectivity connectivity;
  final SessionManager sessionManager;
  late final String token;

  NetworkAPIService({required this.dio, required this.connectivity, required this.sessionManager}) {
    token = sessionManager.toString();
  }

  @override
  Future<Either<Failure, dynamic>> getAPI(
      {required String url,
      required Map<String, dynamic> queryParameters,
      bool isTokenNeeded = true}) async {
    return executeAPI(url, queryParameters, ApiType.get, isTokenNeeded);
  }

  @override
  Future<Either<Failure, dynamic>> postAPI(
      {required String url,
      required Map<String, dynamic> requestData,
      bool isTokenNeeded = true}) async {
    return executeAPI(url, requestData, ApiType.post, isTokenNeeded);
  }

  @override
  Future<Either<Failure, dynamic>> updateAPI(
      {required String url,
      required Map<String, dynamic> requestData,
      bool isTokenNeeded = true}) async {
    return executeAPI(url, requestData, ApiType.put, isTokenNeeded);
  }

  Future<Either<Failure, dynamic>> executeAPI(
      String url, Map<String, dynamic> queryParameters, ApiType apiType, bool isTokenNeeded) async {
    final connectivityResult = await connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      logger.i('$url Request:  $queryParameters');

      try {
        late Response response;

        if (apiType == ApiType.get) {
          response = queryParameters.isEmpty
              ? await dio.get(
                  url,
                  options: Options(
                    contentType: 'multipart/form-data',
                    headers: isTokenNeeded ? {"Authorization": 'Bearer $token'} : {},
                  ),
                )
              : await dio.get(url,
                  queryParameters: queryParameters,
                  options: Options(
                    contentType: 'multipart/form-data',
                    headers: isTokenNeeded ? {"Authorization": 'Bearer $token'} : {},
                  ));
        } else if (apiType == ApiType.post) {
          response = await dio.post(url,
              data: FormData.fromMap(queryParameters),
              options: Options(
                contentType: 'multipart/form-data',
                headers: isTokenNeeded ? {"Authorization": 'Bearer $token'} : {},
              ));
        } else {
          response = await dio.put(url,
              data: FormData.fromMap(queryParameters),
              options: Options(
                contentType: 'multipart/form-data',
                headers: isTokenNeeded ? {"Authorization": 'Bearer $token'} : {},
              ));
        }

        logger.i('$url Response : ${response.data}');

        return right(response.data);
      } on DioError catch (e) {
        logger.e(e.message);
        if (e.response!.statusCode == 400 ||
            e.response!.statusCode == 401 ||
            e.response!.statusCode == 403 ||
            e.response!.statusCode == 404 ||
            e.response!.statusCode == 402 ||
            e.response!.statusCode == 500) {
          return Right(e.response!.data);
        }
        return left(Failure(e.message));
      } on SocketException catch (e) {
        logger.e(e);
        return left(const Failure(StringResources.checkInternetConnection));
      } on Exception catch (e) {
        logger.e(e);
        return left(const Failure(StringResources.unexpectedErrorOccurred));
      } on TypeError catch (e) {
        logger.e(e);
        return left(const Failure(StringResources.responseTypeError));
      }
    } else {
      return left(const Failure(StringResources.checkInternetConnection));
    }
  }
}
