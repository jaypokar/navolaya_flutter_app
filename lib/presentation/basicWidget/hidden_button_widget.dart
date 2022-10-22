import 'package:flutter/material.dart';

class HiddenButtonWidget extends StatelessWidget {
  const HiddenButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          elevation: 0,
          splashFactory: NoSplash.splashFactory,
          primary: Colors.white,
          fixedSize: const Size(80, 60)),
      onPressed: () {},
      child: const Text(''),
    );
  }
}
