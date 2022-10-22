import 'dart:async';
import 'dart:io';

import 'package:eraser/eraser.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' as schedular;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:navolaya_flutter/core/global_nav_key.dart';
import 'package:navolaya_flutter/core/logger.dart';
import 'package:navolaya_flutter/data/sessionManager/session_manager.dart';
import 'package:navolaya_flutter/injection_container.dart';
import 'package:navolaya_flutter/presentation/bloc/profileBloc/profile_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

AndroidNotificationChannel _channel = const AndroidNotificationChannel(
  'Notifications',
  "Incoming notifications",
  importance: Importance.max,
);

final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

final AndroidNotificationDetails _androidPlatformChannelSpecifics = AndroidNotificationDetails(
  _channel.id,
  _channel.name,
  importance: Importance.max,
  priority: Priority.max,
  enableLights: true,
);

const IOSNotificationDetails _iOSPlatformChannelSpecifics = IOSNotificationDetails(
  presentSound: true,
  presentAlert: true,
  presentBadge: true,
);

final NotificationDetails _platformChannelSpecifics = NotificationDetails(
  android: _androidPlatformChannelSpecifics,
  iOS: _iOSPlatformChannelSpecifics,
);

class LocalNotification {
  final FirebaseMessaging messaging;

  LocalNotification({required this.messaging}) {
    _requestPlatformSpecificPermission();
    _initializeAllNotificationSettings();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  }

  Future<void> _requestPlatformSpecificPermission() async {
    /******* IOS notifications permission ***********/

    if (Platform.isIOS) {
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    } else {
      try {
        await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
            ?.requestPermission();
      } catch (e) {
        logger.e(e);
      }
    }

    await messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    await messaging.requestPermission(
      announcement: true,
      carPlay: true,
      criticalAlert: true,
    );
  }

  Future<void> _initializeAllNotificationSettings() async {
    /***** Platform specific settings to add for notifications ******/

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(_channel);

    final IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings(
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {
      if (payload != null) {
        logger.i('notification payload: $payload');
        schedular.SchedulerBinding.instance.addPostFrameCallback((_) async {
          /*Navigator.pushNamed(GlobalNavKey.navState.currentState!.context, editInquiryPage,
              arguments: num.parse(payload));*/
        });
      }
    });

    final InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    /************************** click event handling ***********************************/

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      if (payload != null) {
        debugPrint('notification payload: $payload');
        schedular.SchedulerBinding.instance.addPostFrameCallback((_) {
          /*Navigator.pushNamed(GlobalNavKey.navState.currentState!.context, editInquiryPage,
              arguments: num.parse(payload));*/
        });
      }
    });
  }

  Future<void> initiateNotificationListening(BuildContext context) async {
    /****** Initialize and show notifications listening and handling *****/

    messaging.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        logger.i('messageReceived => $message');
        _navigateToDetailScreen(message, context);
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      logger.i('Firebase Push Notification Message : $message');
      _displayNotification(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      logger.i('messageReceived => ${message.notification}');
      _navigateToDetailScreen(message, context);
    });
  }

  void _navigateToDetailScreen(RemoteMessage message, BuildContext context) {
    schedular.SchedulerBinding.instance.addPostFrameCallback((_) async {});
  }

  Future<void> _displayNotification(RemoteMessage? message) async {
    if (message != null) {
      final String title = message.notification!.title.toString();
      final String body = message.notification!.body.toString();
      if (message.data.containsKey('reopenApp')) {
        if (message.data.containsKey('auth_token')) {
          final token = message.data['auth_token'];
          sl<SessionManager>().updateToken(token);
        }
        final currentState = GlobalNavKey.navState.currentState;
        if (currentState != null) {
          try {
            currentState.context.read<ProfileBloc>().add(const GetProfileEvent());
          } catch (e) {
            //logger(e);
          }
        }
      }

      String payload = '';
      await flutterLocalNotificationsPlugin.show(
        1,
        title,
        body,
        _platformChannelSpecifics,
        payload: payload,
      );
    }
  }

  void showNotificationOnMessageReceived(
      {required String userID, required String userName, required String message}) async {
    String payload = '';
    await flutterLocalNotificationsPlugin.show(
      1,
      userName,
      message,
      _platformChannelSpecifics,
      payload: payload,
    );
  }

  void removeAllBadgeCount() {
    logger.i('the app badge is updated');
    try {
      Eraser.clearAllAppNotifications();
      Eraser.resetBadgeCountAndRemoveNotificationsFromCenter();
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage? message) async {
  await Firebase.initializeApp();
  if (message != null) {
    logger.i('Firebase Push Notification Message : $message');
  }
  if (message != null) {
    final String title = message.notification!.title.toString();
    final String body = message.notification!.body.toString();
    String payload = '';

    final sharedPreferences = await SharedPreferences.getInstance();
    final session = SessionManager(sharedPreferences);
    if (message.data.containsKey('reopenApp')) {
      final token = message.data['auth_token'];
      session.updateToken(token);
    }

    await flutterLocalNotificationsPlugin.show(
      int.parse(payload),
      title,
      body,
      _platformChannelSpecifics,
      payload: payload,
    );
  }
}
