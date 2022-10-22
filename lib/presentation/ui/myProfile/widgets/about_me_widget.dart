import 'package:flutter/material.dart';
import 'package:navolaya_flutter/data/model/login_and_basic_info_model.dart';

import '../../../../resources/color_constants.dart';
import '../../../../resources/string_resources.dart';

class AboutMeWidget extends StatelessWidget {
  final Data user;

  const AboutMeWidget({required this.user, Key? key}) : super(key: key);

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
              style: const TextStyle(color: ColorConstants.textColor2, fontSize: 13)),
        ],
      ),
    );
  }
}
