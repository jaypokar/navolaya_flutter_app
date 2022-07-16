import 'package:flutter/material.dart';

class OtpWidget extends StatelessWidget {
  final TextEditingController textEditingController;

  const OtpWidget({required this.textEditingController, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      margin: const EdgeInsets.all(5),
      child: TextField(
        controller: textEditingController,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        onChanged: (_) {
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
