import 'package:flutter/material.dart';

import '../../../../core/color_constants.dart';

class NotificationIconBgWidget extends StatelessWidget {
  const NotificationIconBgWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      width: 64,
      decoration: BoxDecoration(
        color: ColorConstants.notificationItemBackgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Icon(
        Icons.notifications,
        size: 38,
        color: ColorConstants.notificationBellIconColor,
      ),
    );
  }
}
