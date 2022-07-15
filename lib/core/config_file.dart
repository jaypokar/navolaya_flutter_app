class ConfigFile {
  //Http Requests Base url and End Points

  static const String clientID = '964de1d6-590d-4455-94fd-5a96bdb53df7';

  static const String clientSecret = 'Z1WE08cIoI66s4pHArle5H8awfUSszumw1UxU70V';

  static const String apiBaseURL = 'http://13.126.76.74:3000/api/user/';
  static const String imgBaseURL = 'http://13.126.76.74:3000/api/user/';

  static const String allContentsAPIUrl = '${apiBaseURL}all/contents';
  static const String allMastersAPIUrl = '${apiBaseURL}all/masters';

  static const String validatePhoneAPIUrl = '${apiBaseURL}auth/validate-phone';
  static const String verifyOTPAPIUrl = '${apiBaseURL}auth/verify-otp';
  static const String sendOTPAPIUrl = '${apiBaseURL}auth/send-otp';
  static const String loginAPIUrl = '${apiBaseURL}auth/login';
  static const String logoutAPIUrl = '${apiBaseURL}auth/logout';
  static const String updateBasicInfoAPIUrl = '${apiBaseURL}auth/basic-info';
  static const String updateForgotPasswordAPIUrl = '${apiBaseURL}auth/update-forgot-password';

  /*Session value keys*/
  static const String userDataKey = 'user_data';
  static const String isLoggedInKey = 'is_logged_in';
  static const String isUserFirstTimeInKey = 'is_userFirstTime_in';

  //Router data keys
  static const String countryCodeKey = 'countryCode';
  static const String mobileNumberKey = 'mobileNumber';
}
