import 'package:dartz/dartz.dart';
import 'package:navolaya_flutter/core/app_type_def.dart';
import 'package:navolaya_flutter/core/either_extension_function.dart';
import 'package:navolaya_flutter/core/failure.dart';
import 'package:navolaya_flutter/data/apiService/update_ui_mixin.dart';
import 'package:navolaya_flutter/data/model/block_user_model.dart';
import 'package:navolaya_flutter/data/model/users_model.dart';
import 'package:navolaya_flutter/domain/blocked_users_repository.dart';

import '../../resources/config_file.dart';
import '../apiService/base_api_service.dart';
import '../apiService/network_api_service.dart';

class BlockedUserRepositoryImpl with UpdateUiMixin implements BlockedUserRepository {
  final BaseAPIService _baseAPIService;

  const BlockedUserRepositoryImpl(this._baseAPIService);

  @override
  Future<Either<Failure, UsersModel>> fetchBlockedUsersAPI({int page = 1}) async {
    //--->
    //--->
    //--->

    return backToUI<UsersModel>(() => _baseAPIService.executeAPI(
        url: ConfigFile.blockUserAPIUrl,
        queryParameters: {'page': page},
        isTokenNeeded: true,
        apiType: ApiType.GET));
  }

  @override
  Future<Either<Failure, BlockUserModel>> blockUserAPI(
      {required String userID, required String reason}) async {
    //--->
    //--->
    //--->

    return backToUI(() => _baseAPIService.executeAPI(
        url: ConfigFile.blockUserAPIUrl,
        queryParameters: {'block_user_id': userID, 'reason': reason},
        isTokenNeeded: true,
        apiType: ApiType.POST));
  }

  @override
  Future<Either<Failure, BlockUserModel>> unBlockUserAPI({required String userID}) async {
    //--->
    //--->
    //--->

    return backToUI<BlockUserModel>(() => _baseAPIService.executeAPI(
        url: ConfigFile.blockUserAPIUrl,
        queryParameters: {'block_user_id': userID},
        isTokenNeeded: true,
        apiType: ApiType.PUT));
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
    if (T == BlockUserModel) {
      data = BlockUserModel.fromJson(response) as T;
    } else if (T == UsersModel) {
      data = UsersModel.fromJson(response) as T;
    }

    return right(data);
  }
}
