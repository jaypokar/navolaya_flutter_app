import 'dart:math';

import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:navolaya_flutter/core/global_nav_key.dart';

import '../presentation/basicWidget/custom_button.dart';
import '../resources/color_constants.dart';

class CommonFunctions {
  static final DateFormat _formatter = DateFormat('dd MMM,yyyy');
  static final DateFormat _yearFormatter = DateFormat('yyyy');
  static final DateFormat _monthFormatter = DateFormat('dd MMM');
  static final DateFormat _dayMonthAndTimeFormatter = DateFormat('hh:mm a');
  static final DateFormat _messageTimeFormatter = DateFormat('hh:mm a');
  static final DateFormat _dayMonthYear = DateFormat('dd/MM/yyyy');

  final String urlPattern =
      r'^((?:.|\n)*?)((http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?)';

  final urlRegex = r'^(http|https)://';

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
      margin:
          EdgeInsets.only(bottom: MediaQuery.of(context).size.height - 200, right: 20, left: 20),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      duration: Duration(seconds: duration),
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(color: textColor, fontSize: 14, fontFamily: 'Poppins'),
      ),
      backgroundColor: bgColor,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> showFlushBar(
      {required BuildContext context,
      required String message,
      Color bgColor = ColorConstants.messageBgColor,
      Color textColor = Colors.white,
      int duration = 4}) async {
    await Flushbar(
      margin: const EdgeInsets.all(20),
      borderRadius: BorderRadius.circular(8),
      flushbarPosition: FlushbarPosition.TOP,
      flushbarStyle: FlushbarStyle.FLOATING,
      backgroundColor: bgColor,
      isDismissible: true,
      duration: Duration(seconds: duration),
      messageText: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 14, color: textColor, fontFamily: "Poppins"),
      ),
    ).show(GlobalNavKey.navState.currentState!.context);
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

  String getDateMonthAndTime(String dateTime) {
    final DateTime dt1 = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(dateTime);
    final String expDateNew = _dayMonthAndTimeFormatter.format(dt1);
    return expDateNew;
  }

  String convertDateToDayMonthYear(String date) {
    final DateTime dt1 = DateFormat("yyyy-MM-dd").parse(date);
    return _dayMonthYear.format(dt1);
  }

  String getMessageTime(String dateTime) {
    final DateTime dt1 = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(dateTime, true).toLocal();
    return convertToAgo(dt1);
  }

  String getSentMessageTime() {
    final DateTime dt1 = DateTime.now();
    return convertToAgo(dt1);
  }

  String formatISOTime(DateTime date) {
    return DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").format(date);
  }

  bool
      isValidUrl(String url) => /*Uri.parse(url).isAbsolute*/ RegExp(urlRegex, caseSensitive: false)
          .hasMatch(url);

  String convertToAgo(DateTime input) {
    Duration diff = DateTime.now().difference(input);

    if (diff.inDays >= 1) {
      if (diff.inDays > 7) {
        return _monthFormatter.format(input);
      }
      return diff.inDays > 1 ? '${diff.inDays} days ago' : '${diff.inDays} day ago';
    } else if (diff.inHours >= 1) {
      return diff.inHours > 1 ? '${diff.inHours} hours ago' : '${diff.inHours} hour ago';
    } else if (diff.inMinutes >= 1) {
      return diff.inMinutes > 1 ? '${diff.inMinutes} min ago' : '${diff.inMinutes} minute ago';
    }
    /*else if (diff.inSeconds >= 1){
      return diff.inSeconds>1?'${diff.inSeconds} seconds ago':'${diff.inSeconds} second ago';
    }*/
    else {
      return 'just now';
    }
  }

  void animateWidgetWhenKeyboardOpens(
      {required ScrollController scrollController, required bool isKeyBoardVisible}) {
    scrollController.animateTo(
      isKeyBoardVisible
          ? scrollController.position.pixels + 90
          : scrollController.position.pixels - 90,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
    );
  }

  Future<bool> showConfirmationDialog(
      {required BuildContext context,
      required String title,
      required String message,
      required String buttonPositiveText,
      required String buttonNegativeText}) async {
    final result = await showDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
          child: SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: ColorConstants.textColor2,
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ButtonWidget(
                            height: 35,
                            buttonText: buttonPositiveText,
                            padding: 0,
                            textSize: 16,
                            onPressButton: () {
                              Navigator.of(context).pop(true);
                            }),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size.fromHeight(35),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            side: const BorderSide(
                              width: 1.0,
                              color: ColorConstants.textColor3,
                            ),
                          ),
                          child: Text(
                            buttonNegativeText,
                            style: const TextStyle(color: ColorConstants.textColor3, fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
    return result ?? false;
  }
}
