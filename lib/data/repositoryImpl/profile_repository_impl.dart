import 'package:dartz/dartz.dart';
import 'package:navolaya_flutter/core/either_extension_function.dart';
import 'package:navolaya_flutter/core/failure.dart';
import 'package:navolaya_flutter/data/model/basic_info_request_model.dart';
import 'package:navolaya_flutter/data/model/delete_profile_model.dart';
import 'package:navolaya_flutter/data/model/login_and_basic_info_model.dart';
import 'package:navolaya_flutter/data/model/social_media_links_request_model.dart';
import 'package:navolaya_flutter/data/model/social_media_profiles_model.dart';
import 'package:navolaya_flutter/data/model/update_additional_info_model.dart';
import 'package:navolaya_flutter/data/model/update_email_model.dart';
import 'package:navolaya_flutter/data/model/update_phone_model.dart';
import 'package:navolaya_flutter/data/sessionManager/session_manager.dart';
import 'package:navolaya_flutter/domain/profile_repository.dart';
import 'package:navolaya_flutter/resources/string_resources.dart';

import '../../resources/config_file.dart';
import '../apiService/base_api_service.dart';
import '../apiService/network_api_service.dart';
import '../model/change_password_model.dart';
import '../model/update_privacy_settings_model.dart' as privacy_settings;
import '../model/update_send_otp_model.dart';

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
    _sessionManager.updateBasicInfo(data);

    return right(data);
  }

  @override
  Future<Either<Failure, LoginAndBasicInfoModel>> fetchPersonalDetails() async {
    if (_sessionManager.getUserDetails() == null) {
      return left(const Failure('No Personal Details available'));
    }

    final data = _sessionManager.getUserDetails();
    //logger.i('the loginDetails is ${json.decode(data.toString())}');
    return right(data!);
  }

  @override
  Future<Either<Failure, SocialMediaProfilesModel>> updateSocialMediaLinksAPI({
    required SocialMediaLinksRequestModel socialMediaLinksRequestData,
  }) async {
    //--->
    //--->
    //--->
    final possibleData = await _baseAPIService.executeAPI(
        url: ConfigFile.updateSocialMediaLinksAPIUrl,
        queryParameters: socialMediaLinksRequestData.toJson(),
        isTokenNeeded: true,
        apiType: ApiType.put);

    if (possibleData.isLeft()) {
      return left(Failure(possibleData.getLeft()!.error));
    }

    final response = possibleData.getRight();
    SocialMediaProfilesModel data = SocialMediaProfilesModel.fromJson(response);
    _sessionManager.updateSocialMediaLinks(data);

    return right(data);
  }

  @override
  Future<Either<Failure, UpdatePhoneModel>> updatePhoneAPI(
      {required String code, required String number, required String otpNumber}) async {
    //--->
    //--->
    //--->
    final possibleData = await _baseAPIService.executeAPI(
        url: ConfigFile.updateMobileNumberAPIUrl,
        queryParameters: {
          'new_country_code': code,
          'new_phone': number,
          'otp_number': otpNumber,
        },
        isTokenNeeded: true,
        apiType: ApiType.put);

    if (possibleData.isLeft()) {
      return left(Failure(possibleData.getLeft()!.error));
    }

    final response = possibleData.getRight();
    UpdatePhoneModel data = UpdatePhoneModel.fromJson(response);
    _sessionManager.updateMobileNumber(data.data!.phone!);

    return right(data);
  }

  @override
  Future<Either<Failure, UpdateSendOtpModel>> sendOtpAPI({
    required String code,
    required String phoneNumber,
    required String email,
  }) async {
    //--->
    //--->
    //--->
    final request = phoneNumber.isEmpty
        ? {'new_email': email, 'otp_for': 'update_email'}
        : {'new_country_code': code, 'new_phone': phoneNumber, 'otp_for': 'update_phone'};

    final possibleData = await _baseAPIService.executeAPI(
        url: ConfigFile.updateSendOTPAPIUrl,
        queryParameters: request,
        isTokenNeeded: true,
        apiType: ApiType.post);

    if (possibleData.isLeft()) {
      return left(Failure(possibleData.getLeft()!.error));
    }

    final response = possibleData.getRight();
    UpdateSendOtpModel data = UpdateSendOtpModel.fromJson(response);

    return right(data);
  }

  @override
  Future<Either<Failure, UpdateEmailModel>> updateEmailAPI({
    required String email,
    required String otpNumber,
  }) async {
    //--->
    //--->
    //--->
    final possibleData = await _baseAPIService.executeAPI(
        url: ConfigFile.updateEmailAPIUrl,
        queryParameters: {'new_email': email, 'otp_number': otpNumber},
        isTokenNeeded: true,
        apiType: ApiType.put);

    if (possibleData.isLeft()) {
      return left(Failure(possibleData.getLeft()!.error));
    }

    final response = possibleData.getRight();
    UpdateEmailModel data = UpdateEmailModel.fromJson(response);
    _sessionManager.updateEmail(data.data!.email!);

    return right(data);
  }

  @override
  Future<Either<Failure, ChangePasswordModel>> changePasswordAPI({
    required String oldPassword,
    required String newPassword,
  }) async {
    //--->
    //--->
    //--->
    final possibleData = await _baseAPIService.executeAPI(
        url: ConfigFile.changePasswordAPIUrl,
        queryParameters: {'old_password': oldPassword, 'new_password': newPassword},
        isTokenNeeded: true,
        apiType: ApiType.put);

    if (possibleData.isLeft()) {
      return left(Failure(possibleData.getLeft()!.error));
    }

    final response = possibleData.getRight();
    ChangePasswordModel data = ChangePasswordModel.fromJson(response);

    return right(data);
  }

  @override
  Future<Either<Failure, privacy_settings.UpdatePrivacySettingsModel>> updatePrivacySettingsAPI(
      {required Map<String, dynamic> updatePrivacySettingRequestData}) async {
    //--->
    //--->
    //--->
    final possibleData = await _baseAPIService.executeAPI(
        url: ConfigFile.updatePrivacySettingsAPIUrl,
        queryParameters: updatePrivacySettingRequestData,
        isTokenNeeded: true,
        apiType: ApiType.put);

    if (possibleData.isLeft()) {
      return left(Failure(possibleData.getLeft()!.error));
    }

    final response = possibleData.getRight();
    privacy_settings.UpdatePrivacySettingsModel data =
        privacy_settings.UpdatePrivacySettingsModel.fromJson(response);

    if (data.data != null) {
      _sessionManager.updatePrivacySettings(data);
    } else {
      return left(const Failure(StringResources.errorTitle));
    }

    return right(data);
  }

  @override
  Either<Failure, DisplaySettings> fetchPrivacySettings() {
    late final DisplaySettings? displaySettings;
    if (_sessionManager.getUserDetails() != null) {
      displaySettings = _sessionManager.getUserDetails()!.data!.displaySettings;
    } else {
      return left(const Failure(StringResources.errorTitle));
    }

    if (displaySettings != null) {
      return right(displaySettings);
    }
    return left(const Failure(StringResources.errorTitle));
  }

  @override
  Future<Either<Failure, DeleteProfileModel>> deleteProfile() async {
    //--->
    //--->
    //--->
    final possibleData = await _baseAPIService.executeAPI(
        url: ConfigFile.deleteProfileAPIUrl,
        queryParameters: {},
        isTokenNeeded: true,
        apiType: ApiType.delete);

    if (possibleData.isLeft()) {
      return left(Failure(possibleData.getLeft()!.error));
    }

    final response = possibleData.getRight();
    DeleteProfileModel data = DeleteProfileModel.fromJson(response);
    return right(data);
  }
}
