import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:navolaya_flutter/core/global_nav_key.dart';
import 'package:navolaya_flutter/core/route_generator.dart';
import 'package:navolaya_flutter/data/sessionManager/session_manager.dart';
import 'package:navolaya_flutter/features/socket_connection_manager.dart';

import '../../core/failure.dart';
import '../../core/logger.dart';
import '../../resources/config_file.dart';
import '../../resources/string_resources.dart';
import 'base_api_service.dart';

// ignore: constant_identifier_names
enum ApiType { GET, POST, PUT, DELETE, PATCH }

class NetworkAPIService implements BaseAPIService {
  final Dio _dio;
  final Connectivity _connectivity;
  final SessionManager _sessionManager;
  final SocketConnectionManager _socketConnectionManager;
  String _token = '';
  String? _deviceToken;
  final FirebaseMessaging _firebaseMessaging;
  final jwt = JWT({});

  NetworkAPIService(this._dio, this._connectivity, this._sessionManager,
      this._socketConnectionManager, this._firebaseMessaging) {
    _token = _sessionManager.isUserLoggedIn() ? _sessionManager.getToken() : '';
    _firebaseMessaging.getToken().then((value) => _deviceToken = value);
  }

  @override
  Future<void> initiateLogoutProcess() async {
    await _sessionManager.initiateLogout();
    _socketConnectionManager.closeSocketConnection();

    Navigator.pushNamedAndRemoveUntil(
      GlobalNavKey.navState.currentState!.context,
      RouteGenerator.authenticationPage,
      (route) => false,
    );
  }

  @override
  Future<Either<Failure, dynamic>> executeAPI(
      {required String url,
      required Map<String, dynamic> queryParameters,
      bool isTokenNeeded = true,
      FormData? formData,
      required ApiType apiType}) async {
    // Create a json web token

    final connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      if (_sessionManager.isUserLoggedIn()) {
        _token = _sessionManager.getToken();
      }
      logger.i('Token : $_token');
      logger.i('URL : $url \n Request:  $queryParameters');
      logger.i('Device Token : $_deviceToken');
      final apiSecretAccessToken = await getJWTToken();
      logger.i('api secret access Token : $apiSecretAccessToken');

      try {
        late Response response;
        final headerOptions = Options(
            contentType: 'multipart/form-data',
            headers: isTokenNeeded
                ? {
                    "Authorization": 'Bearer $_token',
                    'device_token': _deviceToken,
                    'device_type': Platform.isIOS ? 'ios' : 'android',
                    'X-Access-Token': apiSecretAccessToken,
                  }
                : {
                    'device_token': _deviceToken,
                    'device_type': Platform.isIOS ? 'ios' : 'android',
                    'X-Access-Token': apiSecretAccessToken,
                  });

        if (apiType == ApiType.GET) {
          response = queryParameters.isEmpty
              ? await _dio.get(
                  url,
                  options: headerOptions,
                )
              : await _dio.get(url, queryParameters: queryParameters, options: headerOptions);
        } else if (apiType == ApiType.POST) {
          response =
              await _dio.post(url, data: FormData.fromMap(queryParameters), options: headerOptions);
        } else if (apiType == ApiType.PUT) {
          response =
              await _dio.put(url, data: FormData.fromMap(queryParameters), options: headerOptions);
        } else if (apiType == ApiType.PATCH) {
          response = await _dio.patch(url,
              data: FormData.fromMap(queryParameters), options: headerOptions);
        } else {
          response = await _dio.delete(url,
              data: FormData.fromMap(queryParameters), options: headerOptions);
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
            if (e.response!.statusCode == 401 || e.response!.statusCode == 408) {
              await initiateLogoutProcess();
            }
            message = e.response!.data['message'].toString();
          } else {
            message = '${e.response!.statusCode!}  ${e.message}';
          }
          logger.e(message);
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
    } else {
      return left(const Failure(StringResources.checkInternetConnection));
    }
  }

  @override
  Future<String> getJWTToken() async {
    return jwt.sign(SecretKey(ConfigFile.apiAccessSecretKey),
        expiresIn: const Duration(minutes: 1));
  }
}

//400
// Bad Request
//
// 401
// Unauthorized
//
// 402
// Payment Required
//
// 403
// Forbidden and show Pop for informing user that you are not verified yet to access all the service's within app.
//
// 404
// Not Found
//
// 408
// Login session expired
//
// 500
// Internal Server Error

///Simple Network call execution with single thread
/*@override
  Future<Either<Failure, dynamic>> executeAPI(
      {required String url,
      required Map<String, dynamic> queryParameters,
      bool isTokenNeeded = true,
      FormData? formData,
      required ApiType apiType}) async {
    final connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      if (_sessionManager.isUserLoggedIn()) {
        _token = _sessionManager.getToken();
      }
      logger.i('Token : $_token');
      logger.i('URL : $url \n Request:  $queryParameters');

      try {
        late Response response;

        if (apiType == ApiType.get) {
          response = queryParameters.isEmpty
              ? await _dio.get(
                  url,
                  options: Options(
                    contentType: 'multipart/form-data',
                    headers: isTokenNeeded ? {"Authorization": 'Bearer $_token'} : {},
                  ),
                )
              : await _dio.get(url,
                  queryParameters: queryParameters,
                  options: Options(
                    contentType: 'multipart/form-data',
                    headers: isTokenNeeded ? {"Authorization": 'Bearer $_token'} : {},
                  ));
        } else if (apiType == ApiType.post) {
          response = await _dio.post(url,
              data: FormData.fromMap(queryParameters),
              options: Options(
                contentType: 'multipart/form-data',
                headers: isTokenNeeded ? {"Authorization": 'Bearer $_token'} : {},
              ));
        } else if (apiType == ApiType.put) {
          response = await _dio.put(url,
              data: FormData.fromMap(queryParameters),
              options: Options(
                contentType: 'multipart/form-data',
                headers: isTokenNeeded ? {"Authorization": 'Bearer $_token'} : {},
              ));
        } else {
          response = await _dio.delete(url,
              data: FormData.fromMap(queryParameters),
              options: Options(
                contentType: 'multipart/form-data',
                headers: isTokenNeeded ? {"Authorization": 'Bearer $_token'} : {},
              ));
        }

        logger.i('URL : $url \n Response : ${response.data}');

        return right(response.data);
      } on DioError catch (e) {
        if (e.response != null) {
          if (e.response!.statusCode == 400 ||
              e.response!.statusCode == 401 ||
              e.response!.statusCode == 403 ||
              e.response!.statusCode == 404 ||
              e.response!.statusCode == 402 ||
              e.response!.statusCode == 408 ||
              e.response!.statusCode == 500) {
            if (e.response!.statusCode == 401 || e.response!.statusCode == 408) {
              await initiateLogoutProcess();
            }
            logger.e(e.response!.data['message'].toString());
          } else {
            logger.e('${e.response!.statusCode!}  ${e.message}');
          }
          return Left(
            Failure(
              e.response!.data['message'].toString(),
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
    } else {
      return left(const Failure(StringResources.checkInternetConnection));
    }
  }*/

/// Network execution in multiple thread
/*
@override
Future<Either<Failure, dynamic>> executeAPI(
    {required String url,
      required Map<String, dynamic> queryParameters,
      bool isTokenNeeded = true,
      FormData? formData,
      required ApiType apiType}) async {

  final connectivityResult = await _connectivity.checkConnectivity();


  if (connectivityResult == ConnectivityResult.mobile ||
      connectivityResult == ConnectivityResult.wifi) {

    if (_sessionManager.isUserLoggedIn()) {
      _token = _sessionManager.getToken();
    }


    await _apiExecutionWorker.isReady;

    final reqMap = {
      ValueKeyResources.apiURL: url,
      ValueKeyResources.formData: formData,
      ValueKeyResources.queryParameters: queryParameters,
      ValueKeyResources.isTokenNeeded: isTokenNeeded,
      ValueKeyResources.apiType: apiType,
      ValueKeyResources.token: _token,
    };

    final possibleData = await _apiExecutionWorker.fetch(reqMap);

    if (possibleData.isLeft()) {
      final statusCode = possibleData.getLeft()!.statusCode;
      if (statusCode == 401 || statusCode == 408) {
        await initiateLogoutProcess();
      }
      return Left(
        possibleData.getLeft()!,
      );
    }

    return right(possibleData.getRight());
  } else {
    return left(const Failure(StringResources.checkInternetConnection));
  }
}*/
