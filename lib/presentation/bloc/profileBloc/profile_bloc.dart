import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navolaya_flutter/data/model/basic_info_request_model.dart';
import 'package:navolaya_flutter/data/model/change_password_model.dart';
import 'package:navolaya_flutter/data/model/delete_profile_model.dart';
import 'package:navolaya_flutter/data/model/login_and_basic_info_model.dart';
import 'package:navolaya_flutter/data/model/profile_image_or_allow_notification_model.dart';
import 'package:navolaya_flutter/data/model/social_media_links_request_model.dart';
import 'package:navolaya_flutter/data/model/social_media_profiles_model.dart';
import 'package:navolaya_flutter/data/model/update_email_model.dart';
import 'package:navolaya_flutter/data/model/update_jnv_verification_model.dart';
import 'package:navolaya_flutter/data/model/update_phone_model.dart';
import 'package:navolaya_flutter/data/model/update_privacy_settings_model.dart' as privacy_settings;
import 'package:navolaya_flutter/data/model/update_privacy_settings_request_model.dart';
import 'package:navolaya_flutter/data/model/update_send_otp_model.dart';
import 'package:navolaya_flutter/resources/string_resources.dart';

import '../../../core/logger.dart';
import '../../../data/model/update_additional_info_model.dart';
import '../../../domain/profile_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository _repository;
  final _privacySettingsMap = UpdatePrivacySettingRequestModel().toJson();

  ProfileBloc(this._repository) : super(const ProfileInitial()) {
    on<ProfileEvent>((event, emit) async {
      try {
        late final ProfileState data;
        if (event is DeleteProfileEvent) {
          emit(const DeleteProfileLoadingState());
          data = await _deleteProfile(event, emit);
        } else if (event is UpdateProfileImageOrAllowNotificationEvent) {
          data = await _updateProfileImageOrAllowNotification(event, emit);
        } else {
          emit(const ProfileLoadingState());
        }

        if (event is InitiateUpdateAdditionalInfo) {
          data = await _updateAdditionalInfo(event, emit);
        } else if (event is FetchPersonalDetails) {
          data = await _fetchPersonalDetails(event, emit);
        } else if (event is UpdateProfileBasicInfoEvent) {
          data = await _updateProfileBasicInfo(event, emit);
        } else if (event is UpdateSocialMediaProfileLinksEvent) {
          data = await _updateSocialMediaLinks(event, emit);
        } else if (event is UpdatePhoneEvent) {
          data = await _updatePhone(event, emit);
        } else if (event is SendOTPEvent) {
          data = await _sendOTP(event, emit);
        } else if (event is UpdateEmailEvent) {
          data = await _updateEmail(event, emit);
        } else if (event is ChangePasswordEvent) {
          data = await _changePassword(event, emit);
        } else if (event is UpdatePrivacySettingEvent) {
          data = await _updatePrivacySettings(event, emit);
        } else if (event is FetchPrivacySettingEvent) {
          data = await _loadPrivacySettings(event, emit);
        } else if (event is UpdateJNVVerificationEvent) {
          data = await _updateJNVVerification(event, emit);
        } else if (event is GetProfileEvent) {
          data = await _getProfile(event, emit);
        }
        emit(data);
      } catch (e) {
        logger.e(e.toString());
        emit(ProfileErrorState(message: e.toString()));
      }
    });
  }

  @override
  void onTransition(Transition<ProfileEvent, ProfileState> transition) {
    super.onTransition(transition);
    logger.d(
        'Profile State Transition=>\nEvent : ${transition.event}\nState : ${transition.currentState}');
  }

  Future<ProfileState> _updateAdditionalInfo(
      InitiateUpdateAdditionalInfo event, Emitter emit) async {
    final possibleData = await _repository.updateAdditionalInfoAPI(
      house: event.house,
      aboutMe: event.aboutMe,
      birthDate: event.birthDate,
      currentAddress: event.currentAddress,
      permanentAddress: event.permanentAddress,
    );
    return possibleData.fold(
      (l) => ProfileErrorState(message: l.error),
      (r) => UpdateAdditionalInfoState(updateAdditionalInfo: r),
    );
  }

  Future<ProfileState> _fetchPersonalDetails(
    FetchPersonalDetails event,
    Emitter emit,
  ) async {
    final possibleData = await _repository.fetchPersonalDetails();
    return possibleData.fold(
      (l) => ProfileErrorState(message: l.error),
      (r) => LoadPersonalDetailsState(loginAndBasicInfoData: r),
    );
  }

  Future<ProfileState> _updateProfileBasicInfo(
      UpdateProfileBasicInfoEvent event, Emitter emit) async {
    final possibleData = await _repository.updateProfileBasicInfoAPI(
      basicInfoRequestData: event.basicInfoRequestData,
    );
    return possibleData.fold(
      (l) => ProfileErrorState(message: l.error),
      (r) => LoadUpdateProfileBasicInfoState(loginAndBasicInfoData: r),
    );
  }

  Future<ProfileState> _updateSocialMediaLinks(
      UpdateSocialMediaProfileLinksEvent event, Emitter emit) async {
    final possibleData = await _repository.updateSocialMediaLinksAPI(
      socialMediaLinksRequestData: event.socialMediaLinksRequestData,
    );
    return possibleData.fold(
      (l) => ProfileErrorState(message: l.error),
      (r) => LoadUpdateSocialMediaLinksState(socialMediaProfiles: r),
    );
  }

  Future<ProfileState> _updatePhone(UpdatePhoneEvent event, Emitter emit) async {
    final possibleData = await _repository.updatePhoneAPI(
      code: event.countryCode,
      number: event.mobileNumber,
      otpNumber: event.otpNumber,
    );
    return possibleData.fold(
      (l) => ProfileErrorState(message: l.error),
      (r) => LoadUpdatePhoneState(updatePhoneResponse: r),
    );
  }

  Future<ProfileState> _sendOTP(SendOTPEvent event, Emitter emit) async {
    final possibleData = await _repository.sendOtpAPI(
      code: event.countryCode,
      phoneNumber: event.mobileNumber,
      email: event.email,
    );
    return possibleData.fold(
      (l) => ProfileErrorState(message: l.error),
      (r) => LoadUpdateOTPState(updateSendOtpResponse: r),
    );
  }

  Future<ProfileState> _updateEmail(UpdateEmailEvent event, Emitter emit) async {
    final possibleData = await _repository.updateEmailAPI(
      otpNumber: event.otpNumber,
      email: event.email,
    );
    return possibleData.fold(
      (l) => ProfileErrorState(message: l.error),
      (r) => LoadUpdateEmailState(updateEmailResponse: r),
    );
  }

  Future<ProfileState> _changePassword(ChangePasswordEvent event, Emitter emit) async {
    final possibleData = await _repository.changePasswordAPI(
      oldPassword: event.oldPassword,
      newPassword: event.newPassword,
    );
    return possibleData.fold(
      (l) => ProfileErrorState(message: l.error),
      (r) => ChangePasswordState(changePasswordResponse: r),
    );
  }

  Future<ProfileState> _updatePrivacySettings(UpdatePrivacySettingEvent event, Emitter emit) async {
    final possibleData = await _repository.updatePrivacySettingsAPI(
      updatePrivacySettingRequestData: _privacySettingsMap,
    );
    return possibleData.fold(
      (l) => ProfileErrorState(message: l.error),
      (r) => UpdatePrivacySettingsState(response: r),
    );
  }

  Future<ProfileState> _loadPrivacySettings(FetchPrivacySettingEvent event, Emitter emit) async {
    final possibleData = _repository.fetchPrivacySettings();
    return possibleData.fold(
      (l) => ProfileErrorState(message: l.error),
      (r) => LoadPrivacySettingsState(displaySettings: r),
    );
  }

  Future<ProfileState> _deleteProfile(DeleteProfileEvent event, Emitter emit) async {
    final possibleData = await _repository.deleteProfile();
    return possibleData.fold(
      (l) => ProfileErrorState(message: l.error),
      (r) => DeleteProfileResponseState(response: r),
    );
  }

  Future<ProfileState> _updateJNVVerification(
      UpdateJNVVerificationEvent event, Emitter emit) async {
    final possibleData = await _repository.updateJnvVerificationAPI(event.reqData);
    return possibleData.fold(
      (l) => ProfileErrorState(message: l.error),
      (r) => UpdateJNVVerificationState(response: r),
    );
  }

  Future<ProfileState> _updateProfileImageOrAllowNotification(
      UpdateProfileImageOrAllowNotificationEvent event, Emitter emit) async {
    final possibleData = await _repository.updateProfileImageOrAllowNotificationAPI(event.reqData);
    return possibleData.fold(
      (l) => ProfileErrorState(message: l.error),
      (r) => UpdateProfileImageOrAllowNotificationState(response: r),
    );
  }

  Future<ProfileState> _getProfile(GetProfileEvent event, Emitter emit) async {
    final possibleData = await _repository.getProfileAPI();
    return possibleData.fold(
      (l) => ProfileErrorState(message: l.error),
      (r) => GetProfileState(loginAndBasicInfo: r),
    );
  }

  void updatePrivacySettingsMap(String key, String value) {
    if (key == StringResources.phoneNumber) {
      key = 'phone';
    } else if (key == StringResources.emailAddress) {
      key = 'email';
    } else if (key == StringResources.profileImage) {
      key = 'user_image';
    } else if (key == StringResources.birthDayAndMonth) {
      key = 'birth_day_month';
    } else if (key == StringResources.birthYear) {
      key = 'birth_year';
    } else if (key == StringResources.currentAddress) {
      key = 'current_address';
    } else if (key == StringResources.permanentAddress) {
      key = 'permanent_address';
    } else if (key == StringResources.socialProfiles) {
      key = 'social_profile_links';
    } else if (key == StringResources.findMeNearBy) {
      key = 'find_me_nearby';
    } else if (key == StringResources.sendMessages) {
      key = 'send_messages';
    }

    if (value == StringResources.all) {
      value = 'all';
    } else if (value == StringResources.myConnections) {
      value = 'my_connections';
    } else {
      value = 'none';
    }
    _privacySettingsMap[key] = value;
    logger.i('the privacy settings options are : $_privacySettingsMap');
  }
}
