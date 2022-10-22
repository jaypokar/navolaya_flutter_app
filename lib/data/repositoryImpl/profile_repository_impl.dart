import 'package:dartz/dartz.dart';
import 'package:navolaya_flutter/core/app_type_def.dart';
import 'package:navolaya_flutter/core/either_extension_function.dart';
import 'package:navolaya_flutter/core/failure.dart';
import 'package:navolaya_flutter/data/apiService/update_ui_mixin.dart';
import 'package:navolaya_flutter/data/model/basic_info_request_model.dart';
import 'package:navolaya_flutter/data/model/delete_profile_model.dart';
import 'package:navolaya_flutter/data/model/login_and_basic_info_model.dart';
import 'package:navolaya_flutter/data/model/profile_image_or_allow_notification_model.dart';
import 'package:navolaya_flutter/data/model/social_media_links_request_model.dart';
import 'package:navolaya_flutter/data/model/social_media_profiles_model.dart';
import 'package:navolaya_flutter/data/model/update_additional_info_model.dart';
import 'package:navolaya_flutter/data/model/update_email_model.dart';
import 'package:navolaya_flutter/data/model/update_jnv_verification_model.dart';
import 'package:navolaya_flutter/data/model/update_phone_model.dart';
import 'package:navolaya_flutter/data/sessionManager/session_manager.dart';
import 'package:navolaya_flutter/domain/profile_repository.dart';
import 'package:navolaya_flutter/resources/string_resources.dart';

import '../../resources/config_file.dart';
import '../../resources/value_key_resources.dart';
import '../apiService/base_api_service.dart';
import '../apiService/network_api_service.dart';
import '../model/change_password_model.dart';
import '../model/update_privacy_settings_model.dart' as privacy_settings;
import '../model/update_send_otp_model.dart';

class ProfileRepositoryImpl with UpdateUiMixin implements ProfileRepository {
  final BaseAPIService _baseAPIService;
  final SessionManager _sessionManager;

  const ProfileRepositoryImpl(this._baseAPIService, this._sessionManager);

  @override
  Future<Either<Failure, UpdateAdditionalInfoModel>> updateAdditionalInfoAPI({
    required String house,
    required String aboutMe,
    required String birthDate,
    required String currentAddress,
    required String permanentAddress,
  }) async {
    //--->
    //--->
    //--->

    return backToUI<UpdateAdditionalInfoModel>(() => _baseAPIService.executeAPI(
        url: ConfigFile.updateAdditionalInfoAPIUrl,
        queryParameters: {
          'house': house,
          'about_me': aboutMe,
          'birth_date': birthDate,
          'current_address': currentAddress,
          'permanent_address': permanentAddress
        },
        isTokenNeeded: true,
        apiType: ApiType.PUT));
  }

  @override
  Future<Either<Failure, LoginAndBasicInfoModel>> updateProfileBasicInfoAPI(
      {required BasicInfoRequestModel basicInfoRequestData}) async {
    //--->
    //--->
    //--->

    return backToUI<LoginAndBasicInfoModel>(() => _baseAPIService.executeAPI(
            url: ConfigFile.updateProfileBasicInfoAPIUrl,
            queryParameters: basicInfoRequestData.toJson(),
            isTokenNeeded: true,
            apiType: ApiType.PUT) /*,
        flag: 'isGetProfile'*/
        );
  }

  @override
  Future<Either<Failure, LoginAndBasicInfoModel>> getProfileAPI() async {
    //--->
    //--->
    //--->

    return backToUI<LoginAndBasicInfoModel>(
        () => _baseAPIService.executeAPI(
            url: ConfigFile.getProfileAPIUrl,
            queryParameters: {},
            isTokenNeeded: true,
            apiType: ApiType.GET),
        flag: 'isGetProfile');
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

    return backToUI<SocialMediaProfilesModel>(() => _baseAPIService.executeAPI(
        url: ConfigFile.updateSocialMediaLinksAPIUrl,
        queryParameters: socialMediaLinksRequestData.toJson(),
        isTokenNeeded: true,
        apiType: ApiType.PUT));
  }

  @override
  Future<Either<Failure, UpdatePhoneModel>> updatePhoneAPI(
      {required String code, required String number, required String otpNumber}) async {
    //--->
    //--->
    //--->

    return backToUI<UpdatePhoneModel>(() => _baseAPIService.executeAPI(
        url: ConfigFile.updateMobileNumberAPIUrl,
        queryParameters: {
          'new_country_code': code,
          'new_phone': number,
          'otp_number': otpNumber,
        },
        isTokenNeeded: true,
        apiType: ApiType.PUT));
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

    return backToUI<UpdateSendOtpModel>(() => _baseAPIService.executeAPI(
        url: ConfigFile.updateSendOTPAPIUrl,
        queryParameters: request,
        isTokenNeeded: true,
        apiType: ApiType.POST));
  }

  @override
  Future<Either<Failure, UpdateEmailModel>> updateEmailAPI({
    required String email,
    required String otpNumber,
  }) async {
    //--->
    //--->
    //--->

    return backToUI<UpdateEmailModel>(() => _baseAPIService.executeAPI(
        url: ConfigFile.updateEmailAPIUrl,
        queryParameters: {'new_email': email, 'otp_number': otpNumber},
        isTokenNeeded: true,
        apiType: ApiType.PUT));
  }

  @override
  Future<Either<Failure, ChangePasswordModel>> changePasswordAPI({
    required String oldPassword,
    required String newPassword,
  }) async {
    //--->
    //--->
    //--->

    return backToUI<ChangePasswordModel>(() => _baseAPIService.executeAPI(
        url: ConfigFile.changePasswordAPIUrl,
        queryParameters: {'old_password': oldPassword, 'new_password': newPassword},
        isTokenNeeded: true,
        apiType: ApiType.PUT));
  }

  @override
  Future<Either<Failure, privacy_settings.UpdatePrivacySettingsModel>> updatePrivacySettingsAPI(
      {required Map<String, dynamic> updatePrivacySettingRequestData}) async {
    //--->
    //--->
    //--->

    return backToUI<privacy_settings.UpdatePrivacySettingsModel>(() => _baseAPIService.executeAPI(
        url: ConfigFile.updatePrivacySettingsAPIUrl,
        queryParameters: updatePrivacySettingRequestData,
        isTokenNeeded: true,
        apiType: ApiType.PUT));
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

    return backToUI<DeleteProfileModel>(() => _baseAPIService.executeAPI(
        url: ConfigFile.deleteProfileAPIUrl,
        queryParameters: {},
        isTokenNeeded: true,
        apiType: ApiType.DELETE));
  }

  @override
  Future<Either<Failure, UpdateJnvVerificationModel>> updateJnvVerificationAPI(
      Map<String, dynamic> reqData) {
    //--->
    //--->
    //--->

    return backToUI<UpdateJnvVerificationModel>(() => _baseAPIService.executeAPI(
        url: ConfigFile.updateJNVVerificationAPIUrl,
        queryParameters: reqData,
        isTokenNeeded: true,
        apiType: ApiType.PUT));
  }

  @override
  Future<Either<Failure, ProfileImageOrAllowNotificationModel>>
      updateProfileImageOrAllowNotificationAPI(Map<String, dynamic> reqData) {
    //--->
    //--->
    //--->

    late final Map<String, dynamic> finalReqData;
    if (reqData.containsKey(ValueKeyResources.uploadProfileImageKey)) {
      //finalReqData = {'user_image': jsonEncode(reqData[ValueKeyResources.uploadProfileImageKey])};
      finalReqData = reqData[ValueKeyResources.uploadProfileImageKey] as Map<String, dynamic>;
    } else {
      finalReqData = {'allow_notifications': reqData[ValueKeyResources.allowNotificationsKey]};
    }

    return backToUI<ProfileImageOrAllowNotificationModel>(() => _baseAPIService.executeAPI(
        url: ConfigFile.updateProfileImageOrAllowNotificationAPIUrl,
        queryParameters: finalReqData,
        isTokenNeeded: true,
        apiType: ApiType.PATCH));
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
    if (T == DeleteProfileModel) {
      data = DeleteProfileModel.fromJson(response) as T;
    } else if (T == ChangePasswordModel) {
      data = ChangePasswordModel.fromJson(response) as T;
    } else if (T == UpdateSendOtpModel) {
      data = UpdateSendOtpModel.fromJson(response) as T;
    } else if (T == UpdateJnvVerificationModel) {
      data = UpdateJnvVerificationModel.fromJson(response) as T;
    } else if (T == UpdateAdditionalInfoModel) {
      data = UpdateAdditionalInfoModel.fromJson(response) as T;
      _sessionManager.updateAdditionalInfo(data as UpdateAdditionalInfoModel);
    } else if (T == ProfileImageOrAllowNotificationModel) {
      data = ProfileImageOrAllowNotificationModel.fromJson(response) as T;
      _sessionManager
          .updateProfileImageOrAllowNotificationData(data as ProfileImageOrAllowNotificationModel);
    } else if (T == LoginAndBasicInfoModel) {
      data = LoginAndBasicInfoModel.fromJson(response) as T;
      if (flag.isEmpty) {
        _sessionManager.updateBasicInfo(data as LoginAndBasicInfoModel);
      } else {
        _sessionManager.updateProfileDetailsToSession(data as LoginAndBasicInfoModel);
      }
    } else if (T == SocialMediaProfilesModel) {
      data = SocialMediaProfilesModel.fromJson(response) as T;
      _sessionManager.updateSocialMediaLinks(data as SocialMediaProfilesModel);
    } else if (T == UpdatePhoneModel) {
      data = UpdatePhoneModel.fromJson(response) as T;
      _sessionManager.updateMobileNumber(((data as UpdatePhoneModel).data!.phone!));
    } else if (T == UpdateEmailModel) {
      data = UpdateEmailModel.fromJson(response) as T;
      _sessionManager.updateEmail((data as UpdateEmailModel).data!.email!);
    } else if (T == privacy_settings.UpdatePrivacySettingsModel) {
      data = privacy_settings.UpdatePrivacySettingsModel.fromJson(response) as T;
      if ((data as privacy_settings.UpdatePrivacySettingsModel).data != null) {
        _sessionManager.updatePrivacySettings(data);
      } else {
        return left(const Failure(StringResources.errorTitle));
      }
    }

    return right(data);
  }
}
