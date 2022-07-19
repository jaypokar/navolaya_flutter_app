import 'package:dartz/dartz.dart';
import 'package:navolaya_flutter/core/failure.dart';
import 'package:navolaya_flutter/data/model/basic_info_request_model.dart';
import 'package:navolaya_flutter/data/model/change_password_model.dart';
import 'package:navolaya_flutter/data/model/login_and_basic_info_model.dart';
import 'package:navolaya_flutter/data/model/social_media_links_request_model.dart';
import 'package:navolaya_flutter/data/model/social_media_profiles_model.dart';
import 'package:navolaya_flutter/data/model/update_email_model.dart';
import 'package:navolaya_flutter/data/model/update_phone_model.dart';
import 'package:navolaya_flutter/data/model/update_send_otp_model.dart';

import '../data/model/update_additional_info_model.dart';

abstract class ProfileRepository {
  Future<Either<Failure, UpdateAdditionalInfoModel>> updateAdditionalInfoAPI(
      {required String house, required String aboutMe, required String birthDate});

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
}
