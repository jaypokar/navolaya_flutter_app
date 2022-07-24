import 'package:flutter/material.dart';
import 'package:navolaya_flutter/data/model/users_model.dart';

import '../../../../core/color_constants.dart';

class UserAboutMeWidget extends StatelessWidget {
  final UserDataModel user;

  const UserAboutMeWidget({required this.user, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'About Me',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 10),
          Text(user.aboutMe ?? '-',
              style: const TextStyle(color: ColorConstants.textColor2, fontSize: 12)),
        ],
      ),
    );
  }
}
