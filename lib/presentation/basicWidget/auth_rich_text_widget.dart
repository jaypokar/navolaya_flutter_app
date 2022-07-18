import 'package:flutter/material.dart';

import '../../core/color_constants.dart';

// ignore: must_be_immutable
class AuthRichTextWidget extends StatelessWidget {
  final Function? onClickEvent;
  final String textOne;
  final String textTwo;
  Color? color;

  AuthRichTextWidget({
    required this.onClickEvent,
    required this.textOne,
    required this.textTwo,
    this.color = ColorConstants.appColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //widget.pageController.jumpToPage(0);
        if (onClickEvent != null) {
          onClickEvent!();
        }
      },
      child: RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 14.0, color: Colors.black, fontFamily: 'Montserrat'),
          children: <TextSpan>[
            TextSpan(text: textOne),
            TextSpan(text: textTwo, style: TextStyle(fontWeight: FontWeight.bold, color: color)),
          ],
        ),
      ),
    );
  }
}
