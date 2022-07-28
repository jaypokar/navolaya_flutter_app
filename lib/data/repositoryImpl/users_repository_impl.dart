import 'package:dartz/dartz.dart';
import 'package:navolaya_flutter/core/either_extension_function.dart';
import 'package:navolaya_flutter/core/failure.dart';
import 'package:navolaya_flutter/data/apiService/base_api_service.dart';
import 'package:navolaya_flutter/data/model/filter_data_request_model.dart';
import 'package:navolaya_flutter/data/model/update_user_verfication_model.dart';
import 'package:navolaya_flutter/data/model/users_model.dart';
import 'package:navolaya_flutter/domain/users_repository.dart';

import '../../resources/config_file.dart';
import '../apiService/network_api_service.dart';

class UsersRepositoryImpl implements UsersRepository {
  final BaseAPIService _baseAPIService;
  final Map<String, dynamic> _recentFilterMap = FilterDataRequestModel().toJson(FilterType.recent);
  final Map<String, dynamic> _nearByFilterMap = FilterDataRequestModel().toJson(FilterType.nearBy);
  final Map<String, dynamic> _popularFilterMap =
      FilterDataRequestModel().toJson(FilterType.popular);

   UsersRepositoryImpl(this._baseAPIService);

  @override
  Future<Either<Failure, UsersModel>> fetchRecentUsersAPI(
      {required FilterDataRequestModel filterDataRequestData}) async {
    //--->
    //--->
    //--->

    _recentFilterMap['page'] = filterDataRequestData.page;
    if (filterDataRequestData.keyword.isNotEmpty) {
      _recentFilterMap['keyword'] = filterDataRequestData.keyword;
    }
    if (filterDataRequestData.distanceRange != 0.0) {
      _recentFilterMap['distance_range'] = filterDataRequestData.distanceRange;
    }
    if (filterDataRequestData.longitude != 0.0) {
      _recentFilterMap['longitude'] = filterDataRequestData.longitude;
    }
    if (filterDataRequestData.latitude != 0.0) {
      _recentFilterMap['latitude'] = filterDataRequestData.latitude;
    }
    if (filterDataRequestData.toYear.isNotEmpty) {
      _recentFilterMap['to_year'] = filterDataRequestData.toYear;
    }
    if (filterDataRequestData.fromYear.isNotEmpty) {
      _recentFilterMap['from_year'] = filterDataRequestData.fromYear;
    }
    if (filterDataRequestData.gender.isNotEmpty) {
      _recentFilterMap['gender'] = filterDataRequestData.gender;
    }
    if (filterDataRequestData.state.isNotEmpty) {
      _recentFilterMap['state'] = filterDataRequestData.state;
    }
    if (filterDataRequestData.school.isNotEmpty) {
      _recentFilterMap['school'] = filterDataRequestData.school;
    }

    final possibleData = await _baseAPIService.executeAPI(
        url: ConfigFile.getUsersAPIUrl,
        queryParameters: _recentFilterMap,
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
  Future<Either<Failure, UsersModel>> fetchNearByUsersAPI(
      {required FilterDataRequestModel filterDataRequestData}) async {
    //--->
    //--->
    //--->

    _nearByFilterMap['page'] = filterDataRequestData.page;
    if (filterDataRequestData.keyword.isNotEmpty) {
      _nearByFilterMap['keyword'] = filterDataRequestData.keyword;
    }
    if (filterDataRequestData.distanceRange != 0.0) {
      _nearByFilterMap['distance_range'] = filterDataRequestData.distanceRange;
    }
    if (filterDataRequestData.toYear.isNotEmpty) {
      _nearByFilterMap['to_year'] = filterDataRequestData.toYear;
    }
    if (filterDataRequestData.fromYear.isNotEmpty) {
      _nearByFilterMap['from_year'] = filterDataRequestData.fromYear;
    }
    if (filterDataRequestData.gender.isNotEmpty) {
      _nearByFilterMap['gender'] = filterDataRequestData.gender;
    }
    if (filterDataRequestData.state.isNotEmpty) {
      _nearByFilterMap['state'] = filterDataRequestData.state;
    }
    if (filterDataRequestData.school.isNotEmpty) {
      _nearByFilterMap['school'] = filterDataRequestData.school;
    }

    final possibleData = await _baseAPIService.executeAPI(
        url: ConfigFile.getUsersAPIUrl,
        queryParameters: _nearByFilterMap,
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
  Future<Either<Failure, UsersModel>> fetchPopularUsersAPI(
      {required FilterDataRequestModel filterDataRequestData}) async {
    //--->
    //--->
    //--->

    _popularFilterMap['page'] = filterDataRequestData.page;
    if (filterDataRequestData.keyword.isNotEmpty) {
      _popularFilterMap['keyword'] = filterDataRequestData.keyword;
    }
    if (filterDataRequestData.distanceRange != 0.0) {
      _popularFilterMap['distance_range'] = filterDataRequestData.distanceRange;
    }
    if (filterDataRequestData.longitude != 0.0) {
      _popularFilterMap['longitude'] = filterDataRequestData.longitude;
    }
    if (filterDataRequestData.latitude != 0.0) {
      _popularFilterMap['latitude'] = filterDataRequestData.latitude;
    }
    if (filterDataRequestData.toYear.isNotEmpty) {
      _popularFilterMap['to_year'] = filterDataRequestData.toYear;
    }
    if (filterDataRequestData.fromYear.isNotEmpty) {
      _popularFilterMap['from_year'] = filterDataRequestData.fromYear;
    }
    if (filterDataRequestData.gender.isNotEmpty) {
      _popularFilterMap['gender'] = filterDataRequestData.gender;
    }
    if (filterDataRequestData.state.isNotEmpty) {
      _popularFilterMap['state'] = filterDataRequestData.state;
    }
    if (filterDataRequestData.school.isNotEmpty) {
      _popularFilterMap['school'] = filterDataRequestData.school;
    }

    final possibleData = await _baseAPIService.executeAPI(
        url: ConfigFile.getUsersAPIUrl,
        queryParameters: _popularFilterMap,
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
  void updateUserCurrentLocation(double latitude, double longitude) {
    _nearByFilterMap['latitude'] = latitude;
    _nearByFilterMap['longitude'] = longitude;
  }

  @override
  Map<String, dynamic> fetchCachedFilterData() => _nearByFilterMap;

  @override
  void clearFilter() {
    final filterData = FilterDataRequestModel();
    _recentFilterMap['page'] = filterData.page;
    _recentFilterMap['keyword'] = filterData.keyword;
    _recentFilterMap['distance_range'] = filterData.distanceRange;
    _recentFilterMap['longitude'] = filterData.longitude;
    _recentFilterMap['latitude'] = filterData.latitude;
    _recentFilterMap['to_year'] = filterData.toYear;
    _recentFilterMap['from_year'] = filterData.fromYear;
    _recentFilterMap['gender'] = filterData.gender;
    _recentFilterMap['state'] = filterData.state;
    _recentFilterMap['school'] = filterData.school;
    /*****-->**/
    _nearByFilterMap['page'] = filterData.page;
    _nearByFilterMap['keyword'] = filterData.keyword;
    _nearByFilterMap['distance_range'] = filterData.distanceRange;
    _nearByFilterMap['to_year'] = filterData.toYear;
    _nearByFilterMap['from_year'] = filterData.fromYear;
    _nearByFilterMap['gender'] = filterData.gender;
    _nearByFilterMap['state'] = filterData.state;
    _nearByFilterMap['school'] = filterData.school;
    /*****-->**/
    _popularFilterMap['page'] = filterData.page;
    _popularFilterMap['keyword'] = filterData.keyword;
    _popularFilterMap['distance_range'] = filterData.distanceRange;
    _popularFilterMap['longitude'] = filterData.longitude;
    _popularFilterMap['latitude'] = filterData.latitude;
    _popularFilterMap['to_year'] = filterData.toYear;
    _popularFilterMap['from_year'] = filterData.fromYear;
    _popularFilterMap['gender'] = filterData.gender;
    _popularFilterMap['state'] = filterData.state;
    _popularFilterMap['school'] = filterData.school;
  }

  @override
  Future<Either<Failure, UsersModel>> fetchUsersVerificationsAPI({int page = 1}) async {
    final possibleData = await _baseAPIService.executeAPI(
        url: ConfigFile.getUsersVerificationsAPIUrl,
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
  Future<Either<Failure, UpdateUserVerificationModel>> updateUsersVerificationsAPI(
      {required String action, required String userID}) async {
    final possibleData = await _baseAPIService.executeAPI(
        url: ConfigFile.updateUsersVerificationsAPIUrl,
        queryParameters: {'action': action, 'request_user_id': userID},
        isTokenNeeded: true,
        apiType: ApiType.put);

    if (possibleData.isLeft()) {
      return left(Failure(possibleData.getLeft()!.error));
    }

    final response = possibleData.getRight();
    UpdateUserVerificationModel data = UpdateUserVerificationModel.fromJson(response);
    return right(data);
  }
}
