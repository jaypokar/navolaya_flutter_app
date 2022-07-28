import 'package:dartz/dartz.dart';
import 'package:navolaya_flutter/data/model/users_model.dart';

import '../core/failure.dart';
import '../data/model/block_user_model.dart';

abstract class BlockedUserRepository {
  Future<Either<Failure, BlockUserModel>> blockUserAPI(
      {required String userID, required String reason});

  Future<Either<Failure, BlockUserModel>> unBlockUserAPI({required String userID});

  Future<Either<Failure, UsersModel>> fetchBlockedUsersAPI({int page = 1});
}
