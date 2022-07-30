import 'package:flutter/material.dart';

import '../../resources/color_constants.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType textInputType;
  final String hint;
  final int max;
  final bool isEnabled;
  final Widget? suffixIcon;
  final int maxLines;

  const TextFieldWidget({
    required this.controller,
    required this.hint,
    this.textInputType = TextInputType.text,
    this.max = 30,
    this.isEnabled = true,
    this.suffixIcon,
    this.maxLines = 1,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: textInputType,
      enabled: isEnabled,
      style: const TextStyle(
        fontSize: 14,
      ),
      /*textCapitalization: TextCapitalization.none,*/
      maxLength: max,
      maxLines: maxLines,
      textAlign: TextAlign.start,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(width: 1),
          ),
          suffixIcon: suffixIcon,
          labelText: hint,
          counterText: "",
          labelStyle: const TextStyle(color: ColorConstants.textColor3),
          isDense: true,
          alignLabelWithHint: true,
          hintStyle: const TextStyle(
            fontSize: 14,
            color: ColorConstants.inputBorderColor,
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorConstants.inputBorderColor,
            ),
          ),
          disabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: ColorConstants.inputBorderColor,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10)),
    );
  }
}
