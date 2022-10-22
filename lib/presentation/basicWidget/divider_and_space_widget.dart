import 'package:flutter/material.dart';
import 'package:navolaya_flutter/resources/color_constants.dart';

class DividerAndSpaceWidget extends StatelessWidget {
  const DividerAndSpaceWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        SizedBox(
          height: 8,
        ),
        Divider(
          height: 1,
          color: ColorConstants.dividerColor,
        ),
        SizedBox(
          height: 8,
        ),
      ],
    );
  }
}
