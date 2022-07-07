import 'package:flutter/material.dart';
import 'package:navolaya_flutter/core/color_constants.dart';
import 'package:navolaya_flutter/resources/image_resources.dart';
import 'package:navolaya_flutter/resources/string_resources.dart';

class FirstIntroWidget extends StatelessWidget {
  const FirstIntroWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(ImageResources.firstIntroImg)),
        const SizedBox(
          height: 20,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            StringResources.introScreenTitleOne,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 28, fontWeight: FontWeight.w800, color: ColorConstants.textColor1),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 50),
          child: Text(
            StringResources.introScreenSubTitleOne,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: ColorConstants.textColor2,
                height: 1.8),
          ),
        ),
      ],
    );
  }
}
