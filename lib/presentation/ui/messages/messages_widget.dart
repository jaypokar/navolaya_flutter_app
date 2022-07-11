import 'package:flutter/material.dart';

import 'widget/messages_item_widget.dart';

class MessagesWidget extends StatelessWidget {
  const MessagesWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemBuilder: (_, i) {
          return const MessagesItemWidget();
        },
        separatorBuilder: (_, i) {
          return const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Divider(
              height: 1,
              color: Colors.grey,
            ),
          );
        },
        itemCount: 10);
  }
}
