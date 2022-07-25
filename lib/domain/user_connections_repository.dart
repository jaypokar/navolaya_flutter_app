import 'package:dartz/dartz.dart';
import 'package:navolaya_flutter/core/failure.dart';
import 'package:navolaya_flutter/data/model/create_or_update_connection_request_model.dart';
import 'package:navolaya_flutter/data/model/users_model.dart';

abstract class UserConnectionsRepository {
  Future<Either<Failure, CreateOrUpdateConnectionRequestModel>> createConnectionRequestAPI(
      String userID);

  Future<Either<Failure, CreateOrUpdateConnectionRequestModel>> updateConnectionRequestAPI(
      String acceptOrCancel, String userID);

  Future<Either<Failure, CreateOrUpdateConnectionRequestModel>> removeConnectionAPI(String userID);

  Future<Either<Failure, UsersModel>> getConnectionsAPI(String requestType, {int page = 1});
}
