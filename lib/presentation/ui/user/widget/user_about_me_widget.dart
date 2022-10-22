import 'package:flutter/material.dart';
import 'package:navolaya_flutter/data/model/users_model.dart';
import 'package:navolaya_flutter/resources/string_resources.dart';

import '../../../../resources/color_constants.dart';

class UserAboutMeWidget extends StatelessWidget {
  final UserDataModel user;

  const UserAboutMeWidget({required this.user, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            StringResources.aboutMe,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 21),
          ),
          const SizedBox(height: 10),
          Text(user.aboutMe ?? '-',
              style: const TextStyle(color: ColorConstants.textColor3, fontSize: 13)),
        ],
      ),
    );
  }
}
