import 'package:flutter/material.dart';
import 'package:navolaya_flutter/core/config_file.dart';
import 'package:navolaya_flutter/presentation/ui/auth/authentication_page.dart';
import 'package:navolaya_flutter/presentation/ui/blockedUsers/blocked_users_page.dart';
import 'package:navolaya_flutter/presentation/ui/connectionRequests/connection_requests_page.dart';
import 'package:navolaya_flutter/presentation/ui/editProfile/edit_profile_page.dart';
import 'package:navolaya_flutter/presentation/ui/helpAndInfo/help_and_info_page.dart';
import 'package:navolaya_flutter/presentation/ui/introScreen/intro_page.dart';
import 'package:navolaya_flutter/presentation/ui/registration/registration_page.dart';
import 'package:navolaya_flutter/presentation/ui/settings/settings_page.dart';
import 'package:navolaya_flutter/presentation/ui/user/user_detail_page.dart';

import '../presentation/ui/dashBoard/dashboard_page.dart';
import '../presentation/ui/splash_page.dart';

class RouteGenerator {
  /*Route Names*/
  static const splashScreen = '/';
  static const introPage = '/introPage';
  static const loginPage = '/loginPage';
  static const authenticationPage = '/authenticationPage';
  static const registrationPage = "/registrationPage";
  static const dashBoardPage = '/dashBoardPage';
  static const userDetailPage = '/userDetailPage';
  static const connectionRequestPage = '/connectionRequestPage';
  static const editProfilePage = '/editProfilePage';
  static const settingsPage = '/settingsPage';
  static const blockedUserPage = '/blockedUsersPage';
  static const helpAndInfoPage = '/helpAndInfoPage';

  const RouteGenerator();

  Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case introPage:
        return MaterialPageRoute(builder: (_) => const IntroPage());
      case authenticationPage:
        return MaterialPageRoute(builder: (_) => const AuthenticationPage());
      case registrationPage:
        if (args is Map<String, dynamic>) {
          String countryCode = args[ConfigFile.countryCodeKey];
          String mobileNumber = args[ConfigFile.mobileNumberKey];
          return MaterialPageRoute(
              builder: (_) => RegistrationPage(
                    countryCode: countryCode,
                    mobileNumber: mobileNumber,
                  ));
        }
        return _errorRoute();
      case dashBoardPage:
        return MaterialPageRoute(builder: (_) => const DashBoardPage());
      case connectionRequestPage:
        return MaterialPageRoute(builder: (_) => const ConnectionRequestsPage());
      case editProfilePage:
        return MaterialPageRoute(builder: (_) => const EditProfilePage());
      case settingsPage:
        return MaterialPageRoute(builder: (_) => const SettingsPage());
      case blockedUserPage:
        return MaterialPageRoute(builder: (_) => const BlockedUsersPage());
      case helpAndInfoPage:
        return MaterialPageRoute(builder: (_) => const HelpAndInfoPage());
      case userDetailPage:
        if (args is String) {
          return MaterialPageRoute(builder: (_) => UserDetailPage(image: args));
        }
        return _errorRoute();
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}
