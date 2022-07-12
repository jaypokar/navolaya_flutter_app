import 'dart:async';

import 'package:flutter/material.dart';
import 'package:navolaya_flutter/core/route_generator.dart';
import 'package:navolaya_flutter/domain/master_repository.dart';
import 'package:navolaya_flutter/resources/image_resources.dart';

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
      decoration: const BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
            image: AssetImage(
              ImageResources.imgBg,
            ),
            fit: BoxFit.cover),
      ),
      padding: const EdgeInsets.all(20),
      child: Center(
        child: Image.asset(
          ImageResources.textLogo,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    fetchInitialData();
  }

  void fetchInitialData() async {
    //await sl<MasterRepository>().fetchAllContentsData();

    await sl<MasterRepository>().fetchAllMasterData();
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
