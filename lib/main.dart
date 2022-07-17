import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navolaya_flutter/presentation/bloc/authBloc/auth_bloc.dart';
import 'package:navolaya_flutter/presentation/bloc/profileBloc/profile_bloc.dart';
import 'package:navolaya_flutter/presentation/uiNotifiers/ui_notifiers.dart';
import 'package:navolaya_flutter/util/common_functions.dart';

import 'core/color_constants.dart';
import 'core/global_nav_key.dart';
import 'core/route_generator.dart';
import 'injection_container.dart';
import 'injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.init().then((value) => runApp(const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(create: (_) => di.sl<AuthBloc>()),
        BlocProvider<ProfileBloc>(create: (_) => di.sl<ProfileBloc>()),
      ],
      child: MaterialApp(
        title: 'Navolaya',
        navigatorKey: GlobalNavKey.navState,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle.light,
          ),
          fontFamily: 'Montserrat',
          primaryColor: ColorConstants.appColor,
          primarySwatch: sl<CommonFunctions>().createMaterialColor(ColorConstants.appColor),
          brightness: Brightness.light,
          scaffoldBackgroundColor: Colors.white,
          cardColor: Colors.grey[500],
          unselectedWidgetColor: Colors.black45,
          focusColor: Colors.black,
          cardTheme: const CardTheme(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(5.0),
              ),
            ),
          ),
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: RouteGenerator.splashScreen,
        onGenerateRoute: sl<RouteGenerator>().generateRoute,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    sl<UiNotifiers>().mobileVerificationTitleNotifier.dispose();
  }

  @override
  void initState() {
    super.initState();
  }
}
