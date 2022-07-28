import 'package:dartz/dartz.dart';
import 'package:navolaya_flutter/core/either_extension_function.dart';
import 'package:navolaya_flutter/core/failure.dart';
import 'package:navolaya_flutter/data/model/block_user_model.dart';
import 'package:navolaya_flutter/data/model/users_model.dart';
import 'package:navolaya_flutter/domain/blocked_users_repository.dart';

import '../../resources/config_file.dart';
import '../apiService/base_api_service.dart';
import '../apiService/network_api_service.dart';

class BlockedUserRepositoryImpl implements BlockedUserRepository {
  final BaseAPIService _baseAPIService;

  const BlockedUserRepositoryImpl(this._baseAPIService);

  @override
  Future<Either<Failure, UsersModel>> fetchBlockedUsersAPI({int page = 1}) async {
    //--->
    //--->
    //--->

    final possibleData = await _baseAPIService.executeAPI(
        url: ConfigFile.fetchBlockedUsersAPIUrl,
        queryParameters: {'page': page},
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
  Future<Either<Failure, BlockUserModel>> blockUserAPI(
      {required String userID, required String reason}) async {
    //--->
    //--->
    //--->

    final possibleData = await _baseAPIService.executeAPI(
        url: ConfigFile.blockUserAPIUrl,
        queryParameters: {'block_user_id': userID, 'reason': reason},
        isTokenNeeded: true,
        apiType: ApiType.post);

    if (possibleData.isLeft()) {
      return left(Failure(possibleData.getLeft()!.error));
    }

    final response = possibleData.getRight();
    BlockUserModel data = BlockUserModel.fromJson(response);
    return right(data);
  }

  @override
  Future<Either<Failure, BlockUserModel>> unBlockUserAPI({required String userID}) async {
    //--->
    //--->
    //--->

    final possibleData = await _baseAPIService.executeAPI(
        url: ConfigFile.unBlockUsersAPIUrl,
        queryParameters: {'block_user_id': userID},
        isTokenNeeded: true,
        apiType: ApiType.put);

    if (possibleData.isLeft()) {
      return left(Failure(possibleData.getLeft()!.error));
    }

    final response = possibleData.getRight();
    BlockUserModel data = BlockUserModel.fromJson(response);
    return right(data);
  }
}
