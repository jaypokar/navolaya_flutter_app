import 'package:dartz/dartz.dart';
import 'package:navolaya_flutter/core/either_extension_function.dart';
import 'package:navolaya_flutter/core/failure.dart';
import 'package:navolaya_flutter/data/model/basic_info_request_model.dart';
import 'package:navolaya_flutter/data/model/login_and_basic_info_model.dart';
import 'package:navolaya_flutter/data/model/update_additional_info_model.dart';
import 'package:navolaya_flutter/data/sessionManager/session_manager.dart';
import 'package:navolaya_flutter/domain/profile_repository.dart';

import '../../core/config_file.dart';
import '../apiService/base_api_service.dart';
import '../apiService/network_api_service.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final BaseAPIService _baseAPIService;
  final SessionManager _sessionManager;

  const ProfileRepositoryImpl(this._baseAPIService, this._sessionManager);

  @override
  Future<Either<Failure, UpdateAdditionalInfoModel>> updateAdditionalInfoAPI(
      {required String house, required String aboutMe, required String birthDate}) async {
    //--->
    //--->
    //--->
    final possibleData = await _baseAPIService.executeAPI(
        url: ConfigFile.updateAdditionalInfoAPIUrl,
        queryParameters: {'house': house, 'about_me': aboutMe, 'birth_date': birthDate},
        isTokenNeeded: true,
        apiType: ApiType.put);

    if (possibleData.isLeft()) {
      return left(Failure(possibleData.getLeft()!.error));
    }

    final response = possibleData.getRight();
    UpdateAdditionalInfoModel data = UpdateAdditionalInfoModel.fromJson(response);

    _sessionManager.updateAdditionalInfo(data);

    return right(data);
  }

  @override
  Future<Either<Failure, LoginAndBasicInfoModel>> updateProfileBasicInfoAPI(
      {required BasicInfoRequestModel basicInfoRequestData}) async {
    //--->
    //--->
    //--->
    final possibleData = await _baseAPIService.executeAPI(
        url: ConfigFile.updateProfileBasicInfoAPIUrl,
        queryParameters: basicInfoRequestData.toJson(),
        isTokenNeeded: true,
        apiType: ApiType.put);

    if (possibleData.isLeft()) {
      return left(Failure(possibleData.getLeft()!.error));
    }

    final response = possibleData.getRight();
    LoginAndBasicInfoModel data = LoginAndBasicInfoModel.fromJson(response);
    await _sessionManager.initiateUserLogin(data);

    return right(data);
  }

  @override
  Future<Either<Failure, LoginAndBasicInfoModel>> fetchPersonalDetails() async {
    if (_sessionManager.getUserDetails() == null) {
      return left(const Failure('No Personal Details available'));
    }
    final data = _sessionManager.getUserDetails();
    return right(data!);
  }
}
