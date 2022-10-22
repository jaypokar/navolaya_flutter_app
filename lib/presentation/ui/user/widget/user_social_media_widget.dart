import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:navolaya_flutter/data/model/users_model.dart';
import 'package:navolaya_flutter/presentation/ui/user/widget/user_social_media_item_widget.dart';
import 'package:navolaya_flutter/resources/string_resources.dart';

class UserSocialMediaWidget extends StatefulWidget {
  final UserDataModel user;

  const UserSocialMediaWidget({required this.user, Key? key}) : super(key: key);

  @override
  State<UserSocialMediaWidget> createState() => _UserSocialMediaWidgetState();
}

class _UserSocialMediaWidgetState extends State<UserSocialMediaWidget> {
  final List<Map<String, dynamic>> data = [];

  @override
  void initState() {
    super.initState();

    if (widget.user.socialProfileLinks!.facebook != null) {
      if (widget.user.socialProfileLinks!.facebook!.isNotEmpty) {
        data.add({
          'icon': FontAwesomeIcons.facebook,
          'title': 'Facebook',
          'link': widget.user.socialProfileLinks!.facebook,
          'color': const Color(0xFF546BBF),
        });
      }
    }
    if (widget.user.socialProfileLinks!.youtube != null) {
      if (widget.user.socialProfileLinks!.youtube!.isNotEmpty) {
        data.add({
          'icon': FontAwesomeIcons.youtube,
          'title': 'Youtube',
          'link': widget.user.socialProfileLinks!.youtube,
          'color': const Color(0xFFD54327),
        });
      }
    }
    if (widget.user.socialProfileLinks!.twitter != null) {
      if (widget.user.socialProfileLinks!.twitter!.isNotEmpty) {
        data.add({
          'icon': FontAwesomeIcons.twitter,
          'title': 'Twitter',
          'link': widget.user.socialProfileLinks!.twitter,
          'color': const Color(0xFF58C0F3),
        });
      }
    }
    if (widget.user.socialProfileLinks!.instagram != null) {
      if (widget.user.socialProfileLinks!.instagram!.isNotEmpty) {
        data.add({
          'icon': FontAwesomeIcons.instagram,
          'title': 'Instagram',
          'link': widget.user.socialProfileLinks!.instagram,
          'color': const Color(0xFFBF5EBD),
        });
      }
    }
    if (widget.user.socialProfileLinks!.linkedin != null) {
      if (widget.user.socialProfileLinks!.linkedin!.isNotEmpty) {
        data.add({
          'icon': FontAwesomeIcons.linkedin,
          'title': 'Linkedin',
          'link': widget.user.socialProfileLinks!.linkedin,
          'color': const Color(0xFF3279B4),
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return data.isEmpty
        ? const SizedBox.shrink()
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  StringResources.socialMedia,
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 21),
                ),
                const SizedBox(height: 10),
                GridView.builder(
                  itemCount: data.length,
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemBuilder: (ctx, index) => UserSocialMedialItemWidget(
                    data: data[index],
                  ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 3.2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                )
              ],
            ),
          );
  }
}
