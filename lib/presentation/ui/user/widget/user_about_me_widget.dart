import 'package:flutter/material.dart';

import '../../../../core/color_constants.dart';

class UserAboutMeWidget extends StatelessWidget {
  const UserAboutMeWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'About Me',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
              'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised.',
              style: TextStyle(color: ColorConstants.textColor1, fontSize: 12)),
        ],
      ),
    );
  }
}
