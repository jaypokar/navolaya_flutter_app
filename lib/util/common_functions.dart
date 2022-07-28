import 'dart:math';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CommonFunctions {
  static final DateFormat _formatter = DateFormat('dd MMM,yyyy');
  static final DateFormat _yearFormatter = DateFormat('yyyy');
  static final DateFormat _monthFormatter = DateFormat('dd MMM');

  const CommonFunctions();

  MaterialColor createMaterialColor(Color color) {
    final List<double> strengths = <double>[.05];
    final Map<int, Color> swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    // ignore: avoid_function_literals_in_foreach_calls

    for (final strength in strengths) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    }
    return MaterialColor(color.value, swatch);
  }

  void showSnackBar(
      {required BuildContext context,
      required String message,
      required Color bgColor,
      required Color textColor,
      int duration = 2}) {
    final snackBar = SnackBar(
      duration: Duration(seconds: duration),
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(color: textColor, fontSize: 16, fontFamily: 'Montserrat'),
      ),
      backgroundColor: bgColor,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showFlushBar(
      {required BuildContext context,
      required String message,
      required Color bgColor,
      required Color textColor,
      int duration = 4}) {
    Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      reverseAnimationCurve: Curves.decelerate,
      forwardAnimationCurve: Curves.elasticOut,
      backgroundColor: bgColor,
      isDismissible: true,
      duration: Duration(seconds: duration),
      messageText: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 14, color: textColor, fontFamily: "Montserrat"),
      ),
    ).show(context);
  }

  String getFileSizeString({required int bytes, int decimals = 0}) {
    const suffixes = ["b", "kb", "mb", "gb", "tb"];
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) + suffixes[i];
  }

  String convertedDate(String dateTime) {
    final DateTime dt1 = DateTime.parse(dateTime.substring(0, 10));
    final String expDateNew = _formatter.format(dt1);
    return expDateNew;
  }

  String getBirthYear(String dateTime) {
    final DateTime dt1 = DateTime.parse(dateTime.substring(0, 10));
    final String expDateNew = _yearFormatter.format(dt1);
    return expDateNew;
  }

  String getBirthMonth(String dateTime) {
    final DateTime dt1 = DateTime.parse(dateTime.substring(0, 10));
    final String expDateNew = _monthFormatter.format(dt1);
    return expDateNew;
  }
}
