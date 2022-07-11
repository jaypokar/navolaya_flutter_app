import 'package:flutter/material.dart';

import 'widget/notifications_item_widget.dart';

class NotificationsWidget extends StatelessWidget {
  const NotificationsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemBuilder: (_, i) {
          return NotificationsItemWidget(
            pos: i,
          );
        },
        itemCount: 10);
  }
}
