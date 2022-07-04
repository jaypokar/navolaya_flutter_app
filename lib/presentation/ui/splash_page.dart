import 'dart:async';

import 'package:flutter/material.dart';
import 'package:navolaya_flutter/core/route_generator.dart';
import 'package:navolaya_flutter/util/common_functions.dart';

import '../../injection_container.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
            image: AssetImage(sl<CommonFunctions>().getImage(ImageType.imageBg)),
            fit: BoxFit.cover),
      ),
      padding: const EdgeInsets.all(20),
      child: Center(
        child: Image.asset(sl<CommonFunctions>().getImage(ImageType.textLogo)),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 2),
        () => {
              Navigator.pushReplacementNamed(
                context,
                RouteGenerator.introPage,
              )
            });
  }
}
