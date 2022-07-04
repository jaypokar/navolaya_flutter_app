import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String buttonText;
  final Function onPressButton;
  final bool isWrap;
  final double padding;

  const ButtonWidget({
    required this.buttonText,
    required this.onPressButton,
    this.isWrap = false,
    this.padding = 10,
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
                shape: const StadiumBorder(),
              )
            : ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(40),
                onPrimary: Colors.white,
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
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
