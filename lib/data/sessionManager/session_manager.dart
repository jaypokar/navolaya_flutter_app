import 'dart:convert';

import 'package:navolaya_flutter/data/model/login_and_basic_info_model.dart';
import 'package:navolaya_flutter/data/model/social_media_profiles_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/update_additional_info_model.dart';

class SessionManager {
  final SharedPreferences _preferences;

  /*Session value keys*/
  final String userDataKey = 'user_data';
  final String isLoggedInKey = 'is_logged_in';
  final String isUserFirstTimeInKey = 'is_userFirstTime_in';

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

  void updateBasicInfo(LoginAndBasicInfoModel basicInfoData) {
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
    initiateUserLogin(_loginData!);
  }

  void updateAdditionalInfo(UpdateAdditionalInfoModel data) {
    _loginData!.data!.aboutMe = data.data!.aboutMe!;
    _loginData!.data!.birthDate = data.data!.birthDate!;
    _loginData!.data!.house = data.data!.house!;
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
