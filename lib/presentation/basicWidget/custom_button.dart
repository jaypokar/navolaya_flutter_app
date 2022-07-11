import 'package:flutter/material.dart';
import 'package:navolaya_flutter/core/color_constants.dart';

class ButtonWidget extends StatelessWidget {
  final String buttonText;
  final Function onPressButton;
  final bool isWrap;
  final double padding;
  final Color color;

  const ButtonWidget({
    required this.buttonText,
    required this.onPressButton,
    this.isWrap = false,
    this.padding = 10,
    this.color = ColorConstants.appColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: ElevatedButton(
        style: isWrap
            ? ElevatedButton.styleFrom(
          onPrimary: Colors.white,
                primary: color,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              )
            : ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(40),
                onPrimary: Colors.white,
                primary: color,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              ),
        onPressed: () {
          onPressButton();
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            buttonText,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
