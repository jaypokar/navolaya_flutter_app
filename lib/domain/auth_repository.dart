import 'package:dartz/dartz.dart';
import 'package:navolaya_flutter/core/failure.dart';
import 'package:navolaya_flutter/data/model/basic_info_request_model.dart';
import 'package:navolaya_flutter/data/model/login_and_basic_info_model.dart';
import 'package:navolaya_flutter/data/model/update_additional_info_model.dart';
import 'package:navolaya_flutter/data/model/update_forgot_password_model.dart';
import 'package:navolaya_flutter/data/model/validate_phone_model.dart';
import 'package:navolaya_flutter/data/model/verify_otp_model.dart';

import '../data/model/send_otp_model.dart';

abstract class AuthRepository {
  Future<Either<Failure, ValidatePhoneModel>> validatePhoneAPI({
    required String countryCode,
    required String phone,
  });

  Future<Either<Failure, VerifyOtpModel>> verifyOtpAPI({
    required String countryCode,
    required String phone,
    required String otpNumber,
  });

  Future<Either<Failure, SendOtpModel>> sendOtpAPI({
    required String countryCode,
    required String phone,
    required String otpFor,
  });

  Future<Either<Failure, LoginAndBasicInfoModel>> loginAPI({
    required String countryCode,
    required String phone,
    required String password,
  });

  Future<Either<Failure, LoginAndBasicInfoModel>> updateBasicInfoAPI(
      {required BasicInfoRequestModel basicInfoRequestData});

  Future<Either<Failure, UpdateForgotPasswordModel>> updateForgotPasswordAPI(
      {required String countryCode,
      required String phone,
      required String otpNumber,
      required String newPassword});

  Future<Either<Failure, UpdateAdditionalInfoModel>> updateAdditionalInfoAPI(
      {required String userImage,
      required String house,
      required String aboutMe,
      required String birthDate});

  Future<Either<Failure, Unit>> logoutAPI();
}
