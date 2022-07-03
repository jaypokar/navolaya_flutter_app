import 'package:flutter/material.dart';
import 'package:navolaya_flutter/presentation/ui/user/user_detail_page.dart';

import '../presentation/ui/home/home_page.dart';
import '../presentation/ui/splash_page.dart';
import '../util/constants.dart';

// ignore: avoid_classes_with_only_static_members
class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
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
