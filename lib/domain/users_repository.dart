import 'package:dartz/dartz.dart';
import 'package:navolaya_flutter/data/model/filter_data_request_model.dart';
import 'package:navolaya_flutter/data/model/users_model.dart';

import '../core/failure.dart';
import '../data/model/update_user_verfication_model.dart';

abstract class UsersRepository {
  Future<Either<Failure, UsersModel>> fetchRecentUsersAPI(
      {required FilterDataRequestModel filterDataRequestData});

  Future<Either<Failure, UsersModel>> fetchNearByUsersAPI(
      {required FilterDataRequestModel filterDataRequestData});

  Future<Either<Failure, UsersModel>> fetchPopularUsersAPI(
      {required FilterDataRequestModel filterDataRequestData});

  Future<Either<Failure, UsersModel>> fetchUsersVerificationsAPI({int page = 1});

  Future<Either<Failure, UpdateUserVerificationModel>> updateUsersVerificationsAPI(
      {required String action, required String userID});

  Map<String, dynamic> fetchCachedFilterData();

  void updateUserCurrentLocation(double latitude, double longitude);

  void clearFilter();
}
