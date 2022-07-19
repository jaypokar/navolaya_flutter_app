part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
}

class ProfileInitial extends ProfileState {
  const ProfileInitial();

  @override
  List<Object> get props => [];
}

class UpdateAdditionalInfoState extends ProfileState {
  final UpdateAdditionalInfoModel updateAdditionalInfo;

  const UpdateAdditionalInfoState({required this.updateAdditionalInfo});

  @override
  List<Object?> get props => [updateAdditionalInfo];
}

class LoadPersonalDetailsState extends ProfileState {
  final LoginAndBasicInfoModel loginAndBasicInfoData;

  const LoadPersonalDetailsState({required this.loginAndBasicInfoData});

  @override
  List<Object?> get props => [loginAndBasicInfoData];
}

class LoadUpdateProfileBasicInfoState extends ProfileState {
  final LoginAndBasicInfoModel loginAndBasicInfoData;

  const LoadUpdateProfileBasicInfoState({required this.loginAndBasicInfoData});

  @override
  List<Object?> get props => [loginAndBasicInfoData];
}

class LoadUpdateSocialMediaLinksState extends ProfileState {
  final SocialMediaProfilesModel socialMediaProfiles;

  const LoadUpdateSocialMediaLinksState({required this.socialMediaProfiles});

  @override
  List<Object?> get props => [socialMediaProfiles];
}

class LoadUpdatePhoneState extends ProfileState {
  final UpdatePhoneModel updatePhoneResponse;

  const LoadUpdatePhoneState({required this.updatePhoneResponse});

  @override
  List<Object?> get props => [updatePhoneResponse];
}

class LoadUpdateOTPState extends ProfileState {
  final UpdateSendOtpModel updateSendOtpResponse;

  const LoadUpdateOTPState({required this.updateSendOtpResponse});

  @override
  List<Object?> get props => [updateSendOtpResponse];
}

class LoadUpdateEmailState extends ProfileState {
  final UpdateEmailModel updateEmailResponse;

  const LoadUpdateEmailState({required this.updateEmailResponse});

  @override
  List<Object?> get props => [updateEmailResponse];
}

class ChangePasswordState extends ProfileState {
  final ChangePasswordModel changePasswordResponse;

  const ChangePasswordState({required this.changePasswordResponse});

  @override
  List<Object?> get props => [changePasswordResponse];
}

class ProfileLoadingState extends ProfileState {
  const ProfileLoadingState();

  @override
  List<Object?> get props => [];
}

class ProfileErrorState extends ProfileState {
  final String message;

  const ProfileErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}
