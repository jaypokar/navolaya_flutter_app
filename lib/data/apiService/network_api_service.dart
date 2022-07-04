import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

import '../../core/failure.dart';
import '../../core/logger.dart';
import 'base_api_service.dart';

class NetworkAPIService implements BaseAPIService {
  final Dio dio;
  final Connectivity connectivity;

  const NetworkAPIService({required this.dio, required this.connectivity});

  @override
  Future<Either<Failure, dynamic>> getAPI(String url, Map queryParameters, String token) async {
    final connectivityResult = await connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      logger.i('$url Request:  $queryParameters');

      try {
        final response = queryParameters.isEmpty
            ? await dio.get(
                url,
                options: Options(
                  headers: {"Authorization": 'Bearer $token'},
                ),
              )
            : await dio.get(
                url,
                queryParameters: queryParameters as Map<String, dynamic>,
                options: Options(
                  headers: {"Authorization": 'Bearer $token'},
                ),
              );

        logger.i('$url Response : ${response.data}');

        return right(response.data);
      } on DioError catch (e) {
        logger.e(e.message);
        return left(Failure(e.message));
      } on SocketException catch (e) {
        logger.e(e);
        return left(const Failure('Please check the network connection'));
      } on Exception catch (e) {
        logger.e(e);
        return left(const Failure('Unexpected Error occurred'));
      }
    } else {
      return left(const Failure('Please check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, dynamic>> postAPI(String url, dynamic requestData, String token) async {
    final connectivityResult = await connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      logger.i('$url Request:  $requestData');

      try {
        final response = await dio.post(url,
            data: requestData,
            options: Options(
              headers: {"Authorization": 'Bearer $token'},
            ));

        logger.i('$url Response : ${response.data}');

        return right(response.data);
      } on DioError catch (e) {
        logger.e(e.message);
        if (e.response!.statusCode == 422) {
          return Right(e.response!.data);
        } else if (e.response!.statusCode == 404) {
          return Right(e.response!.data);
        }
        return left(Failure(e.message));
      } on SocketException catch (e) {
        logger.e(e);
        return left(const Failure('Please check the network connection'));
      } on Exception catch (e) {
        logger.e(e);
        return left(const Failure('Unexpected Error occurred'));
      }
    } else {
      return left(const Failure('Please check your internet connection'));
    }
  }

  @override
  Future<Either<Failure, dynamic>> updateAPI(String url, dynamic requestData, String token) async {
    final connectivityResult = await connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      logger.i('$url Request:  $requestData');

      try {
        final response = await dio.put(url,
            data: requestData,
            options: Options(
              headers: {"Authorization": 'Bearer $token'},
            ));

        logger.i('$url Response : ${response.data}');

        return right(response.data);
      } on DioError catch (e) {
        logger.e(e.message);
        if (e.response!.statusCode == 422) {
          return Right(e.response!.data);
        } else if (e.response!.statusCode == 404) {
          return Right(e.response!.data);
        }
        return left(Failure(e.message));
      } on SocketException catch (e) {
        logger.e(e);
        return left(const Failure('Please check the network connection'));
      } on Exception catch (e) {
        logger.e(e);
        return left(const Failure('Unexpected Error occurred'));
      }
    } else {
      return left(const Failure('Please check your internet connection'));
    }
  }
}
