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
