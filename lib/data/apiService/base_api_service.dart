import 'package:dartz/dartz.dart';

import '../../core/failure.dart';

abstract class BaseAPIService {
  Future<Either<Failure, dynamic>> getAPI(String url, Map queryParameters, String token);

  Future<Either<Failure, dynamic>> postAPI(String url, dynamic requestData, String token);

  Future<Either<Failure, dynamic>> updateAPI(String url, dynamic requestData, String token);
}
