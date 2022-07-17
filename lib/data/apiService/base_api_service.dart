import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:navolaya_flutter/data/apiService/network_api_service.dart';

import '../../core/failure.dart';

abstract class BaseAPIService {
  Future<Either<Failure, dynamic>> executeAPI(
      {required String url,
      required Map<String, dynamic> queryParameters,
      bool isTokenNeeded = true,
      FormData? formData,
      required ApiType apiType});

  Future<void> initiateLogoutProcess();
}
