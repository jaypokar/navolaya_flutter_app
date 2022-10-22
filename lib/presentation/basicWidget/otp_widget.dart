import 'package:flutter/material.dart';

class OtpWidget extends StatelessWidget {
  final TextEditingController textEditingController;
  final FocusNode textControllerFocusNode;

  const OtpWidget(
      {required this.textEditingController, required this.textControllerFocusNode, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      margin: const EdgeInsets.all(5),
      child: TextField(
        focusNode: textControllerFocusNode,
        controller: textEditingController,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        onChanged: (_) {
          if (textEditingController.text.isEmpty) {
            FocusScope.of(context).previousFocus();
            return;
          }
          FocusScope.of(context).nextFocus();
        },
        style: const TextStyle(
          fontSize: 14,
        ),
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
          isDense: true,
          counterText: '',
        ),
      ),
    );
  }
}
