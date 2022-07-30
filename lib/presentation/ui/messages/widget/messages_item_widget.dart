import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../resources/color_constants.dart';

class MessagesItemWidget extends StatelessWidget {
  const MessagesItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundImage: AssetImage('assets/1.jpg'),
        radius: 30,
      ),
      title: const Text('Jordan Nielsen'),
      subtitle: Row(
        children: const [
          Icon(
            FontAwesomeIcons.checkDouble,
            color: ColorConstants.textColor3,
            size: 12,
          ),
          SizedBox(
            width: 5,
          ),
          Expanded(
            child: Text(
              'It is a long established fact that...',
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: ColorConstants.textColor3,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
