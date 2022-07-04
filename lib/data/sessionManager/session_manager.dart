import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  final SharedPreferences _preferences;

  //LoginData? _loginData;
  SessionManager(this._preferences);

/* Future<void> initiateUserLogin(LoginData loginDetails) async  {
    _loginData = null;
    final userDetails = json.encode(loginDetails.toJson());
    _preferences.setString(userData, userDetails);
    _preferences.setBool(isLoggedIn, true);
  }

  LoginData? _getUserDetails() {
    if(_loginData == null) {
      final value = _preferences.getString(userData) ?? '';
      final userDetails = json.decode(value) as Map<String, dynamic>;
      _loginData = LoginData.fromJson(userDetails);
    }
    return _loginData;
  }

  dynamic getToken() {
    return _getUserDetails()?.accessToken;
  }

  String getUserName() {
    return '${_getUserDetails()?.firstName} ${_getUserDetails()?.lastName} ';
  }

  LoginData? getUserDetails(){
    return _getUserDetails();
  }

  bool isUserLoggedIn() {
    return _preferences.getBool(isLoggedIn) ?? false;
  }

  Future<void> initiateLogout() async {
    _loginData = null;
    await _preferences.clear();
  }*/
}
