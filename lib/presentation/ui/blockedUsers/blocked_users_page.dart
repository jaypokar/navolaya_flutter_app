import 'package:flutter/material.dart';
import 'package:navolaya_flutter/presentation/ui/blockedUsers/widget/blocked_users_item_widget.dart';

import '../../../resources/string_resources.dart';

class BlockedUsersPage extends StatelessWidget {
  const BlockedUsersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          StringResources.blockedUsers,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView.separated(
        itemBuilder: (_, i) {
          return const BlockedUsersItemWidget();
        },
        separatorBuilder: (_, i) {
          return const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Divider(
              height: 1,
              color: Colors.grey,
            ),
          );
        },
        padding: const EdgeInsets.symmetric(vertical: 15),
        itemCount: 10,
      ),
    );
  }
}
