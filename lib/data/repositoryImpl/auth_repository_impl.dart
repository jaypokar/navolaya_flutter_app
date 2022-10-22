import 'package:dartz/dartz.dart';
import 'package:navolaya_flutter/core/app_type_def.dart';
import 'package:navolaya_flutter/core/either_extension_function.dart';
import 'package:navolaya_flutter/core/failure.dart';
import 'package:navolaya_flutter/data/apiService/base_api_service.dart';
import 'package:navolaya_flutter/data/model/basic_info_request_model.dart';
import 'package:navolaya_flutter/data/model/login_and_basic_info_model.dart';
import 'package:navolaya_flutter/data/model/send_otp_model.dart';
import 'package:navolaya_flutter/data/model/update_forgot_password_model.dart';
import 'package:navolaya_flutter/data/model/validate_phone_model.dart';
import 'package:navolaya_flutter/data/model/verify_otp_model.dart';
import 'package:navolaya_flutter/data/sessionManager/session_manager.dart';
import 'package:navolaya_flutter/domain/auth_repository.dart';

import '../../resources/config_file.dart';
import '../apiService/network_api_service.dart';
import '../apiService/update_ui_mixin.dart';

class AuthRepositoryImpl with UpdateUiMixin implements AuthRepository {
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

    return backToUI<LoginAndBasicInfoModel>(() => _baseAPIService.executeAPI(
        url: ConfigFile.loginAPIUrl,
        queryParameters: {
          'country_code': countryCode,
          'phone': phone,
          'password': password,
        },
        isTokenNeeded: false,
        apiType: ApiType.POST));
  }

  @override
  Future<Either<Failure, Unit>> logoutAPI() async {
    //--->
    //--->
    //--->

    return backToUI<Unit>(() => _baseAPIService.executeAPI(
        url: ConfigFile.logoutAPIUrl,
        queryParameters: {},
        isTokenNeeded: true,
        apiType: ApiType.POST));
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

    return backToUI<SendOtpModel>(() => _baseAPIService.executeAPI(
        url: ConfigFile.sendOTPAPIUrl,
        queryParameters: {
          'country_code': countryCode,
          'phone': phone,
          'otp_for': otpFor,
        },
        isTokenNeeded: false,
        apiType: ApiType.POST));
  }

  @override
  Future<Either<Failure, LoginAndBasicInfoModel>> updateBasicInfoAPI({
    required BasicInfoRequestModel basicInfoRequestData,
  }) async {
    //--->
    //--->
    //--->

    return backToUI<LoginAndBasicInfoModel>(() => _baseAPIService.executeAPI(
        url: ConfigFile.updateBasicInfoAPIUrl,
        queryParameters: basicInfoRequestData.toJson(),
        isTokenNeeded: false,
        apiType: ApiType.POST));
  }

  @override
  Future<Either<Failure, UpdateForgotPasswordModel>> updateForgotPasswordAPI(
      {required String countryCode,
      required String phone,
      required String otpNumber,
      required String newPassword}) async {
    //--->
    //--->
    //--->

    return backToUI<UpdateForgotPasswordModel>(() => _baseAPIService.executeAPI(
        url: ConfigFile.updateForgotPasswordAPIUrl,
        queryParameters: {
          'country_code': countryCode,
          'phone': phone,
          'otp_number': otpNumber,
          'new_password': newPassword,
        },
        isTokenNeeded: false,
        apiType: ApiType.POST));
  }

  @override
  Future<Either<Failure, ValidatePhoneModel>> validatePhoneAPI({
    required String countryCode,
    required String phone,
  }) async {
    //--->
    //--->
    //--->

    return backToUI<ValidatePhoneModel>(() => _baseAPIService.executeAPI(
        url: ConfigFile.validatePhoneAPIUrl,
        queryParameters: {'country_code': countryCode, 'phone': phone},
        isTokenNeeded: false,
        apiType: ApiType.POST));
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
    return backToUI<VerifyOtpModel>(() => _baseAPIService.executeAPI(
        url: ConfigFile.verifyOTPAPIUrl,
        queryParameters: {'country_code': countryCode, 'phone': phone, 'otp_number': otpNumber},
        isTokenNeeded: false,
        apiType: ApiType.POST));
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
    if (T == VerifyOtpModel) {
      data = VerifyOtpModel.fromJson(response) as T;
    } else if (T == ValidatePhoneModel) {
      data = ValidatePhoneModel.fromJson(response) as T;
    } else if (T == UpdateForgotPasswordModel) {
      data = UpdateForgotPasswordModel.fromJson(response) as T;
    } else if (T == SendOtpModel) {
      data = SendOtpModel.fromJson(response) as T;
    } else if (T == Unit) {
      data = unit as T;
      await _baseAPIService.initiateLogoutProcess();
    } else if (T == LoginAndBasicInfoModel) {
      data = LoginAndBasicInfoModel.fromJson(response) as T;
      await _sessionManager.initiateUserLogin(data as LoginAndBasicInfoModel);
      //_socketConnectionManager.createSocketConnections();
    }

    return right(data);
  }
}
