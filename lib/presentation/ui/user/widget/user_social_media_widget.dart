import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:navolaya_flutter/presentation/ui/user/widget/user_social_media_item_widget.dart';

class UserSocialMediaWidget extends StatelessWidget {
  const UserSocialMediaWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> data = [
      {
        'icon': FontAwesomeIcons.facebook,
        'title': 'Facebook',
        'color': const Color(0xFF546BBF),
      },
      {
        'icon': FontAwesomeIcons.twitter,
        'title': 'Twitter',
        'color': const Color(0xFF58C0F3),
      },
      {
        'icon': FontAwesomeIcons.instagram,
        'title': 'Instagram',
        'color': const Color(0xFFBF5EBD),
      },
      {
        'icon': FontAwesomeIcons.linkedin,
        'title': 'Linkedin',
        'color': const Color(0xFF3279B4),
      },
    ];

    return GridView.builder(
      itemCount: data.length,
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.all(20),
      itemBuilder: (ctx, index) => UserSocialMedialItemWidget(
        data: data[index],
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 3.5,
        crossAxisSpacing: 5,
        mainAxisSpacing: 10,
      ),
    );
  }
}
