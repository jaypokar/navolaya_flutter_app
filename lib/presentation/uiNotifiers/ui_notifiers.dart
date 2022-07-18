import 'package:flutter/material.dart';

class UiNotifiers {
  // this are few ui notifiers for maintaining ui state and helps in improving app performance by avoiding unnecessary builds.
  ///
  ///
  //Step and intro screen pager indicator notifier
  final _indicatorNotifier = ValueNotifier<int>(0);

  ValueNotifier<int> get indicatorNotifier => _indicatorNotifier;

  ///
  //Step pager in registration screen indicator notifier
  final _stepsIndicatorNotifier = ValueNotifier<int>(0);

  ValueNotifier<int> get stepsIndicatorNotifier => _stepsIndicatorNotifier;

  ///
  //Step pager in registration screen indicator notifier
  final _mobileVerificationTitleNotifier = ValueNotifier<String>('');

  ValueNotifier<String> get mobileVerificationTitleNotifier => _mobileVerificationTitleNotifier;

  ///
  //home page user tabs changes notifier

  ValueNotifier<int>? _recentNearByPopularUserTabNotifier;

  ValueNotifier<int>? createRecentNearByPopularUserTabNotifier() {
    _recentNearByPopularUserTabNotifier = ValueNotifier<int>(0);
    return _recentNearByPopularUserTabNotifier;
  }

  ValueNotifier<int> get recentNearByPopularUserTabNotifier => _recentNearByPopularUserTabNotifier!;

  ///
  //dashBoard main tabs changes notifier

  ValueNotifier<String>? _dashBoardTitleNotifier;

  ValueNotifier<String>? createDashBoardTitleNotifier() {
    _dashBoardTitleNotifier = ValueNotifier<String>('Discover');
    return _dashBoardTitleNotifier;
  }

  ValueNotifier<String?> get dashBoardTitleNotifier => _dashBoardTitleNotifier!;

  ///
  //Connections - requests tabs changes notifier [the method below is used because while exiting the screen
  // the notifier will be disposes so when we come back to that screen it needs new notifier object to work on
  // so we will get access of the object through method]
  ValueNotifier<int>? _connectionRequestTabNotifier;

  ValueNotifier<int>? createConnectionRequestTabNotifier() {
    _connectionRequestTabNotifier = ValueNotifier<int>(0);
    return _connectionRequestTabNotifier;
  }

  ValueNotifier<int> get connectionRequestTabNotifier => _connectionRequestTabNotifier!;

  ///
  //Ui notifier for showing timer when otp is sent and timer is sent to reset
  ValueNotifier<int>? _otpResendTimer;

  ValueNotifier<int>? createOTPResendTimerNotifier() {
    _otpResendTimer = ValueNotifier<int>(0);
    return _otpResendTimer;
  }

  ValueNotifier<int> get otpResendTimer => _otpResendTimer!;
}
