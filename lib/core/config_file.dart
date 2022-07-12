class ConfigFile {
  //Http Requests Base url and End Points

  static const String clientID = '964de1d6-590d-4455-94fd-5a96bdb53df7';

  static const String clientSecret = 'Z1WE08cIoI66s4pHArle5H8awfUSszumw1UxU70V';

  static const String apiBaseURL = 'http://13.126.76.74:3000/api/user/';
  static const String imgBaseURL = 'http://13.126.76.74:3000/api/user/';

  static const String allContentsAPIUrl = '${apiBaseURL}all/contents';
  static const String allMastersAPIUrl = '${apiBaseURL}all/masters';

  /*Session value keys*/
  static const String _userData = 'user_data';
  static const String _isLoggedIn = 'is_logged_in';
}
