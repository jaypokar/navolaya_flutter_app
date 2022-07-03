import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String buttonText;
  final Function onPressButton;
  final bool isWrap;

  const ButtonWidget({
    required this.buttonText,
    required this.onPressButton,
    this.isWrap = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: ElevatedButton(
        style: isWrap
            ? ElevatedButton.styleFrom(
                onPrimary: Colors.white,
                shape: const StadiumBorder(),
              )
            : ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(40),
                onPrimary: Colors.white,
                shape: const StadiumBorder(),
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
