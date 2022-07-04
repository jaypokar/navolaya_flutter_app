import 'package:flutter/material.dart';
import 'package:navolaya_flutter/presentation/ui/auth/authentication_page.dart';
import 'package:navolaya_flutter/presentation/ui/introScreen/intro_page.dart';
import 'package:navolaya_flutter/presentation/ui/registration/registration_page.dart';
import 'package:navolaya_flutter/presentation/ui/user/user_detail_page.dart';

import '../presentation/ui/home/home_page.dart';
import '../presentation/ui/splash_page.dart';

// ignore: avoid_classes_with_only_static_members
class RouteGenerator {
  /*Route Names*/
  static const splashScreen = '/';
  static const introPage = '/introPage';
  static const loginPage = '/loginPage';
  static const authenticationPage = '/authenticationPage';
  static const registrationPage = "/registration";
  static const homePage = '/home';
  static const userDetailPage = '/userDetail';

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
        return MaterialPageRoute(builder: (_) => const RegistrationPage());
      case homePage:
        return MaterialPageRoute(builder: (_) => const HomePage());
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
