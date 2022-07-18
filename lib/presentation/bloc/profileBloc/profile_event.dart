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

class FetchPersonalDetails extends ProfileEvent {
  const FetchPersonalDetails();

  @override
  List<Object?> get props => [];
}
