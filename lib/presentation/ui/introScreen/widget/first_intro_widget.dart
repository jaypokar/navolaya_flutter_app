import 'package:flutter/material.dart';
import 'package:navolaya_flutter/core/color_constants.dart';
import 'package:navolaya_flutter/core/string_file.dart';
import 'package:navolaya_flutter/util/common_functions.dart';

import '../../../../injection_container.dart';

class FirstIntroWidget extends StatelessWidget {
  const FirstIntroWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(sl<CommonFunctions>().getImage(ImageType.firstIntroImage))),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            sl<StringFile>().introScreenTitleOne,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 28, fontWeight: FontWeight.w800, color: ColorConstants.textColor1),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: Text(
            sl<StringFile>().introScreenSubTitleOne,
            textAlign: TextAlign.center,
            style: const TextStyle(
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
