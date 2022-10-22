import 'package:flutter/material.dart';

import '../../resources/color_constants.dart';

class CountryFlagAndCodeRichTextWidget extends StatelessWidget {
  final Function? onClickEvent;
  final String textOne;
  final String textTwo;
  final Color? color;

  const CountryFlagAndCodeRichTextWidget(
      {required this.onClickEvent,
      required this.textOne,
      required this.textTwo,
      this.color = ColorConstants.textColor3,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //widget.pageController.jumpToPage(0);
        if (onClickEvent != null) {
          onClickEvent!();
        }
      },
      child: Row(
        children: [
          Text(textOne, style: const TextStyle(fontSize: 30)),
          const SizedBox(
            width: 5,
          ),
          Text(textTwo, style: TextStyle(color: color, fontSize: 14)),
          const SizedBox(
            width: 4,
          ),
        ],
      ),
    );
  }
}
