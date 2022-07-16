part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  const AuthInitial();

  @override
  List<Object> get props => [];
}

class AuthLoadingState extends AuthState {
  const AuthLoadingState();

  @override
  List<Object?> get props => [];
}

class AuthErrorState extends AuthState {
  final String message;

  const AuthErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class ValidatePhoneState extends AuthState {
  final ValidatePhoneModel validatePhoneData;

  const ValidatePhoneState({required this.validatePhoneData});

  @override
  List<Object?> get props => [validatePhoneData];
}

class VerifyOtpState extends AuthState {
  final VerifyOtpModel verifyOtpData;

  const VerifyOtpState({required this.verifyOtpData});

  @override
  List<Object?> get props => [verifyOtpData];
}

class SendOtpState extends AuthState {
  final SendOtpModel sendOtpData;

  const SendOtpState({required this.sendOtpData});

  @override
  List<Object?> get props => [sendOtpData];
}

class LoginState extends AuthState {
  final LoginAndBasicInfoModel loginAndBasicInfoData;

  const LoginState({required this.loginAndBasicInfoData});

  @override
  List<Object?> get props => [loginAndBasicInfoData];
}

class UpdateBasicInfoState extends AuthState {
  final LoginAndBasicInfoModel loginAndBasicInfoData;

  const UpdateBasicInfoState({required this.loginAndBasicInfoData});

  @override
  List<Object?> get props => [loginAndBasicInfoData];
}

class UpdateForgotPasswordState extends AuthState {
  final UpdateForgotPasswordModel updateForgotPasswordData;

  const UpdateForgotPasswordState({required this.updateForgotPasswordData});

  @override
  List<Object?> get props => [updateForgotPasswordData];
}

class UpdateAdditionalInfoState extends AuthState {
  final UpdateAdditionalInfoModel updateAdditionalInfo;

  const UpdateAdditionalInfoState({required this.updateAdditionalInfo});

  @override
  List<Object?> get props => [updateAdditionalInfo];
}

class LogoutState extends AuthState {
  const LogoutState();

  @override
  List<Object?> get props => [];
}
