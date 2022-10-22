import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../../resources/color_constants.dart';

class UserQualificationItemWidget extends StatelessWidget {
  final String title;
  final String icon;
  final Color? color;
  final bool shouldItemExpanded;
  final double iconHeight;
  final double iconWidth;
  final double textSize;

  const UserQualificationItemWidget({
    required this.title,
    required this.icon,
    this.color = ColorConstants.userDetailIconsColor,
    this.shouldItemExpanded = false,
    this.iconHeight = 14,
    this.iconWidth = 14,
    this.textSize = 13,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          icon,
          color: color,
          height: iconHeight,
          width: iconWidth,
        ),
        const SizedBox(
          width: 8,
        ),
        shouldItemExpanded
            ? Expanded(
                child: AutoSizeText(
                  title,
                  softWrap: true,
                  wrapWords: true,
                  maxLines: 1,
                  minFontSize: 12,
                  style: TextStyle(
                      color: ColorConstants.textColor3,
                      fontSize: textSize,
                      fontWeight: FontWeight.w400),
                ),
              )
            : Text(
                title,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                style: TextStyle(
                    color: ColorConstants.textColor3,
                    fontSize: textSize,
                    fontWeight: FontWeight.w400),
              ),
        const SizedBox(
          width: 8,
        ),
      ],
    );
  }
}
