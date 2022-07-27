import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:navolaya_flutter/core/route_generator.dart';
import 'package:navolaya_flutter/data/repositoryImpl/auth_repository_impl.dart';
import 'package:navolaya_flutter/data/repositoryImpl/help_and_info_repository_impl.dart';
import 'package:navolaya_flutter/data/repositoryImpl/master_repository_impl.dart';
import 'package:navolaya_flutter/data/repositoryImpl/profile_repository_impl.dart';
import 'package:navolaya_flutter/data/repositoryImpl/users_repository_impl.dart';
import 'package:navolaya_flutter/domain/auth_repository.dart';
import 'package:navolaya_flutter/domain/help_and_info_repository.dart';
import 'package:navolaya_flutter/domain/master_repository.dart';
import 'package:navolaya_flutter/domain/profile_repository.dart';
import 'package:navolaya_flutter/domain/user_connections_repository.dart';
import 'package:navolaya_flutter/domain/users_repository.dart';
import 'package:navolaya_flutter/features/location_manager.dart';
import 'package:navolaya_flutter/presentation/bloc/authBloc/auth_bloc.dart';
import 'package:navolaya_flutter/presentation/bloc/profileBloc/profile_bloc.dart';
import 'package:navolaya_flutter/presentation/bloc/userConnectionsBloc/user_connections_bloc.dart';
import 'package:navolaya_flutter/presentation/cubit/dashBoardTitleNotifierCubit/dash_board_title_notifier_cubit.dart';
import 'package:navolaya_flutter/presentation/cubit/helpAndInfoCubit/help_and_info_cubit.dart';
import 'package:navolaya_flutter/presentation/cubit/homeTabsNotifierCubit/home_tabs_notifier_cubit.dart';
import 'package:navolaya_flutter/presentation/cubit/mobileVerificationCubit/mobile_verification_cubit.dart';
import 'package:navolaya_flutter/presentation/cubit/myConnectionsCubit/my_connections_cubit.dart';
import 'package:navolaya_flutter/presentation/cubit/nearByUsersCubit/near_by_users_cubit.dart';
import 'package:navolaya_flutter/presentation/cubit/otpTimerCubit/otptimer_cubit.dart';
import 'package:navolaya_flutter/presentation/cubit/popularUsersCubit/popular_users_cubit.dart';
import 'package:navolaya_flutter/presentation/cubit/recentUsersCubit/recent_users_cubit.dart';
import 'package:navolaya_flutter/presentation/cubit/usersVerificationsCubit/users_verifications_cubit.dart';
import 'package:navolaya_flutter/presentation/uiNotifiers/ui_notifiers.dart';
import 'package:navolaya_flutter/util/common_functions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/apiService/base_api_service.dart';
import 'data/apiService/network_api_service.dart';
import 'data/repositoryImpl/user_connections_repository_impl.dart';
import 'data/sessionManager/session_manager.dart';
import 'presentation/cubit/pageIndicatorCubit/page_indicator_page_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! External /* All the other required external injection are embedded here */
  await _initExternalDependencies();

  // Repository /* All the repository injection are embedded here */
  _initRepositories();

  // Bloc /* All the bloc injection are embedded here */
  _initBlocs();

  //cubit inject for small and effective ui updates
  _initCubits();
}

void _initBlocs() {
  //Add Auth Bloc
  sl.registerFactory(
    () => AuthBloc(sl()),
  );

  //Add Profile Bloc
  sl.registerFactory(
    () => ProfileBloc(sl()),
  );

  //User Connections Bloc
  sl.registerFactory(
    () => UserConnectionsBloc(sl()),
  );
}

void _initCubits() {
  sl.registerFactory(
    () => PageIndicatorPageCubit(),
  );
  sl.registerFactory(
    () => MobileVerificationCubit(),
  );
  sl.registerFactory(
    () => OTPTimerCubit(),
  );

  sl.registerFactory(
    () => HomeTabsNotifierCubit(),
  );

  sl.registerFactory(
    () => RecentUsersCubit(sl()),
  );

  sl.registerFactory(
    () => NearByUsersCubit(sl(), sl()),
  );

  sl.registerFactory(
    () => PopularUsersCubit(sl()),
  );
  sl.registerFactory(
    () => DashBoardTitleNotifierCubit(),
  );
  sl.registerFactory(
    () => HelpAndInfoCubit(sl()),
  );
  sl.registerFactory(
    () => UsersVerificationsCubit(sl()),
  );

  sl.registerFactory(
    () => MyConnectionsCubit(sl()),
  );
}

void _initRepositories() {
  //Api Service
  sl.registerLazySingleton<BaseAPIService>(
    () => NetworkAPIService(sl(), sl(), sl()),
  );

  //Master  Repository
  sl.registerLazySingleton<MasterRepository>(
    () => MasterRepositoryImpl(sl()),
  );

  //Auth  Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl(), sl()),
  );

  //Profile Repository
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(sl(), sl()),
  );

  //Users Repository
  sl.registerLazySingleton<UsersRepository>(
    () => UsersRepositoryImpl(sl()),
  );

  //User Connection Repository
  sl.registerLazySingleton<UserConnectionsRepository>(
    () => UserConnectionsRepositoryImpl(sl()),
  );
  //Help and info Repository
  sl.registerLazySingleton<HelpAndInfoRepository>(
    () => HelpAndInfoRepositoryImpl(sl()),
  );
}

Future<void> _initExternalDependencies() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Connectivity());
  sl.registerLazySingleton(() => SessionManager(sl()));
  sl.registerLazySingleton(() => const CommonFunctions());
  sl.registerLazySingleton(() => const RouteGenerator());
  sl.registerLazySingleton(() => UiNotifiers());
  sl.registerLazySingleton(() => ImagePicker());
  sl.registerLazySingleton(() => ImageCropper());
  sl.registerLazySingleton(() => LocationManager());

  final dio = Dio();
  (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
    client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    return client;
  };
  sl.registerLazySingleton(() => dio);
}
