import 'package:dartz/dartz.dart';
import 'package:navolaya_flutter/core/app_type_def.dart';
import 'package:navolaya_flutter/core/either_extension_function.dart';
import 'package:navolaya_flutter/core/failure.dart';
import 'package:navolaya_flutter/data/apiService/update_ui_mixin.dart';
import 'package:navolaya_flutter/data/model/create_or_update_connection_request_model.dart';
import 'package:navolaya_flutter/data/model/users_model.dart';
import 'package:navolaya_flutter/domain/user_connections_repository.dart';

import '../../resources/config_file.dart';
import '../apiService/base_api_service.dart';
import '../apiService/network_api_service.dart';

class UserConnectionsRepositoryImpl with UpdateUiMixin implements UserConnectionsRepository {
  final BaseAPIService _baseAPIService;

  UserConnectionsRepositoryImpl(this._baseAPIService);

  @override
  Future<Either<Failure, CreateOrUpdateConnectionRequestModel>> createConnectionRequestAPI(
      String userID) async {
    //--->
    //--->
    //--->

    return backToUI<CreateOrUpdateConnectionRequestModel>(() => _baseAPIService.executeAPI(
        url: ConfigFile.connectionRequestsAPIUrl,
        queryParameters: {'requested_user_id': userID},
        isTokenNeeded: true,
        apiType: ApiType.POST));
  }

  @override
  Future<Either<Failure, UsersModel>> getConnectionsAPI(String requestType, {int page = 1}) async {
    //--->
    //--->
    //--->

    return backToUI<UsersModel>(() => _baseAPIService.executeAPI(
        url: ConfigFile.connectionRequestsAPIUrl,
        queryParameters: {'request_type': requestType, 'page': page},
        isTokenNeeded: true,
        apiType: ApiType.GET));
  }

  @override
  Future<Either<Failure, CreateOrUpdateConnectionRequestModel>> removeConnectionAPI(
      String userID) async {
    //--->
    //--->
    //--->

    return backToUI<CreateOrUpdateConnectionRequestModel>(() => _baseAPIService.executeAPI(
        url: ConfigFile.connectionsAPIUrl,
        queryParameters: {'connection_user_id': userID},
        isTokenNeeded: true,
        apiType: ApiType.DELETE));
  }

  @override
  Future<Either<Failure, CreateOrUpdateConnectionRequestModel>> updateConnectionRequestAPI(
      String acceptOrCancel, String userID) async {
    //--->
    //--->
    //--->

    return backToUI<CreateOrUpdateConnectionRequestModel>(() => _baseAPIService.executeAPI(
        url: ConfigFile.connectionRequestsAPIUrl,
        queryParameters: {'action': acceptOrCancel, 'request_user_id': userID},
        isTokenNeeded: true,
        apiType: ApiType.PUT));
  }

  @override
  Future<Either<Failure, UsersModel>> fetchMyConnectionsAPI(
      {int page = 1, String keyword = ''}) async {
    //--->
    //--->
    //--->

    return backToUI<UsersModel>(() => _baseAPIService.executeAPI(
        url: ConfigFile.connectionsAPIUrl,
        queryParameters: {'keyword': keyword.trim(), 'page': page},
        isTokenNeeded: true,
        apiType: ApiType.GET));
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
    if (T == UsersModel) {
      data = UsersModel.fromJson(response) as T;
    } else if (T == CreateOrUpdateConnectionRequestModel) {
      data = CreateOrUpdateConnectionRequestModel.fromJson(response) as T;
    }

    return right(data);
  }
}
