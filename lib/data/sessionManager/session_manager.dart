import 'dart:convert';

import 'package:navolaya_flutter/data/model/login_and_basic_info_model.dart';
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
    _loginData = null;
    final userDetails = json.encode(loginDetails.toJson());
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

  void updateAdditionalInfo(UpdateAdditionalInfoModel data) {
    _loginData!.data!.aboutMe = data.data!.aboutMe!;
    _loginData!.data!.birthDate = data.data!.birthDate!;
    _loginData!.data!.house = data.data!.house!;
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
