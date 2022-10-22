import 'package:flutter/material.dart';
import 'package:navolaya_flutter/data/model/notification_model.dart';
import 'package:navolaya_flutter/presentation/ui/notifications/widget/notification_icon_bg_widget.dart';
import 'package:navolaya_flutter/resources/color_constants.dart';
import 'package:navolaya_flutter/util/common_functions.dart';

import '../../../../injection_container.dart';

class NotificationsItemWidget extends StatelessWidget {
  final NotificationDataModel notification;

  const NotificationsItemWidget({required this.notification, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: notification.isRead == 0
              ? ColorConstants.appColor.withOpacity(0.2)
              : ColorConstants.transparent,
          border: Border.all(color: ColorConstants.notificationItemBackgroundColor),
          borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Row(
        children: [
          const NotificationIconBgWidget(),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification.title!,
                  maxLines: 1,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  notification.message!,
                  maxLines: 2,
                  style: const TextStyle(
                    color: ColorConstants.textColor1,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          notification.isRead == 0
              ? const SizedBox.shrink()
              : SizedBox(
                  height: 50,
                  child: Container(
                    height: 10,
                    alignment: Alignment.topRight,
                    child: Text(
                      sl<CommonFunctions>().getMessageTime(notification.createdAt!),
                      style: const TextStyle(
                        color: ColorConstants.textColor5,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
