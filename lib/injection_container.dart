import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:navolaya_flutter/core/route_generator.dart';
import 'package:navolaya_flutter/util/common_functions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/apiService/base_api_service.dart';
import 'data/apiService/network_api_service.dart';
import 'data/sessionManager/session_manager.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! External /* All the other required external injection are embedded here */
  await _initExternalDependencies();

  // Repository /* All the repository injection are embedded here */
  _initRepositories();

  // Bloc /* All the bloc injection are embedded here */
  _initBlocs();
}

void _initBlocs() {
  //Add Login Bloc
  /* sl.registerFactory(
    () => LoginBloc(
      repository: sl(),
    ),
  );*/
}

void _initRepositories() {
  //Api Service
  sl.registerLazySingleton<BaseAPIService>(
    () => NetworkAPIService(dio: sl(), connectivity: sl()),
  );

  //Login  Repository
  /*sl.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(baseAPIService: sl(), sessionManager: sl()),
  );*/
}

Future<void> _initExternalDependencies() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Connectivity());
  sl.registerLazySingleton(() => SessionManager(sl()));
  sl.registerLazySingleton(() => const CommonFunctions());
  sl.registerLazySingleton(() => const RouteGenerator());

  final dio = Dio();
  (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
    client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    return client;
  };
  sl.registerLazySingleton(() => dio);
}
