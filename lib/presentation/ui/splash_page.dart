import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navolaya_flutter/core/route_generator.dart';
import 'package:navolaya_flutter/domain/master_repository.dart';
import 'package:navolaya_flutter/features/local_notificaion.dart';
import 'package:navolaya_flutter/presentation/cubit/socketConnectionCubit/socket_connection_cubit.dart';
import 'package:navolaya_flutter/resources/image_resources.dart';

import '../../data/sessionManager/session_manager.dart';
import '../../injection_container.dart';
import '../../resources/value_key_resources.dart';

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
        /*image: DecorationImage(
            image: AssetImage(
              ImageResources.imgBg,
            ),
            fit: BoxFit.cover),*/
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
    sl<LocalNotification>().initiateNotificationListening(context);
    fetchInitialData();
  }

  void fetchInitialData({bool navigateToRegisterPage = false}) async {
    context.read<SocketConnectionCubit>().init();

    await sl<MasterRepository>().fetchAllContentsData();
    await sl<MasterRepository>().fetchAllMasterData();

    if (!mounted) return;
    if (navigateToRegisterPage) {
      Navigator.pushReplacementNamed(context, RouteGenerator.registrationPage, arguments: {
        ValueKeyResources.countryCodeKey: '+91',
        ValueKeyResources.mobileNumberKey: '9429888309'
      });
      return;
    }

    Timer(const Duration(seconds: 2), () {
      if (sl<SessionManager>().isUserFirstTimeIn()) {
        sl<SessionManager>().setUserFirstTimeIn();
        Navigator.pushReplacementNamed(
          context,
          RouteGenerator.introPage,
        );
      } else if (sl<SessionManager>().isUserLoggedIn()) {
        Navigator.pushReplacementNamed(
          context,
          RouteGenerator.dashBoardPage,
        );
      } else {
        Navigator.pushReplacementNamed(
          context,
          RouteGenerator.authenticationPage,
        );
      }
    });
  }
}
