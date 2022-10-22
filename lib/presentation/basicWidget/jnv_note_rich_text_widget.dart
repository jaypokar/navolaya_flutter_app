import 'package:flutter/material.dart';

import '../../resources/color_constants.dart';

class JnvNoteRichTextWidget extends StatelessWidget {
  final Function? onClickEvent;
  final String textOne;
  final String textTwo;
  final Color? color;

  const JnvNoteRichTextWidget(
      {required this.onClickEvent,
      required this.textOne,
      required this.textTwo,
      this.color = ColorConstants.red,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: const TextStyle(fontSize: 10.0, color: Colors.black, fontFamily: 'Poppins'),
          children: <TextSpan>[
            TextSpan(text: textOne, style: TextStyle(fontWeight: FontWeight.bold, color: color)),
            TextSpan(text: textTwo, style: TextStyle(color: color)),
          ],
        ),
      ),
    );
  }
}
