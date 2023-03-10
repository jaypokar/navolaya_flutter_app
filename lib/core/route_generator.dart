import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navolaya_flutter/data/model/users_model.dart';
import 'package:navolaya_flutter/presentation/bloc/chatMessagesBloc/chat_messages_bloc.dart';
import 'package:navolaya_flutter/presentation/bloc/createChatBloc/create_chat_bloc.dart';
import 'package:navolaya_flutter/presentation/bloc/userConnectionsBloc/user_connections_bloc.dart';
import 'package:navolaya_flutter/presentation/cubit/blockUsersCubit/block_users_cubit.dart';
import 'package:navolaya_flutter/presentation/cubit/connectionReceivedCubit/connection_received_cubit.dart';
import 'package:navolaya_flutter/presentation/cubit/dashBoardTabChangeNotifier/dash_board_tab_change_notifier_cubit.dart';
import 'package:navolaya_flutter/presentation/cubit/dashBoardTitleNotifierCubit/dash_board_title_notifier_cubit.dart';
import 'package:navolaya_flutter/presentation/cubit/getChatsCubit/get_chats_cubit.dart';
import 'package:navolaya_flutter/presentation/cubit/mobileVerificationCubit/mobile_verification_cubit.dart';
import 'package:navolaya_flutter/presentation/cubit/myConnectionsCubit/my_connections_cubit.dart';
import 'package:navolaya_flutter/presentation/cubit/notificationsCubit/notifications_cubit.dart';
import 'package:navolaya_flutter/presentation/cubit/pageIndicatorCubit/page_indicator_page_cubit.dart';
import 'package:navolaya_flutter/presentation/cubit/reportUsersCubit/report_users_cubit.dart';
import 'package:navolaya_flutter/presentation/cubit/usersVerificationsCubit/users_verifications_cubit.dart';
import 'package:navolaya_flutter/presentation/ui/auth/authentication_page.dart';
import 'package:navolaya_flutter/presentation/ui/blockedUsers/blocked_users_page.dart';
import 'package:navolaya_flutter/presentation/ui/changePassword/change_password_page.dart';
import 'package:navolaya_flutter/presentation/ui/chatDetail/chat_detail_page.dart';
import 'package:navolaya_flutter/presentation/ui/connectionRequests/connection_requests_page.dart';
import 'package:navolaya_flutter/presentation/ui/editProfile/edit_profile_page.dart';
import 'package:navolaya_flutter/presentation/ui/editProfile/update_additional_info_page.dart';
import 'package:navolaya_flutter/presentation/ui/editProfile/update_basic_info_page.dart';
import 'package:navolaya_flutter/presentation/ui/editProfile/update_phone_or_email_page.dart';
import 'package:navolaya_flutter/presentation/ui/editProfile/update_social_profiles_page.dart';
import 'package:navolaya_flutter/presentation/ui/helpAndInfo/help_and_info_page.dart';
import 'package:navolaya_flutter/presentation/ui/introScreen/intro_page.dart';
import 'package:navolaya_flutter/presentation/ui/myProfile/my_profile_page.dart';
import 'package:navolaya_flutter/presentation/ui/registration/registration_page.dart';
import 'package:navolaya_flutter/presentation/ui/reportedUsers/reported_users_page.dart';
import 'package:navolaya_flutter/presentation/ui/settings/settings_page.dart';
import 'package:navolaya_flutter/presentation/ui/supportChat/support_chat_page.dart';
import 'package:navolaya_flutter/presentation/ui/updateJNVVerification/update_jnv_verification_page.dart';
import 'package:navolaya_flutter/presentation/ui/updatePassword/update_password_page.dart';
import 'package:navolaya_flutter/presentation/ui/user/user_detail_page.dart';
import 'package:navolaya_flutter/presentation/ui/userVerification/user_verification_page.dart';
import 'package:navolaya_flutter/resources/value_key_resources.dart';

import '../injection_container.dart';
import '../presentation/bloc/supportChatsBloc/support_chat_bloc.dart';
import '../presentation/cubit/connectionSentCubit/connection_sent_cubit.dart';
import '../presentation/cubit/helpAndInfoCubit/help_and_info_cubit.dart';
import '../presentation/cubit/homeTabsNotifierCubit/home_tabs_notifier_cubit.dart';
import '../presentation/cubit/nearByUsersCubit/near_by_users_cubit.dart';
import '../presentation/cubit/otpTimerCubit/otpTimer_cubit.dart';
import '../presentation/cubit/popularUsersCubit/popular_users_cubit.dart';
import '../presentation/cubit/recentUsersCubit/recent_users_cubit.dart';
import '../presentation/ui/dashBoard/dashboard_page.dart';
import '../presentation/ui/splash_page.dart';

class RouteGenerator {
  /*Route Names*/
  static const splashScreen = '/';
  static const introPage = '/introPage';
  static const loginPage = '/loginPage';
  static const authenticationPage = '/authenticationPage';
  static const registrationPage = "/registrationPage";
  static const updatePasswordPage = "/updatePasswordPage";
  static const dashBoardPage = '/dashBoardPage';
  static const userDetailPage = '/userDetailPage';
  static const myProfilePage = '/myProfilePage';
  static const connectionRequestPage = '/connectionRequestPage';
  static const editProfilePage = '/editProfilePage';
  static const settingsPage = '/settingsPage';
  static const blockedUserPage = '/blockedUsersPage';
  static const helpAndInfoPage = '/helpAndInfoPage';
  static const updateBasicInfoPage = '/updateBasicInfoPage';
  static const updateAdditionalInfoPage = '/updateAdditionalInfoPage';
  static const updateSocialProfileLinksPage = '/updateSocialProfileLinksPage';
  static const updatePhoneOrEmailPage = '/updatePhoneOrEmailPage';
  static const changePasswordPage = '/changePasswordPage';
  static const userVerificationRequestPage = '/userVerificationRequestPage';
  static const jnvVerificationPage = '/jnvVerificationPage';
  static const chatDetailPage = '/chatDetailPage';
  static const supportChatPage = '/supportChatPage';
  static const reportUserPage = '/reportUserPage';

  const RouteGenerator();

  Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    switch (settings.name) {
      /***-->***/ case splashScreen:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      /***-->***/ case introPage:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<PageIndicatorPageCubit>(
            create: (_) => sl<PageIndicatorPageCubit>(),
            child: const IntroPage(),
          ),
        );
      /***-->***/ case authenticationPage:
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(providers: [
                  BlocProvider(create: (_) => sl<MobileVerificationCubit>()),
                  BlocProvider(create: (_) => sl<HelpAndInfoCubit>()),
                  BlocProvider(create: (_) => sl<OTPTimerCubit>()),
                ], child: const AuthenticationPage()));
      /***-->***/ case registrationPage:
        if (args is Map<String, dynamic>) {
          String countryCode = args[ValueKeyResources.countryCodeKey];
          String mobileNumber = args[ValueKeyResources.mobileNumberKey];
          return MaterialPageRoute(
              builder: (_) => MultiBlocProvider(
                    providers: [
                      BlocProvider<PageIndicatorPageCubit>(
                          create: (_) => sl<PageIndicatorPageCubit>()),
                      BlocProvider(create: (_) => sl<HelpAndInfoCubit>()),
                    ],
                    child: RegistrationPage(
                      countryCode: countryCode,
                      mobileNumber: mobileNumber,
                    ),
                  ));
        }
        return _errorRoute();
      /***-->***/ case updatePasswordPage:
        if (args is Map<String, dynamic>) {
          String countryCode = args[ValueKeyResources.countryCodeKey];
          String mobileNumber = args[ValueKeyResources.mobileNumberKey];
          return MaterialPageRoute(
              builder: (_) => BlocProvider<OTPTimerCubit>(
                    create: (_) => sl<OTPTimerCubit>(),
                    child: UpdatePasswordPage(
                      countryCode: countryCode,
                      mobileNumber: mobileNumber,
                    ),
                  ));
        }
        return _errorRoute();
      /***-->***/ case dashBoardPage:
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(providers: [
                  BlocProvider(create: (_) => sl<HomeTabsNotifierCubit>()),
                  BlocProvider(create: (_) => sl<DashBoardTitleNotifierCubit>()),
                  BlocProvider(create: (_) => sl<DashBoardTabChangeNotifierCubit>()),
                  BlocProvider(create: (_) => sl<MyConnectionsCubit>()),
                  BlocProvider(create: (_) => sl<NotificationsCubit>()),
                  BlocProvider(create: (_) => sl<RecentUsersCubit>()),
                  BlocProvider(create: (_) => sl<NearByUsersCubit>()),
                  BlocProvider(create: (_) => sl<PopularUsersCubit>()),
                  BlocProvider(create: (_) => sl<GetChatsCubit>()),
                ], child: const DashBoardPage()));
      /***-->***/ case connectionRequestPage:
        return MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider<ConnectionReceivedCubit>(
                      create: (_) => sl<ConnectionReceivedCubit>(),
                    ),
                    BlocProvider<ConnectionSentCubit>(
                      create: (_) => sl<ConnectionSentCubit>(),
                    ),
                  ],
                  child: const ConnectionRequestsPage(),
                ));
      /***-->***/ case userVerificationRequestPage:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (_) => sl<UsersVerificationsCubit>(),
                  child: const UserVerificationPage(),
                ));
      /***-->***/ case editProfilePage:
        return MaterialPageRoute(builder: (_) => const EditProfilePage());
      /***-->***/ case settingsPage:
        return MaterialPageRoute(builder: (_) => const SettingsPage());
      /***-->***/ case blockedUserPage:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<BlockUsersCubit>(
                  create: (_) => sl<BlockUsersCubit>(),
                  child: const BlockedUsersPage(),
                ));
      /***-->***/ case helpAndInfoPage:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                  create: (_) => sl<HelpAndInfoCubit>(),
                  child: const HelpAndInfoPage(),
                ));
      /***-->***/ case updateBasicInfoPage:
        return MaterialPageRoute(builder: (_) => const UpdateBasicInfoPage());
      /***-->***/ case updateAdditionalInfoPage:
        return MaterialPageRoute(builder: (_) => const UpdateAdditionalInfoPage());
      /***-->***/ case updateSocialProfileLinksPage:
        return MaterialPageRoute(builder: (_) => const UpdateSocialProfilesPage());
      /***-->***/ case changePasswordPage:
        return MaterialPageRoute(builder: (_) => const ChangePasswordPage());
      /***-->***/ case updatePhoneOrEmailPage:
        if (args is bool) {
          return MaterialPageRoute(
              builder: (_) => MultiBlocProvider(
                    providers: [
                      BlocProvider(create: (_) => sl<MobileVerificationCubit>()),
                      BlocProvider(create: (_) => sl<OTPTimerCubit>())
                    ],
                    child: UpdatePhoneOrEmailPage(isEmail: args),
                  ));
        }
        return _errorRoute();
      /***-->***/ case userDetailPage:
        if (args is Map<String, dynamic>) {
          final user = args[ValueKeyResources.userDataKey] as UserDataModel;
          final isNearBy = args[ValueKeyResources.nearByDistanceKey];

          return MaterialPageRoute(
              builder: (_) => MultiBlocProvider(
                    providers: [
                      BlocProvider(create: (_) => sl<BlockUsersCubit>()),
                      BlocProvider(create: (_) => sl<ReportUsersCubit>()),
                      BlocProvider(create: (_) => sl<UserConnectionsBloc>()),
                      BlocProvider(create: (_) => sl<CreateChatBloc>()),
                    ],
                    child: UserDetailPage(
                      user: user,
                      isNearBy: isNearBy,
                    ),
                  ));
        }
        return _errorRoute();
      /***-->***/ case myProfilePage:
        return MaterialPageRoute(builder: (_) => const MyProfilePage());
      /***-->***/ case chatDetailPage:
        if (args is Map<String, dynamic>) {
          return MaterialPageRoute(
              builder: (_) => MultiBlocProvider(
                  providers: [BlocProvider(create: (_) => sl<ChatMessagesBloc>())],
                  child: ChatDetailPage(
                    chatDetails: args[ValueKeyResources.chatDetailDataKey],
                    chatStatus: args[ValueKeyResources.chatStatusKey],
                  )));
        }
        return _errorRoute();
      /***-->***/ case jnvVerificationPage:
        return MaterialPageRoute(builder: (_) => const UpdateJNVVerificationPage());
      /***-->***/ case supportChatPage:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<SupportChatBloc>(
                create: (_) => sl<SupportChatBloc>(), child: const SupportChatPage()));
      /***-->***/ case reportUserPage:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<ReportUsersCubit>(
                create: (_) => sl<ReportUsersCubit>(), child: const ReportedUsersPage()));

      default:
        return _errorRoute();
    }
  }

  Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Wrong Route'),
        ),
        body: const Center(
          child: Text(
              'Sorry you have been redirected to wrong page or have been passed by wrong data!!'),
        ),
      );
    });
  }
}
