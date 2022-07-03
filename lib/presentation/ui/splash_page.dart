import 'dart:async';
import 'package:flutter/material.dart';

import '../../util/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(20),
      child: const Center(
        child: SizedBox(
          height: 200,
          width: 200,
          child: Icon(Icons.api),
        ),
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
                homePage,
              )
            });
  }
}
