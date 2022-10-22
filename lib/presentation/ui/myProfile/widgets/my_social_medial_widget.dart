import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../data/model/login_and_basic_info_model.dart';
import '../../../../resources/string_resources.dart';
import '../../user/widget/user_social_media_item_widget.dart';

class MySocialMediaWidget extends StatefulWidget {
  final SocialProfileLinks? socialProfileLinks;

  const MySocialMediaWidget({required this.socialProfileLinks, Key? key}) : super(key: key);

  @override
  State<MySocialMediaWidget> createState() => _MySocialMediaWidgetState();
}

class _MySocialMediaWidgetState extends State<MySocialMediaWidget> {
  final List<Map<String, dynamic>> data = [];

  @override
  void initState() {
    super.initState();

    if (widget.socialProfileLinks!.facebook != null) {
      if (widget.socialProfileLinks!.facebook!.isNotEmpty) {
        data.add({
          'icon': FontAwesomeIcons.facebook,
          'title': 'Facebook',
          'link': widget.socialProfileLinks!.facebook,
          'color': const Color(0xFF546BBF),
        });
      }
    }
    if (widget.socialProfileLinks!.youtube != null) {
      if (widget.socialProfileLinks!.youtube!.isNotEmpty) {
        data.add({
          'icon': FontAwesomeIcons.youtube,
          'title': 'Youtube',
          'link': widget.socialProfileLinks!.youtube,
          'color': const Color(0xFFD54327),
        });
      }
    }
    if (widget.socialProfileLinks!.twitter != null) {
      if (widget.socialProfileLinks!.twitter!.isNotEmpty) {
        data.add({
          'icon': FontAwesomeIcons.twitter,
          'title': 'Twitter',
          'link': widget.socialProfileLinks!.twitter,
          'color': const Color(0xFF58C0F3),
        });
      }
    }
    if (widget.socialProfileLinks!.instagram != null) {
      if (widget.socialProfileLinks!.instagram!.isNotEmpty) {
        data.add({
          'icon': FontAwesomeIcons.instagram,
          'title': 'Instagram',
          'link': widget.socialProfileLinks!.instagram,
          'color': const Color(0xFFBF5EBD),
        });
      }
    }
    if (widget.socialProfileLinks!.linkedin != null) {
      if (widget.socialProfileLinks!.linkedin!.isNotEmpty) {
        data.add({
          'icon': FontAwesomeIcons.linkedin,
          'title': 'Linkedin',
          'link': widget.socialProfileLinks!.linkedin,
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
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
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
                    childAspectRatio: 4.0,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                )
              ],
            ),
          );
  }
}
