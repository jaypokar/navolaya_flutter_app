import 'package:dartz/dartz.dart';

import '../../core/failure.dart';

abstract class BaseAPIService {
  Future<Either<Failure, dynamic>> getAPI({
    required String url,
    required Map<String, dynamic> queryParameters,
    bool isTokenNeeded = true,
  });

  Future<Either<Failure, dynamic>> postAPI({
    required String url,
    required Map<String, dynamic> requestData,
    bool isTokenNeeded = true,
  });

  Future<Either<Failure, dynamic>> updateAPI({
    required String url,
    required Map<String, dynamic> requestData,
    bool isTokenNeeded = true,
  });
}
