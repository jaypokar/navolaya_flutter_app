import 'package:dartz/dartz.dart';
import 'package:navolaya_flutter/core/either_extension_function.dart';
import 'package:navolaya_flutter/core/failure.dart';
import 'package:navolaya_flutter/data/model/create_or_update_connection_request_model.dart';
import 'package:navolaya_flutter/data/model/users_model.dart';
import 'package:navolaya_flutter/domain/user_connections_repository.dart';

import '../../resources/config_file.dart';
import '../apiService/base_api_service.dart';
import '../apiService/network_api_service.dart';

class UserConnectionsRepositoryImpl implements UserConnectionsRepository {
  final BaseAPIService _baseAPIService;

  UserConnectionsRepositoryImpl(this._baseAPIService);

  @override
  Future<Either<Failure, CreateOrUpdateConnectionRequestModel>> createConnectionRequestAPI(
      String userID) async {
    //--->
    //--->
    //--->

    final possibleData = await _baseAPIService.executeAPI(
        url: ConfigFile.createConnectionRequestAPIUrl,
        queryParameters: {'requested_user_id': userID},
        isTokenNeeded: true,
        apiType: ApiType.post);

    if (possibleData.isLeft()) {
      return left(Failure(possibleData.getLeft()!.error));
    }

    final response = possibleData.getRight();
    CreateOrUpdateConnectionRequestModel data =
        CreateOrUpdateConnectionRequestModel.fromJson(response);
    return right(data);
  }

  @override
  Future<Either<Failure, UsersModel>> getConnectionsAPI(String requestType, {int page = 1}) async {
    //--->
    //--->
    //--->

    final possibleData = await _baseAPIService.executeAPI(
        url: ConfigFile.getConnectionRequestAPIUrl,
        queryParameters: {'request_type': requestType, 'page': page},
        isTokenNeeded: true,
        apiType: ApiType.get);

    if (possibleData.isLeft()) {
      return left(Failure(possibleData.getLeft()!.error));
    }

    final response = possibleData.getRight();
    UsersModel data = UsersModel.fromJson(response);
    return right(data);
  }

  @override
  Future<Either<Failure, CreateOrUpdateConnectionRequestModel>> removeConnectionAPI(
      String userID) async {
    //--->
    //--->
    //--->

    final possibleData = await _baseAPIService.executeAPI(
        url: ConfigFile.removeConnectionAPIUrl,
        queryParameters: {'connection_user_id': userID},
        isTokenNeeded: true,
        apiType: ApiType.delete);

    if (possibleData.isLeft()) {
      return left(Failure(possibleData.getLeft()!.error));
    }

    final response = possibleData.getRight();
    CreateOrUpdateConnectionRequestModel data =
        CreateOrUpdateConnectionRequestModel.fromJson(response);
    return right(data);
  }

  @override
  Future<Either<Failure, CreateOrUpdateConnectionRequestModel>> updateConnectionRequestAPI(
      String acceptOrCancel, String userID) async {
    //--->
    //--->
    //--->

    final possibleData = await _baseAPIService.executeAPI(
        url: ConfigFile.updateConnectionRequestAPIUrl,
        queryParameters: {'action': acceptOrCancel, 'request_user_id': userID},
        isTokenNeeded: true,
        apiType: ApiType.delete);

    if (possibleData.isLeft()) {
      return left(Failure(possibleData.getLeft()!.error));
    }

    final response = possibleData.getRight();
    CreateOrUpdateConnectionRequestModel data =
        CreateOrUpdateConnectionRequestModel.fromJson(response);
    return right(data);
  }

  @override
  Future<Either<Failure, UsersModel>> fetchMyConnectionsAPI(
      {int page = 1, String keyword = ''}) async {
    //--->
    //--->
    //--->

    final possibleData = await _baseAPIService.executeAPI(
        url: ConfigFile.myConnectionAPIUrl,
        queryParameters: {'keyword': keyword, 'page': page},
        isTokenNeeded: true,
        apiType: ApiType.get);

    if (possibleData.isLeft()) {
      return left(Failure(possibleData.getLeft()!.error));
    }

    final response = possibleData.getRight();
    UsersModel data = UsersModel.fromJson(response);
    return right(data);
  }
}
