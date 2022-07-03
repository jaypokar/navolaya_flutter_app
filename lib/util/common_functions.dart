import 'package:flutter/material.dart';

enum ImageType { logo, checkIcon, kidAvatar, kidIcon, quizIcon, testIcon, coachIcon }

class CommonFunctions {
  const CommonFunctions();

  void showSnackBar(
      {required BuildContext context,
      required String message,
      required Color bgColor,
      required Color textColor}) {
    final snackBar = SnackBar(
      content: Text(
        message,
        style: TextStyle(color: textColor, fontSize: 16, fontWeight: FontWeight.bold),
      ),
      backgroundColor: bgColor,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  String getImage(ImageType imageType) {
    if (imageType == ImageType.logo) {
      return "assets/icon/logo.jpg";
    } else if (imageType == ImageType.checkIcon) {
      return "assets/icon/check_icon.png";
    } else if (imageType == ImageType.kidAvatar) {
      return "assets/icon/kid_avatar.png";
    } else if (imageType == ImageType.kidIcon) {
      return "assets/icon/kid_icon.png";
    } else if (imageType == ImageType.quizIcon) {
      return "assets/icon/quiz_icon.png";
    } else if (imageType == ImageType.testIcon) {
      return "assets/icon/test_icon.svg";
    } else if (imageType == ImageType.coachIcon) {
      return "assets/icon/coach_icon.png";
    }

    return "";
  }
}
