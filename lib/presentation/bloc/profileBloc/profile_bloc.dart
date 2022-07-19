import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:navolaya_flutter/data/model/basic_info_request_model.dart';
import 'package:navolaya_flutter/data/model/change_password_model.dart';
import 'package:navolaya_flutter/data/model/login_and_basic_info_model.dart';
import 'package:navolaya_flutter/data/model/social_media_links_request_model.dart';
import 'package:navolaya_flutter/data/model/social_media_profiles_model.dart';
import 'package:navolaya_flutter/data/model/update_email_model.dart';
import 'package:navolaya_flutter/data/model/update_phone_model.dart';
import 'package:navolaya_flutter/data/model/update_send_otp_model.dart';

import '../../../core/logger.dart';
import '../../../data/model/update_additional_info_model.dart';
import '../../../domain/profile_repository.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository _repository;

  ProfileBloc(this._repository) : super(const ProfileInitial()) {
    on<ProfileEvent>((event, emit) async {
      try {
        late final ProfileState data;
        emit(const ProfileLoadingState());
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
        }
        emit(data);
      } catch (e) {
        logger.e(e.toString());
        emit(ProfileErrorState(message: e.toString()));
      }
    });
  }

  Future<ProfileState> _updateAdditionalInfo(
      InitiateUpdateAdditionalInfo event, Emitter emit) async {
    final possibleData = await _repository.updateAdditionalInfoAPI(
      house: event.house,
      aboutMe: event.aboutMe,
      birthDate: event.birthDate,
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
}
