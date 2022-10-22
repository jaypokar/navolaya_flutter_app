class ConfigFile {
  //Http Requests Base url and End Points

  static const bool isProductionMode = true;

  static const String clientID = '964de1d6-590d-4455-94fd-5a96bdb53df7';

  static const String clientSecret = 'Z1WE08cIoI66s4pHArle5H8awfUSszumw1UxU70V';

  static const String baseURL =
      isProductionMode ? 'http://webservice.navolaya.com' : 'http://dev-webservice.navolaya.com';

  static const String apiBaseURL = '$baseURL/api/user/';

  //static const String googleMapAPIKey = 'AIzaSyBQ-ptlxz_pxrEHazBtQRX2uvUZ0CwU35E';

  static const String googleMapAPIKey =
      'AIzaSyCnINx9QW6Sx6tCN_jFy-c5ljorBwETtLc'; //Place API key MAin

  ///-> S3 Amazon Service key and access Info
  static const String s3UserName = 'navolaya_s3_user';
  static const String s3AccessKeyID = 'AKIAXLEXT47A2PY34GOE';
  static const String s3SecretAccessKeyID = 'FPdvcFPmDKmlsuLGXw/fQYG2l7OftNLfIzCQ3I65';
  static const String s3BucketName = 'navolaya';
  static const String s3BucketEnvFolder = 'dev';
  static const String s3Region = 'ap-south-1';

  ///-> JWT Secret Key
  static const String jwtSecretKey = 'NavolayaHGD5DHDY3x';
  static const String apiAccessSecretKey = '456]Y3x[aRUGDS}DxE';

  ///--> API End Points
  static const String docFilepath = 'dev/jnv-docs/';
  static const String imageFilepath = 'dev/user-images';

  ///-->Master API URLS
  static const String allContentsAPIUrl = '${apiBaseURL}all/contents';
  static const String allMastersAPIUrl = '${apiBaseURL}all/masters';

  ///-->Auth URLS
  static const String validatePhoneAPIUrl = '${apiBaseURL}auth/validate-phone';
  static const String verifyOTPAPIUrl = '${apiBaseURL}auth/verify-otp';
  static const String sendOTPAPIUrl = '${apiBaseURL}auth/send-otp';
  static const String loginAPIUrl = '${apiBaseURL}auth/login';
  static const String logoutAPIUrl = '${apiBaseURL}auth/logout';
  static const String updateBasicInfoAPIUrl = '${apiBaseURL}auth/basic-info';
  static const String updateForgotPasswordAPIUrl = '${apiBaseURL}auth/update-forgot-password';

  ///-->Update Profile URLS
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
  static const String updateProfileImageOrAllowNotificationAPIUrl = '${apiBaseURL}profile';
  static const String getProfileAPIUrl = '${apiBaseURL}profile';

  ///-->Users URL
  static const String getUsersAPIUrl = '${apiBaseURL}users';
  static const String usersVerificationRequestsAPIUrl = '${apiBaseURL}users/verification-requests';
  static const String updateUserViewAPI = '${apiBaseURL}users/view';

  ///-->User Connections URL
  static const String connectionRequestsAPIUrl = '${apiBaseURL}connections/requests';
  static const String connectionsAPIUrl = '${apiBaseURL}connections';

  ///-->Block User URL*/
  static const String blockUserAPIUrl = '${apiBaseURL}blocked-users';

  ///-->Notifications URL
  static const String notificationsAPIUrl = '${apiBaseURL}notifications';

  ///-->Chats URL
  static const String chatsAPIUrl = '${apiBaseURL}chats';

  ///-->Support Chats URL
  static const String supportChatsAPIUrl = '${apiBaseURL}support-chats';

  ///-->Report Users URL
  static const String reportUsersAPIUrl = '${apiBaseURL}reported-users';
}
