import 'package:flutter/material.dart';
import 'package:navolaya_flutter/core/color_constants.dart';
import 'package:navolaya_flutter/presentation/ui/notifications/widget/notification_icon_bg_widget.dart';

class NotificationsItemWidget extends StatelessWidget {
  final int pos;

  const NotificationsItemWidget({required this.pos, Key? key}) : super(key: key);

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
                    const Expanded(
                        child: Text(
                      'Where does it came from?',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    pos == 0
                        ? Container(
                            decoration: BoxDecoration(
                              color: ColorConstants.appColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                            child: const Text(
                              'New',
                              style: TextStyle(color: Colors.white, fontSize: 10),
                            ),
                          )
                        : const Text(
                            '12:05 PM',
                            style: TextStyle(color: ColorConstants.textColor5, fontSize: 12),
                          ),
                  ]),
                  const Text(
                    'There are many variations of passages of Fake Ipsum available, but the majority suffered',
                    style: TextStyle(fontSize: 12, color: ColorConstants.textColor2, height: 1.5),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
