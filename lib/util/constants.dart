import 'package:flutter/material.dart';

//create custom Colors
MaterialColor createMaterialColor(Color color) {
  final List<double> strengths = <double>[.05];
  final Map<int, Color> swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  // ignore: avoid_function_literals_in_foreach_calls

  for (final strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}

//Http Requests Base url and End Points

// ignore: constant_identifier_names
const CLIENT_ID = '964de1d6-590d-4455-94fd-5a96bdb53df7';
// ignore: constant_identifier_names
const CLIENT_SECRET = 'Z1WE08cIoI66s4pHArle5H8awfUSszumw1UxU70V';

// ignore: constant_identifier_names
const BASE_URL = 'https://codeclinic.in/kreeda_tantra_dev/public/';
// ignore: constant_identifier_names
const BASE_URL_END_POINT = '${BASE_URL}api/v1/';
// ignore: constant_identifier_names
const IMAGE_BASE_URL = 'https://ksquarez.in';

/*API Base Urls*/
const oAuthTokenAPI = '${BASE_URL}oauth/token';
const loginAPI = '${BASE_URL_END_POINT}login';
const homeAPI = '${BASE_URL_END_POINT}home';
const batchListAPI = '${BASE_URL_END_POINT}batch-master/list';
const batchDetailAPI = '${BASE_URL_END_POINT}batch-master/detail/';
const attendanceAPI = '${BASE_URL_END_POINT}attendance/store/';
const updateAttendanceAPI = '${BASE_URL_END_POINT}attendance/update/';
const assessmentAPI = '${BASE_URL_END_POINT}assessment/list';

/*Route Names*/
const splashScreen = '/';
const loginPage = '/loginPage';
const registrationPage = "/registration";
const homePage = '/home';
const userDetailPage = '/userDetail';

//Session value keys
const userData = 'user_data';
const isLoggedIn = 'is_logged_in';

//Admin Credentials:
//https://codeclinic.in/kreeda_tantra_dev/public/admin/login
//E : admin@gmail.com
//P : 12345678
