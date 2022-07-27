class ConfigFile {
  //Http Requests Base url and End Points

  static const String clientID = '964de1d6-590d-4455-94fd-5a96bdb53df7';

  static const String clientSecret = 'Z1WE08cIoI66s4pHArle5H8awfUSszumw1UxU70V';

  static const String apiBaseURL = 'http://dev-webservice.navolaya.com/api/user/';
  static const String imgBaseURL = 'http://dev-webservice.navolaya.com/api/user/';
  static const String googleMapAPIKey = 'AIzaSyAL8Jkp9o4YKnHo0rGvnRqRZwoNVXaSSTU';

  static const String allContentsAPIUrl = '${apiBaseURL}all/contents';
  static const String allMastersAPIUrl = '${apiBaseURL}all/masters';

  /*Auth URLS*/
  static const String validatePhoneAPIUrl = '${apiBaseURL}auth/validate-phone';
  static const String verifyOTPAPIUrl = '${apiBaseURL}auth/verify-otp';
  static const String sendOTPAPIUrl = '${apiBaseURL}auth/send-otp';
  static const String loginAPIUrl = '${apiBaseURL}auth/login';
  static const String logoutAPIUrl = '${apiBaseURL}auth/logout';
  static const String updateBasicInfoAPIUrl = '${apiBaseURL}auth/basic-info';
  static const String updateForgotPasswordAPIUrl = '${apiBaseURL}auth/update-forgot-password';

  /*Update Profile URLS*/

  static const String updateAdditionalInfoAPIUrl = '${apiBaseURL}profile/additional-info';
  static const String updateProfileBasicInfoAPIUrl = '${apiBaseURL}profile/basic-info';
  static const String updateSocialMediaLinksAPIUrl = '${apiBaseURL}profile/social-links';
  static const String updateSendOTPAPIUrl = '${apiBaseURL}profile/send-otp';
  static const String updateMobileNumberAPIUrl = '${apiBaseURL}profile/update-phone';
  static const String updateEmailAPIUrl = '${apiBaseURL}profile/update-email';
  static const String updateJNVVerificationAPIUrl = '${apiBaseURL}profile/jnv-verification';
  static const String changePasswordAPIUrl = '${apiBaseURL}profile/password';
  static const String updatePrivacySettingsAPIUrl = '${apiBaseURL}profile/privacy-settings';
  static const String deleteProfileAPIUrl = '${apiBaseURL}profile';

  /*Users URL*/
  static const String getUsersAPIUrl = '${apiBaseURL}users';
  static const String getUsersVerificationsAPIUrl = '${apiBaseURL}users/verification-requests';
  static const String updateUsersVerificationsAPIUrl = '${apiBaseURL}users/verification-requests';

  /*User Connections URL*/
  static const String createConnectionRequestAPIUrl = '${apiBaseURL}connections/requests';
  static const String getConnectionRequestAPIUrl = '${apiBaseURL}connections/requests';
  static const String removeConnectionAPIUrl = '${apiBaseURL}connections';
  static const String myConnectionAPIUrl = '${apiBaseURL}connections';
  static const String removeMyConnectionAPIUrl = '${apiBaseURL}connections';
  static const String updateConnectionRequestAPIUrl = '${apiBaseURL}connections/requests';
}
