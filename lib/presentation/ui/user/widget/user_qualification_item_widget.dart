import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/color_constants.dart';

class UserQualificationItemWidget extends StatelessWidget {
  final String title;
  final IconData iconData;
  const UserQualificationItemWidget({required this.title,required this.iconData,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children:  [
        Icon(
          iconData,
          color: iconData == FontAwesomeIcons.shirt ? Colors.red : ColorConstants.textColor2,
          size: 14,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          title,
          style: const TextStyle(
            color: ColorConstants.textColor2,
            fontSize: 12,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
      ],
    );
  }
}
