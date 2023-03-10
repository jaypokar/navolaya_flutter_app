import 'package:flutter/material.dart';

class UiNotifiers {
  // this are few ui notifiers for maintaining ui state and helps in improving app performance by avoiding unnecessary builds.


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

}
