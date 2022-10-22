import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get_it/get_it.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:navolaya_flutter/core/route_generator.dart';
import 'package:navolaya_flutter/data/repositoryImpl/auth_repository_impl.dart';
import 'package:navolaya_flutter/data/repositoryImpl/chat_repository_impl.dart';
import 'package:navolaya_flutter/data/repositoryImpl/help_and_info_repository_impl.dart';
import 'package:navolaya_flutter/data/repositoryImpl/master_repository_impl.dart';
import 'package:navolaya_flutter/data/repositoryImpl/profile_repository_impl.dart';
import 'package:navolaya_flutter/data/repositoryImpl/report_user_repository_impl.dart';
import 'package:navolaya_flutter/data/repositoryImpl/support_chat_repository_impl.dart';
import 'package:navolaya_flutter/data/repositoryImpl/users_repository_impl.dart';
import 'package:navolaya_flutter/domain/auth_repository.dart';
import 'package:navolaya_flutter/domain/blocked_users_repository.dart';
import 'package:navolaya_flutter/domain/help_and_info_repository.dart';
import 'package:navolaya_flutter/domain/master_repository.dart';
import 'package:navolaya_flutter/domain/notifications_repository.dart';
import 'package:navolaya_flutter/domain/profile_repository.dart';
import 'package:navolaya_flutter/domain/report_user_repository.dart';
import 'package:navolaya_flutter/domain/user_connections_repository.dart';
import 'package:navolaya_flutter/domain/users_repository.dart';
import 'package:navolaya_flutter/features/image_manager.dart';
import 'package:navolaya_flutter/features/location_manager.dart';
import 'package:navolaya_flutter/features/socket_connection_manager.dart';
import 'package:navolaya_flutter/presentation/bloc/authBloc/auth_bloc.dart';
import 'package:navolaya_flutter/presentation/bloc/chatMessagesBloc/chat_messages_bloc.dart';
import 'package:navolaya_flutter/presentation/bloc/createChatBloc/create_chat_bloc.dart';
import 'package:navolaya_flutter/presentation/bloc/profileBloc/profile_bloc.dart';
import 'package:navolaya_flutter/presentation/bloc/supportChatsBloc/support_chat_bloc.dart';
import 'package:navolaya_flutter/presentation/bloc/userConnectionsBloc/user_connections_bloc.dart';
import 'package:navolaya_flutter/presentation/cubit/blockUsersCubit/block_users_cubit.dart';
import 'package:navolaya_flutter/presentation/cubit/connectionReceivedCubit/connection_received_cubit.dart';
import 'package:navolaya_flutter/presentation/cubit/connectionSentCubit/connection_sent_cubit.dart';
import 'package:navolaya_flutter/presentation/cubit/dashBoardTabChangeNotifier/dash_board_tab_change_notifier_cubit.dart';
import 'package:navolaya_flutter/presentation/cubit/dashBoardTitleNotifierCubit/dash_board_title_notifier_cubit.dart';
import 'package:navolaya_flutter/presentation/cubit/getChatsCubit/get_chats_cubit.dart';
import 'package:navolaya_flutter/presentation/cubit/helpAndInfoCubit/help_and_info_cubit.dart';
import 'package:navolaya_flutter/presentation/cubit/homeTabsNotifierCubit/home_tabs_notifier_cubit.dart';
import 'package:navolaya_flutter/presentation/cubit/mobileVerificationCubit/mobile_verification_cubit.dart';
import 'package:navolaya_flutter/presentation/cubit/myConnectionsCubit/my_connections_cubit.dart';
import 'package:navolaya_flutter/presentation/cubit/nearByUsersCubit/near_by_users_cubit.dart';
import 'package:navolaya_flutter/presentation/cubit/notificationsCubit/notifications_cubit.dart';
import 'package:navolaya_flutter/presentation/cubit/otpTimerCubit/otpTimer_cubit.dart';
import 'package:navolaya_flutter/presentation/cubit/popularUsersCubit/popular_users_cubit.dart';
import 'package:navolaya_flutter/presentation/cubit/recentUsersCubit/recent_users_cubit.dart';
import 'package:navolaya_flutter/presentation/cubit/reportUsersCubit/report_users_cubit.dart';
import 'package:navolaya_flutter/presentation/cubit/socketConnectionCubit/socket_connection_cubit.dart';
import 'package:navolaya_flutter/presentation/cubit/usersVerificationsCubit/users_verifications_cubit.dart';
import 'package:navolaya_flutter/presentation/uiNotifiers/ui_notifiers.dart';
import 'package:navolaya_flutter/util/common_functions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/apiService/base_api_service.dart';
import 'data/apiService/network_api_service.dart';
import 'data/repositoryImpl/blocked_user_repository_Impl.dart';
import 'data/repositoryImpl/notification_repository_impl.dart';
import 'data/repositoryImpl/user_connections_repository_impl.dart';
import 'data/sessionManager/session_manager.dart';
import 'domain/chat_repository.dart';
import 'domain/support_chat_repository.dart';
import 'features/local_notificaion.dart';
import 'presentation/cubit/keyboardVisibilityCubit/key_board_visibility_cubit.dart';
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
    () => UserConnectionsBloc(sl(), sl()),
  );

  //Create Chat Bloc Bloc
  sl.registerFactory(
    () => CreateChatBloc(sl()),
  );

  //Chat message bloc
  sl.registerFactory(
    () => ChatMessagesBloc(sl()),
  );

  //Support Chat message bloc
  sl.registerFactory(
    () => SupportChatBloc(sl(), sl()),
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
    () => DashBoardTabChangeNotifierCubit(),
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

  sl.registerFactory(
    () => ConnectionReceivedCubit(sl()),
  );
  sl.registerFactory(
    () => ConnectionSentCubit(sl()),
  );
  sl.registerFactory(
    () => BlockUsersCubit(sl()),
  );
  sl.registerFactory(
    () => ReportUsersCubit(sl()),
  );
  sl.registerFactory(
    () => GetChatsCubit(sl()),
  );

  sl.registerFactory(
    () => NotificationsCubit(sl(), sl()),
  );
  sl.registerFactory(
    () => KeyBoardVisibilityCubit(),
  );
  sl.registerFactory(
    () => SocketConnectionCubit(sl(), sl()),
  );
}

void _initRepositories() async {
  //Api Service
  sl.registerLazySingleton<BaseAPIService>(
    () => NetworkAPIService(sl(), sl(), sl(), sl(), sl()),
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

  //Blocked User Repository
  sl.registerLazySingleton<BlockedUserRepository>(
    () => BlockedUserRepositoryImpl(sl()),
  );

  //Reported User Repository
  sl.registerLazySingleton<ReportUserRepository>(
    () => ReportUserRepositoryImpl(sl()),
  );

  //Notifications Repository
  sl.registerLazySingleton<NotificationsRepository>(
    () => NotificationRepositoryImpl(sl()),
  );

  //Chat Repository
  sl.registerLazySingleton<ChatRepository>(
    () => ChatRepositoryImpl(sl()),
  );

  //Support Chat Repository
  sl.registerLazySingleton<SupportChatRepository>(
    () => SupportChatRepositoryImpl(sl()),
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
  sl.registerLazySingleton(() => ImageManager(sl()));
  sl.registerLazySingleton(() => SocketConnectionManager(sl()));
  sl.registerLazySingleton(() => LocationManager(sl()));
  sl.registerLazySingleton(() => FirebaseMessaging.instance);
  sl.registerLazySingleton(() => LocalNotification(messaging: sl()));

  final dio = Dio();
  (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
    client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
    return client;
  };
  sl.registerLazySingleton(() => dio);
  //sl.registerLazySingleton(() => ApiExecutionWorker(sl()));
}
