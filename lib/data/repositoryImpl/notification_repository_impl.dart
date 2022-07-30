import 'package:dartz/dartz.dart';
import 'package:navolaya_flutter/core/either_extension_function.dart';
import 'package:navolaya_flutter/core/failure.dart';
import 'package:navolaya_flutter/data/apiService/base_api_service.dart';
import 'package:navolaya_flutter/data/model/notification_model.dart';
import 'package:navolaya_flutter/domain/notifications_repository.dart';

import '../../resources/config_file.dart';
import '../apiService/network_api_service.dart';

class NotificationRepositoryImpl implements NotificationsRepository {
  final BaseAPIService _baseAPIService;

  const NotificationRepositoryImpl(this._baseAPIService);

  @override
  Future<Either<Failure, NotificationModel>> fetchNotificationsAPI({int page = 1}) async {
    //--->
    //--->
    //--->

    final possibleData = await _baseAPIService.executeAPI(
        url: ConfigFile.notificationsAPIUrl,
        queryParameters: {'page': page},
        isTokenNeeded: true,
        apiType: ApiType.get);

    if (possibleData.isLeft()) {
      return left(Failure(possibleData.getLeft()!.error));
    }

    final response = possibleData.getRight();
    NotificationModel data = NotificationModel.fromJson(response);
    return right(data);
  }

  @override
  Future<Either<Failure, String>> removeNotificationsAPI() async {
    //--->
    //--->
    //--->

    final possibleData = await _baseAPIService.executeAPI(
        url: ConfigFile.notificationsAPIUrl,
        queryParameters: {},
        isTokenNeeded: true,
        apiType: ApiType.delete);

    if (possibleData.isLeft()) {
      return left(Failure(possibleData.getLeft()!.error));
    }

    final response = possibleData.getRight();
    String data = response['message'];
    return right(data);
  }
}
