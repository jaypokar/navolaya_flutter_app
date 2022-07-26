part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
}

class InitiateUpdateAdditionalInfo extends ProfileEvent {
  final String house;
  final String birthDate;
  final String aboutMe;

  const InitiateUpdateAdditionalInfo({
    required this.house,
    required this.birthDate,
    required this.aboutMe,
  });

  @override
  List<Object?> get props => [house, birthDate, aboutMe];
}

class UpdateProfileBasicInfoEvent extends ProfileEvent {
  final BasicInfoRequestModel basicInfoRequestData;

  const UpdateProfileBasicInfoEvent({required this.basicInfoRequestData});

  @override
  List<Object?> get props => [basicInfoRequestData];
}

class UpdateSocialMediaProfileLinksEvent extends ProfileEvent {
  final SocialMediaLinksRequestModel socialMediaLinksRequestData;

  const UpdateSocialMediaProfileLinksEvent({required this.socialMediaLinksRequestData});

  @override
  List<Object?> get props => [socialMediaLinksRequestData];
}

class UpdatePhoneEvent extends ProfileEvent {
  final String countryCode;
  final String mobileNumber;
  final String otpNumber;

  const UpdatePhoneEvent(
      {required this.countryCode, required this.mobileNumber, required this.otpNumber});

  @override
  List<Object?> get props => [countryCode, mobileNumber, otpNumber];
}

class UpdateEmailEvent extends ProfileEvent {
  final String email;
  final String otpNumber;

  const UpdateEmailEvent({required this.email, required this.otpNumber});

  @override
  List<Object?> get props => [email, otpNumber];
}

class SendOTPEvent extends ProfileEvent {
  final String countryCode;
  final String mobileNumber;
  final String email;

  const SendOTPEvent({required this.countryCode, required this.mobileNumber, required this.email});

  @override
  List<Object?> get props => [countryCode, mobileNumber, email];
}

class ChangePasswordEvent extends ProfileEvent {
  final String oldPassword;
  final String newPassword;

  const ChangePasswordEvent({required this.oldPassword, required this.newPassword});

  @override
  List<Object?> get props => [oldPassword, newPassword];
}

class UpdatePrivacySettingEvent extends ProfileEvent {
  const UpdatePrivacySettingEvent();

  @override
  List<Object?> get props => [];
}

class FetchPrivacySettingEvent extends ProfileEvent {
  const FetchPrivacySettingEvent();

  @override
  List<Object?> get props => [];
}

class DeleteProfileEvent extends ProfileEvent {
  const DeleteProfileEvent();

  @override
  List<Object?> get props => [];
}

class FetchPersonalDetails extends ProfileEvent {
  const FetchPersonalDetails();

  @override
  List<Object?> get props => [];
}
