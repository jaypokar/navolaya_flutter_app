import 'package:flutter/material.dart';
import 'package:navolaya_flutter/data/model/notification_model.dart';
import 'package:navolaya_flutter/presentation/ui/notifications/widget/notification_icon_bg_widget.dart';
import 'package:navolaya_flutter/resources/color_constants.dart';
import 'package:navolaya_flutter/resources/string_resources.dart';
import 'package:navolaya_flutter/util/common_functions.dart';

import '../../../../injection_container.dart';

class NotificationsItemWidget extends StatelessWidget {
  final NotificationDataModel notification;

  const NotificationsItemWidget({required this.notification, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: ColorConstants.notificationItemBackgroundColor),
          borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const NotificationIconBgWidget(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Expanded(
                        child: Text(
                      notification.message!,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    notification.isRead == 0
                        ? Container(
                            decoration: BoxDecoration(
                              color: ColorConstants.appColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                            child: const Text(
                              StringResources.newNotification,
                              style: TextStyle(color: Colors.white, fontSize: 10),
                            ),
                          )
                        : Text(
                            sl<CommonFunctions>().getDateMonthAndTime(notification.createdAt!),
                            style: const TextStyle(
                              color: ColorConstants.textColor5,
                              fontSize: 12,
                            ),
                          ),
                  ]),
                  /*Text(
                    notification.message!,
                    style: const TextStyle(
                        fontSize: 12, color: ColorConstants.textColor2, height: 1.5),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  )*/
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
