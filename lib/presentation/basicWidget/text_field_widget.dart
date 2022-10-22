import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../resources/color_constants.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType textInputType;
  final String hint;
  final int max;
  final bool isEnabled;
  final Widget? suffixIcon;
  final int? maxLines;
  final String regex;
  final bool textInCaps;
  final Function? onValueChanged;
  final bool allowSmileys;
  final Widget? prefixIcon;

  const TextFieldWidget({
    required this.controller,
    required this.hint,
    this.textInputType = TextInputType.text,
    this.max = 30,
    this.isEnabled = true,
    this.suffixIcon,
    this.regex = '',
    this.maxLines = 1,
    this.textInCaps = false,
    this.allowSmileys = false,
    this.onValueChanged,
    this.prefixIcon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: textInputType,
      enabled: isEnabled,
      style:
          TextStyle(fontSize: 14, color: isEnabled ? Colors.black : ColorConstants.disabledColor),
      onChanged: (String value) {
        if (onValueChanged != null) {
          onValueChanged!(value);
        }
      },
      textCapitalization: textInCaps ? TextCapitalization.sentences : TextCapitalization.none,
      maxLength: max,
      maxLines: maxLines,
      textAlign: TextAlign.start,
      inputFormatters: regex.isEmpty
          ? allowSmileys
              ? []
              : [
                  FilteringTextInputFormatter.deny(
                    RegExp(
                        r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])'),
                  ),
                ]
          : [
              FilteringTextInputFormatter.allow(RegExp(regex)),
              if (!allowSmileys) ...[
                FilteringTextInputFormatter.deny(
                  RegExp(
                      r'(\u00a9|\u00ae|[\u2000-\u3300]|\ud83c[\ud000-\udfff]|\ud83d[\ud000-\udfff]|\ud83e[\ud000-\udfff])'),
                )
              ]
            ],
      decoration: setInputDecoration(),
    );
  }

  InputDecoration setInputDecoration() {
    return prefixIcon != null
        ? InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(width: 1),
            ),
            prefixIcon: prefixIcon,
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
            contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10))
        : InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: const BorderSide(width: 1),
            ),
            /*prefixIcon: prefixIcon ?? const SizedBox(width: 0,),*/
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
            contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10));
  }
}
