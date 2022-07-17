part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class InitiateValidatePhoneEvent extends AuthEvent {
  final String countryCode;
  final String phone;

  const InitiateValidatePhoneEvent({required this.countryCode, required this.phone});

  @override
  List<Object?> get props => [countryCode, phone];
}

class InitiateVerifyOtpEvent extends AuthEvent {
  final String countryCode;
  final String phone;
  final String otpNumber;

  const InitiateVerifyOtpEvent(
      {required this.countryCode, required this.phone, required this.otpNumber});

  @override
  List<Object?> get props => [countryCode, phone, otpNumber];
}

class InitiateSendOtpEvent extends AuthEvent {
  final String countryCode;
  final String phone;
  final String otpFor;

  const InitiateSendOtpEvent(
      {required this.countryCode, required this.phone, required this.otpFor});

  @override
  List<Object?> get props => [countryCode, phone, otpFor];
}

class InitiateLoginEvent extends AuthEvent {
  final String countryCode;
  final String phone;
  final String password;

  const InitiateLoginEvent(
      {required this.countryCode, required this.phone, required this.password});

  @override
  List<Object?> get props => [countryCode, phone, password];
}

class InitiateUpdateBasicInfoEvent extends AuthEvent {
  final BasicInfoRequestModel basicInfoRequestData;

  const InitiateUpdateBasicInfoEvent({required this.basicInfoRequestData});

  @override
  List<Object?> get props => [basicInfoRequestData];
}

class InitiateUpdateForgotPasswordEvent extends AuthEvent {
  final String countryCode;
  final String phone;
  final String otpNumber;
  final String newPassword;

  const InitiateUpdateForgotPasswordEvent({
    required this.countryCode,
    required this.phone,
    required this.otpNumber,
    required this.newPassword,
  });

  @override
  List<Object?> get props => [countryCode, phone, otpNumber, newPassword];
}
class InitiateLogout extends AuthEvent {
  const InitiateLogout();

  @override
  List<Object?> get props => [];
}
