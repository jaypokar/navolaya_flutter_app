import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:navolaya_flutter/core/logger.dart';
import 'package:navolaya_flutter/data/model/basic_info_request_model.dart';
import 'package:navolaya_flutter/data/model/login_and_basic_info_model.dart';
import 'package:navolaya_flutter/data/model/send_otp_model.dart';
import 'package:navolaya_flutter/data/model/update_forgot_password_model.dart';
import 'package:navolaya_flutter/data/model/validate_phone_model.dart';
import 'package:navolaya_flutter/data/model/verify_otp_model.dart';

import '../../../domain/auth_repository.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _repository;

  AuthBloc(this._repository) : super(const AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      emit(const AuthLoadingState());
      try {
        late final AuthState data;

        if (event is InitiateValidatePhoneEvent) {
          final possibleData = await _repository.validatePhoneAPI(
            countryCode: event.countryCode,
            phone: event.phone,
          );
          data = possibleData.fold(
            (l) => AuthErrorState(message: l.error),
            (r) => ValidatePhoneState(validatePhoneData: r),
          );
        } else if (event is InitiateVerifyOtpEvent) {
          final possibleData = await _repository.verifyOtpAPI(
            countryCode: event.countryCode,
            phone: event.phone,
            otpNumber: event.otpNumber,
          );
          data = possibleData.fold(
            (l) => AuthErrorState(message: l.error),
            (r) => VerifyOtpState(verifyOtpData: r),
          );
        } else if (event is InitiateSendOtpEvent) {
          final possibleData = await _repository.sendOtpAPI(
            countryCode: event.countryCode,
            phone: event.phone,
            otpFor: event.otpFor,
          );
          data = possibleData.fold(
            (l) => AuthErrorState(message: l.error),
            (r) => SendOtpState(sendOtpData: r),
          );
        } else if (event is InitiateLoginEvent) {
          final possibleData = await _repository.loginAPI(
            countryCode: event.countryCode,
            phone: event.phone,
            password: event.password,
          );
          data = possibleData.fold(
            (l) => AuthErrorState(message: l.error),
            (r) => LoginState(loginAndBasicInfoData: r),
          );
        } else if (event is InitiateUpdateBasicInfoEvent) {
          final possibleData = await _repository.updateBasicInfoAPI(
            basicInfoRequestData: event.basicInfoRequestData,
          );
          data = possibleData.fold(
            (l) => AuthErrorState(message: l.error),
            (r) => UpdateBasicInfoState(loginAndBasicInfoData: r),
          );
        } else if (event is InitiateUpdateForgotPasswordEvent) {
          final possibleData = await _repository.updateForgotPasswordAPI(
            countryCode: event.countryCode,
            phone: event.phone,
            otpNumber: event.otpNumber,
            newPassword: event.newPassword,
          );
          data = possibleData.fold(
            (l) => AuthErrorState(message: l.error),
            (r) => UpdateForgotPasswordState(updateForgotPasswordData: r),
          );
        }

        emit(data);
      } catch (e) {
        logger.e(e.toString());
        emit(AuthErrorState(message: e.toString()));
      }
    });
  }
}
