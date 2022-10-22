import 'package:flutter/material.dart';
import 'package:navolaya_flutter/core/logger.dart';
import 'package:url_launcher/url_launcher_string.dart';

class UserSocialMedialItemWidget extends StatelessWidget {
  final Map<String, dynamic> data;

  const UserSocialMedialItemWidget({required this.data, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: Icon(
        data['icon'] as IconData,
        color: Colors.white,
        size: 17,
      ),
      onPressed: () {
        logger.i('the social media url is : ${data['link'].toString()}');
        launchUrlString(data['link'].toString());
      },
      label: Text(
        data['title'],
        style: const TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
      ),
      style: ElevatedButton.styleFrom(
        primary: data['color'],
        padding: const EdgeInsets.all(0),
      ),
    );
  }
}
