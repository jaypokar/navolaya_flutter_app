import 'package:dartz/dartz.dart';
import 'package:navolaya_flutter/core/failure.dart';
import 'package:navolaya_flutter/data/model/basic_info_request_model.dart';
import 'package:navolaya_flutter/data/model/change_password_model.dart';
import 'package:navolaya_flutter/data/model/delete_profile_model.dart';
import 'package:navolaya_flutter/data/model/login_and_basic_info_model.dart';
import 'package:navolaya_flutter/data/model/profile_image_or_allow_notification_model.dart';
import 'package:navolaya_flutter/data/model/social_media_links_request_model.dart';
import 'package:navolaya_flutter/data/model/social_media_profiles_model.dart';
import 'package:navolaya_flutter/data/model/update_email_model.dart';
import 'package:navolaya_flutter/data/model/update_jnv_verification_model.dart';
import 'package:navolaya_flutter/data/model/update_phone_model.dart';
import 'package:navolaya_flutter/data/model/update_privacy_settings_model.dart' as privacy_settings;
import 'package:navolaya_flutter/data/model/update_send_otp_model.dart';

import '../data/model/update_additional_info_model.dart';

abstract class ProfileRepository {
  Future<Either<Failure, UpdateAdditionalInfoModel>> updateAdditionalInfoAPI(
      {required String house,
      required String aboutMe,
      required String birthDate,
      required String currentAddress,
      required String permanentAddress});

  Future<Either<Failure, LoginAndBasicInfoModel>> fetchPersonalDetails();

  Future<Either<Failure, LoginAndBasicInfoModel>> updateProfileBasicInfoAPI(
      {required BasicInfoRequestModel basicInfoRequestData});

  Future<Either<Failure, SocialMediaProfilesModel>> updateSocialMediaLinksAPI(
      {required SocialMediaLinksRequestModel socialMediaLinksRequestData});

  Future<Either<Failure, UpdateSendOtpModel>> sendOtpAPI(
      {required String code, required String phoneNumber, required String email});

  Future<Either<Failure, UpdatePhoneModel>> updatePhoneAPI(
      {required String code, required String number, required String otpNumber});

  Future<Either<Failure, UpdateEmailModel>> updateEmailAPI(
      {required String email, required String otpNumber});

  Future<Either<Failure, ChangePasswordModel>> changePasswordAPI(
      {required String oldPassword, required String newPassword});

  Future<Either<Failure, privacy_settings.UpdatePrivacySettingsModel>> updatePrivacySettingsAPI(
      {required Map<String, dynamic> updatePrivacySettingRequestData});

  Either<Failure, DisplaySettings> fetchPrivacySettings();

  Future<Either<Failure, DeleteProfileModel>> deleteProfile();

  Future<Either<Failure, UpdateJnvVerificationModel>> updateJnvVerificationAPI(
      Map<String, dynamic> reqData);

  Future<Either<Failure, ProfileImageOrAllowNotificationModel>>
      updateProfileImageOrAllowNotificationAPI(Map<String, dynamic> reqData);

  Future<Either<Failure, LoginAndBasicInfoModel>> getProfileAPI();
}
