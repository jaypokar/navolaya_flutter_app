import 'package:flutter/material.dart';
import 'package:navolaya_flutter/resources/color_constants.dart';

class ButtonWidget extends StatelessWidget {
  final String buttonText;
  final Function onPressButton;
  final bool isWrap;
  final double padding;
  final double buttonPaddingLeft;
  final double buttonPaddingRight;
  final double buttonPaddingTop;
  final double buttonPaddingBottom;
  final Color color;
  final double textSize;
  final double height;
  final bool isEnabled;

  const ButtonWidget({
    required this.buttonText,
    required this.onPressButton,
    this.isWrap = false,
    this.padding = 10,
    this.textSize = 16,
    this.isEnabled = true,
    this.buttonPaddingLeft = 0,
    this.buttonPaddingRight = 0,
    this.buttonPaddingTop = 0,
    this.buttonPaddingBottom = 0,
    this.height = 40,
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
                minimumSize: Size.fromHeight(height),
                onPrimary: Colors.white,
                primary: color,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
              ),
        onPressed: isEnabled
            ? () {
                onPressButton();
              }
            : null,
        child: Padding(
          padding: EdgeInsets.only(
            left: buttonPaddingLeft,
            right: buttonPaddingRight,
            top: buttonPaddingTop,
            bottom: buttonPaddingTop,
          ),
          child: Text(
            buttonText,
            style: TextStyle(
              color: Colors.white,
              fontSize: textSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
