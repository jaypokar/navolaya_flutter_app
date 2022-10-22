import 'dart:convert';

import 'package:navolaya_flutter/data/model/login_and_basic_info_model.dart';
import 'package:navolaya_flutter/data/model/social_media_profiles_model.dart';
import 'package:navolaya_flutter/data/model/update_privacy_settings_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/profile_image_or_allow_notification_model.dart';
import '../model/update_additional_info_model.dart';

class SessionManager {
  final SharedPreferences _preferences;

  /*Session value keys*/
  final String userDataKey = 'user_data';
  final String isLoggedInKey = 'is_logged_in';
  final String isUserFirstTimeInKey = 'is_userFirstTime_in';
  final String isVerificationPopupDisplayed = 'is_verification_popup_displayed';

  LoginAndBasicInfoModel? _loginData;

  SessionManager(this._preferences);

  Future<void> initiateUserLogin(LoginAndBasicInfoModel loginDetails) async {
    final userDetails = json.encode(loginDetails.toJson());
    _loginData = null;
    _preferences.setString(userDataKey, userDetails);
    _preferences.setBool(isLoggedInKey, true);
  }

  LoginAndBasicInfoModel? getUserDetails() {
    if (_loginData == null) {
      final value = _preferences.getString(userDataKey) ?? '';
      final userDetails = json.decode(value) as Map<String, dynamic>;
      _loginData = LoginAndBasicInfoModel.fromJson(userDetails);
    }
    return _loginData;
  }

  void updateAllowNotifications(bool allowNotifications) {
    _loginData!.data!.allowNotifications = allowNotifications ? 1 : 0;
    initiateUserLogin(_loginData!);
  }

  void updateToken(String token) {
    if (_loginData == null) {
      final value = _preferences.getString(userDataKey) ?? '';
      final userDetails = json.decode(value) as Map<String, dynamic>;
      _loginData = LoginAndBasicInfoModel.fromJson(userDetails);
    }
    _loginData!.data!.authToken = token;
    initiateUserLogin(_loginData!);
  }

  void updateBasicInfo(LoginAndBasicInfoModel basicInfoData) {
    if (basicInfoData.data!.school != null) {
      _loginData?.data!.fullName = basicInfoData.data!.fullName!;
    }
    if (basicInfoData.data!.school != null) {
      _loginData?.data!.school = basicInfoData.data!.school!;
    }
    if (basicInfoData.data!.gender != null) {
      _loginData?.data!.gender = basicInfoData.data!.gender!;
    }
    if (basicInfoData.data!.relationWithJnv != null) {
      _loginData?.data!.relationWithJnv = basicInfoData.data!.relationWithJnv!;
    }
    if (basicInfoData.data!.fromYear != null) {
      _loginData?.data!.fromYear = basicInfoData.data!.fromYear!;
    }
    if (basicInfoData.data!.toYear != null) {
      _loginData?.data!.toYear = basicInfoData.data!.toYear!;
    }
    if (basicInfoData.data!.qualification != null) {
      _loginData?.data!.qualification = basicInfoData.data!.qualification!;
    }
    if (basicInfoData.data!.occupation != null) {
      _loginData?.data!.occupation = basicInfoData.data!.occupation!;
    }
    if (basicInfoData.data!.authToken != null) {
      _loginData?.data!.authToken = basicInfoData.data!.authToken!;
    }
    initiateUserLogin(_loginData!);
  }

  void updateProfileDetailsToSession(LoginAndBasicInfoModel basicInfoData) {
    initiateUserLogin(basicInfoData);
  }

  void updatePrivacySettings(UpdatePrivacySettingsModel updatePrivacySettingsData) {
    _loginData!.data!.displaySettings!.phone =
        updatePrivacySettingsData.data!.displaySettings!.phone!;
    _loginData!.data!.displaySettings!.email =
        updatePrivacySettingsData.data!.displaySettings!.email!;
    _loginData!.data!.displaySettings!.findMeNearby =
        updatePrivacySettingsData.data!.displaySettings!.findMeNearby!;
    _loginData!.data!.displaySettings!.socialProfileLinks =
        updatePrivacySettingsData.data!.displaySettings!.socialProfileLinks!;
    _loginData!.data!.displaySettings!.permanentAddress =
        updatePrivacySettingsData.data!.displaySettings!.permanentAddress!;
    _loginData!.data!.displaySettings!.currentAddress =
        updatePrivacySettingsData.data!.displaySettings!.currentAddress!;
    _loginData!.data!.displaySettings!.birthYear =
        updatePrivacySettingsData.data!.displaySettings!.birthYear!;
    _loginData!.data!.displaySettings!.birthDayMonth =
        updatePrivacySettingsData.data!.displaySettings!.birthDayMonth!;
    _loginData!.data!.displaySettings!.userImage =
        updatePrivacySettingsData.data!.displaySettings!.userImage!;
    _loginData!.data!.displaySettings!.sendMessages =
        updatePrivacySettingsData.data!.displaySettings!.sendMessages!;
    if (updatePrivacySettingsData.data!.authToken != null) {
      _loginData!.data!.authToken = updatePrivacySettingsData.data!.authToken;
    }
    initiateUserLogin(_loginData!);
  }

  void updateAdditionalInfo(UpdateAdditionalInfoModel data) {
    if (data.data!.aboutMe != null) {
      _loginData!.data!.aboutMe = data.data!.aboutMe!;
    }
    if (data.data!.birthDate != null) {
      _loginData!.data!.birthDate = data.data!.birthDate!;
    }
    if (data.data!.house != null) {
      _loginData!.data!.house = data.data!.house!;
    }
    if (data.data!.currentAddress != null) {
      _loginData!.data!.currentAddress = data.data!.currentAddress;
    }

    if (data.data!.permanentAddress != null) {
      _loginData!.data!.permanentAddress = data.data!.permanentAddress;
    }
    initiateUserLogin(_loginData!);
  }

  void updateProfileImageOrAllowNotificationData(ProfileImageOrAllowNotificationModel data) {
    if (data.data!.allowNotifications != null) {
      _loginData!.data!.allowNotifications = data.data!.allowNotifications!;
    }
    if (data.data!.userImage != null) {
      _loginData!.data!.userImage = data.data!.userImage!;
    }
    if (data.data!.authToken != null) {
      _loginData!.data!.authToken = data.data!.authToken!;
    }
    initiateUserLogin(_loginData!);
  }

  void updateMobileNumber(String number) {
    _loginData!.data!.phone = number;
    initiateUserLogin(_loginData!);
  }

  void updateEmail(String email) {
    _loginData!.data!.email = email;
    initiateUserLogin(_loginData!);
  }

  void updateSocialMediaLinks(SocialMediaProfilesModel socialMediaProfiles) {
    String fb = socialMediaProfiles.data!.socialProfileLinks!.facebook ?? '';
    String insta = socialMediaProfiles.data!.socialProfileLinks!.instagram ?? '';
    String twitter = socialMediaProfiles.data!.socialProfileLinks!.twitter ?? '';
    String linkedIn = socialMediaProfiles.data!.socialProfileLinks!.linkedin ?? '';
    String youtube = socialMediaProfiles.data!.socialProfileLinks!.youtube ?? '';
    _loginData!.data!.socialProfileLinks = SocialProfileLinks(
        facebook: fb, instagram: insta, linkedin: linkedIn, twitter: twitter, youtube: youtube);
    initiateUserLogin(_loginData!);
  }

  String getToken() {
    return getUserDetails()!.data!.authToken ?? '';
  }

  bool isUserFirstTimeIn() {
    return _preferences.getBool(isUserFirstTimeInKey) ?? true;
  }

  bool checkVerificationPopupDisplayed() =>
      _preferences.getBool(isVerificationPopupDisplayed) ?? false;

  void jnvVerificationPopupHasBeenDisplayed() =>
      _preferences.setBool(isVerificationPopupDisplayed, true);

  void setUserFirstTimeIn() {
    _preferences.setBool(isUserFirstTimeInKey, false);
  }

  bool isUserLoggedIn() {
    return _preferences.getBool(isLoggedInKey) ?? false;
  }

  Future<void> initiateLogout() async {
    _loginData = null;
    await _preferences.setBool(isLoggedInKey, false);
  }
}
