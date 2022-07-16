import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:navolaya_flutter/core/either_extension_function.dart';
import 'package:navolaya_flutter/core/failure.dart';
import 'package:navolaya_flutter/data/apiService/base_api_service.dart';
import 'package:navolaya_flutter/data/model/basic_info_request_model.dart';
import 'package:navolaya_flutter/data/model/login_and_basic_info_model.dart';
import 'package:navolaya_flutter/data/model/send_otp_model.dart';
import 'package:navolaya_flutter/data/model/update_additional_info_model.dart';
import 'package:navolaya_flutter/data/model/update_forgot_password_model.dart';
import 'package:navolaya_flutter/data/model/validate_phone_model.dart';
import 'package:navolaya_flutter/data/model/verify_otp_model.dart';
import 'package:navolaya_flutter/data/sessionManager/session_manager.dart';
import 'package:navolaya_flutter/domain/auth_repository.dart';

import '../../core/config_file.dart';
import '../apiService/network_api_service.dart';

class AuthRepositoryImpl implements AuthRepository {
  final BaseAPIService _baseAPIService;
  final SessionManager _sessionManager;

  const AuthRepositoryImpl(this._baseAPIService, this._sessionManager);

  @override
  Future<Either<Failure, LoginAndBasicInfoModel>> loginAPI({
    required String countryCode,
    required String phone,
    required String password,
  }) async {
    //--->
    //--->
    //--->
    final possibleData = await _baseAPIService.executeAPI(
        url: ConfigFile.loginAPIUrl,
        queryParameters: {
          'country_code': countryCode,
          'phone': phone,
          'password': password,
        },
        isTokenNeeded: false,
        apiType: ApiType.post);

    if (possibleData.isLeft()) {
      return left(Failure(possibleData.getLeft()!.error));
    }

    final response = possibleData.getRight();
    LoginAndBasicInfoModel data = LoginAndBasicInfoModel.fromJson(response);
    await _sessionManager.initiateUserLogin(data);

    return right(data);
  }

  @override
  Future<Either<Failure, Unit>> logoutAPI() async {
    //--->
    //--->
    //--->
    final possibleData = await _baseAPIService.executeAPI(
        url: ConfigFile.logoutAPIUrl,
        queryParameters: {},
        isTokenNeeded: true,
        apiType: ApiType.put);

    if (possibleData.isLeft()) {
      return left(Failure(possibleData.getLeft()!.error));
    }
    await _baseAPIService.initiateLogoutProcess();
    return right(unit);
  }

  @override
  Future<Either<Failure, SendOtpModel>> sendOtpAPI({
    required String countryCode,
    required String phone,
    required String otpFor,
  }) async {
    //--->
    //--->
    //--->
    final possibleData = await _baseAPIService.executeAPI(
        url: ConfigFile.sendOTPAPIUrl,
        queryParameters: {
          'country_code': countryCode,
          'phone': phone,
          'otp_for': otpFor,
        },
        isTokenNeeded: false,
        apiType: ApiType.post);

    if (possibleData.isLeft()) {
      return left(Failure(possibleData.getLeft()!.error));
    }

    final response = possibleData.getRight();
    SendOtpModel data = SendOtpModel.fromJson(response);

    return right(data);
  }

  @override
  Future<Either<Failure, LoginAndBasicInfoModel>> updateBasicInfoAPI({
    required BasicInfoRequestModel basicInfoRequestData,
  }) async {
    //--->
    //--->
    //--->
    final possibleData = await _baseAPIService.executeAPI(
        url: ConfigFile.updateBasicInfoAPIUrl,
        queryParameters: basicInfoRequestData.toJson(),
        isTokenNeeded: false,
        apiType: ApiType.post);

    if (possibleData.isLeft()) {
      return left(Failure(possibleData.getLeft()!.error));
    }

    final response = possibleData.getRight();
    LoginAndBasicInfoModel data = LoginAndBasicInfoModel.fromJson(response);

    await _sessionManager.initiateUserLogin(data);

    return right(data);
  }

  @override
  Future<Either<Failure, UpdateForgotPasswordModel>> updateForgotPasswordAPI({required String countryCode,
    required String phone,
    required String otpNumber,
    required String newPassword}) async {
    //--->
    //--->
    //--->
    final possibleData = await _baseAPIService.executeAPI(
        url: ConfigFile.updateForgotPasswordAPIUrl,
        queryParameters: {
          'country_code': countryCode,
          'phone': phone,
          'otp_number': otpNumber,
          'new_password': newPassword,
        },
        isTokenNeeded: false,
        apiType: ApiType.post);

    if (possibleData.isLeft()) {
      return left(Failure(possibleData.getLeft()!.error));
    }

    final response = possibleData.getRight();
    UpdateForgotPasswordModel data = UpdateForgotPasswordModel.fromJson(response);

    return right(data);
  }

  @override
  Future<Either<Failure, ValidatePhoneModel>> validatePhoneAPI({
    required String countryCode,
    required String phone,
  }) async {
    //--->
    //--->
    //--->
    final possibleData = await _baseAPIService.executeAPI(
        url: ConfigFile.validatePhoneAPIUrl,
        queryParameters: {'country_code': countryCode, 'phone': phone},
        isTokenNeeded: false,
        apiType: ApiType.post);

    if (possibleData.isLeft()) {
      return left(Failure(possibleData.getLeft()!.error));
    }

    final response = possibleData.getRight();
    ValidatePhoneModel data = ValidatePhoneModel.fromJson(response);

    return right(data);
  }

  @override
  Future<Either<Failure, VerifyOtpModel>> verifyOtpAPI({
    required String countryCode,
    required String phone,
    required String otpNumber,
  }) async {
    //--->
    //--->
    //--->
    final possibleData = await _baseAPIService.executeAPI(
        url: ConfigFile.verifyOTPAPIUrl,
        queryParameters: {'country_code': countryCode, 'phone': phone, 'otp_number': otpNumber},
        isTokenNeeded: false,
        apiType: ApiType.post);

    if (possibleData.isLeft()) {
      return left(Failure(possibleData.getLeft()!.error));
    }

    final response = possibleData.getRight();
    VerifyOtpModel data = VerifyOtpModel.fromJson(response);

    return right(data);
  }

  @override
  Future<Either<Failure, UpdateAdditionalInfoModel>> updateAdditionalInfoAPI(
      {required String userImage,
      required String house,
      required String aboutMe,
      required String birthDate}) async {
    //--->
    //--->
    //--->

    MultipartFile? multiPartData;
    if (userImage.isNotEmpty) {
      final file = File(userImage);
      final String fileName = File(userImage).path.split('/').last;
      multiPartData = await MultipartFile.fromFile(file.path, filename: fileName);
    }

    final possibleData = await _baseAPIService.executeAPI(
        url: ConfigFile.updateAdditionalInfoAPIUrl,
        queryParameters: {
          'user_image': multiPartData,
          'house': house,
          'about_me': aboutMe,
          'birth_date': birthDate
        },
        isTokenNeeded: true,
        apiType: ApiType.put);

    if (possibleData.isLeft()) {
      return left(Failure(possibleData.getLeft()!.error));
    }

    final response = possibleData.getRight();
    UpdateAdditionalInfoModel data = UpdateAdditionalInfoModel.fromJson(response);

    return right(data);
  }
}
