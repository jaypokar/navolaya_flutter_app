import 'package:flutter/material.dart';

import '../../../../core/color_constants.dart';
import '../../../../resources/string_resources.dart';

class BlockedUsersItemWidget extends StatelessWidget {
  const BlockedUsersItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        radius: 30,
        backgroundImage: AssetImage('assets/1.jpg'),
      ),
      title: const Text('Jorden Nielsen'),
      trailing: Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: ColorConstants.appColor),
          borderRadius: BorderRadius.circular(5),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 5,
        ),
        child: Text(
          StringResources.unBlockedUsers.toUpperCase(),
          style: const TextStyle(
            color: ColorConstants.appColor,
            fontSize: 10,
          ),
        ),
      ),
    );
  }
}
