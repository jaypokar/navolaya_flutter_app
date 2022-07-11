import 'package:flutter/material.dart';

class DividerAndSpaceWidget extends StatelessWidget {
  const DividerAndSpaceWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        SizedBox(
          height: 15,
        ),
        Divider(
          height: 1,
        ),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
