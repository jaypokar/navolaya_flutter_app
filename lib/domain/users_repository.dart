import 'package:dartz/dartz.dart';
import 'package:navolaya_flutter/data/model/filter_data_request_model.dart';
import 'package:navolaya_flutter/data/model/users_model.dart';

import '../core/failure.dart';

abstract class UsersRepository {
  Future<Either<Failure, UsersModel>> fetchRecentUsersAPI(
      {required FilterDataRequestModel filterDataRequestData});

  Future<Either<Failure, UsersModel>> fetchNearByUsersAPI(
      {required FilterDataRequestModel filterDataRequestData});

  Future<Either<Failure, UsersModel>> fetchPopularUsersAPI(
      {required FilterDataRequestModel filterDataRequestData});

  Map<String, dynamic> fetchCachedFilterData();

  void updateUserCurrentLocation(double latitude, double longitude);

  void clearFilter();
}
