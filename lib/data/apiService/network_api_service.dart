import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:navolaya_flutter/core/global_nav_key.dart';
import 'package:navolaya_flutter/core/route_generator.dart';
import 'package:navolaya_flutter/data/sessionManager/session_manager.dart';
import 'package:navolaya_flutter/resources/string_resources.dart';

import '../../core/failure.dart';
import '../../core/logger.dart';
import 'base_api_service.dart';

enum ApiType { get, post, put }

class NetworkAPIService implements BaseAPIService {
  final Dio _dio;
  final Connectivity _connectivity;
  final SessionManager _sessionManager;
  late final String _token;

  NetworkAPIService(this._dio, this._connectivity, this._sessionManager) {
    _token = _sessionManager.isUserLoggedIn() ? _sessionManager.getToken() : '';
  }

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
        } else {
          response = await _dio.put(url,
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
              e.response!.statusCode == 500) {
            if (e.response!.statusCode == 401 || e.response!.statusCode == 403) {
              await initiateLogoutProcess();
            }
            logger.e(e.response!.data['message'].toString());
          } else {
            logger.e(e.message);
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
  }

  @override
  Future<void> initiateLogoutProcess() async {
    await _sessionManager.initiateLogout();
    Navigator.of(GlobalNavKey.navState.currentState!.context)
        .popUntil(ModalRoute.withName(RouteGenerator.authenticationPage));
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
// Forbidden
//
// 404
// Not Found
//
// 408
// Request Timeout
//
// 500
// Internal Server Error
