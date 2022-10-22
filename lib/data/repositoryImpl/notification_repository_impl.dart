import 'package:dartz/dartz.dart';
import 'package:navolaya_flutter/core/app_type_def.dart';
import 'package:navolaya_flutter/core/either_extension_function.dart';
import 'package:navolaya_flutter/core/failure.dart';
import 'package:navolaya_flutter/data/apiService/base_api_service.dart';
import 'package:navolaya_flutter/data/apiService/update_ui_mixin.dart';
import 'package:navolaya_flutter/data/model/notification_model.dart';
import 'package:navolaya_flutter/domain/notifications_repository.dart';

import '../../resources/config_file.dart';
import '../apiService/network_api_service.dart';

class NotificationRepositoryImpl with UpdateUiMixin implements NotificationsRepository {
  final BaseAPIService _baseAPIService;

  const NotificationRepositoryImpl(this._baseAPIService);

  @override
  Future<Either<Failure, NotificationModel>> fetchNotificationsAPI({int page = 1}) async {
    //--->
    //--->
    //--->

    return backToUI<NotificationModel>(() => _baseAPIService.executeAPI(
        url: ConfigFile.notificationsAPIUrl,
        queryParameters: {'page': page},
        isTokenNeeded: true,
        apiType: ApiType.GET));
  }

  @override
  Future<Either<Failure, String>> removeNotificationsAPI() async {
    //--->
    //--->
    //--->

    return backToUI<String>(() => _baseAPIService.executeAPI(
        url: ConfigFile.notificationsAPIUrl,
        queryParameters: {},
        isTokenNeeded: true,
        apiType: ApiType.DELETE));
  }

  @override
  Future<Either<Failure, T>> backToUI<T>(ManageAPIResponse manageAPIResponse,
      {String flag = ''}) async {
    final possibleData = await manageAPIResponse();

    if (possibleData.isLeft()) {
      return left(Failure(possibleData.getLeft()!.error));
    }
    final response = possibleData.getRight();
    late final T data;
    if (T == String) {
      data = response['message'] as T;
    } else if (T == NotificationModel) {
      data = NotificationModel.fromJson(response) as T;
    }

    return right(data);
  }
}
