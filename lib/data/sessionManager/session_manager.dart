import 'dart:convert';

import 'package:navolaya_flutter/core/config_file.dart';
import 'package:navolaya_flutter/data/model/login_and_basic_info_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  final SharedPreferences _preferences;

  LoginAndBasicInfoModel? _loginData;

  SessionManager(this._preferences);

  Future<void> initiateUserLogin(LoginAndBasicInfoModel loginDetails) async {
    _loginData = null;
    final userDetails = json.encode(loginDetails.toJson());
    _preferences.setString(ConfigFile.userDataKey, userDetails);
    _preferences.setBool(ConfigFile.isLoggedInKey, true);
  }

  LoginAndBasicInfoModel? _getUserDetails() {
    if (_loginData == null) {
      final value = _preferences.getString(ConfigFile.userDataKey) ?? '';
      final userDetails = json.decode(value) as Map<String, dynamic>;
      _loginData = LoginAndBasicInfoModel.fromJson(userDetails);
    }
    return _loginData;
  }

  String getToken() {
    return _getUserDetails()?.data!.authToken ?? '';
  }

  bool isUserFirstTimeIn() {
    return _preferences.getBool(ConfigFile.isUserFirstTimeInKey) ?? true;
  }

  void setUserFirstTimeIn() {
    _preferences.setBool(ConfigFile.isUserFirstTimeInKey, false);
  }

  bool isUserLoggedIn() {
    return _preferences.getBool(ConfigFile.isLoggedInKey) ?? false;
  }

  Future<void> initiateLogout() async {
    _loginData = null;
    await _preferences.setBool(ConfigFile.isLoggedInKey, false);
  }
}
