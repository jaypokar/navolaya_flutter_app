import 'package:dartz/dartz.dart';
import 'package:navolaya_flutter/data/apiService/network_api_service.dart';

import '../../core/failure.dart';

abstract class BaseAPIService {
  Future<Either<Failure, dynamic>> executeAPI(
      {required String url,
      required Map<String, dynamic> queryParameters,
      bool isTokenNeeded = true,
      required ApiType apiType});
}
