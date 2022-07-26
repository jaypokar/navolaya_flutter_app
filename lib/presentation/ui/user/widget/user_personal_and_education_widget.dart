import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:navolaya_flutter/data/model/users_model.dart';
import 'package:navolaya_flutter/presentation/ui/user/widget/user_connect_message_and_option_widget.dart';
import 'package:navolaya_flutter/presentation/ui/user/widget/user_qualification_item_widget.dart';
import 'package:navolaya_flutter/util/common_functions.dart';

import '../../../../injection_container.dart';

class UserPersonalAndEducationWidget extends StatelessWidget {
  final UserDataModel user;

  const UserPersonalAndEducationWidget({required this.user, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 5),
          Text(
            user.fullName!,
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 20,
            child: ListView.builder(
              itemBuilder: (context, i) {
                late final IconData iconData;
                late final String title;
                if (i == 0) {
                  iconData = FontAwesomeIcons.bookBookmark;
                  title = '${user.school!.city!} ${user.school!.state!}';
                } else if (i == 1) {
                  title = user.relationWithJnv ?? '-';
                  iconData = FontAwesomeIcons.link;
                } else {
                  title = '${user.fromYear!} - ${user.toYear!}';
                  iconData = FontAwesomeIcons.calendar;
                }
                return UserQualificationItemWidget(title: title, iconData: iconData);
              },
              itemCount: 3,
              physics: const ClampingScrollPhysics(),
              scrollDirection: Axis.horizontal,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 20,
            child: ListView.builder(
              itemBuilder: (context, i) {
                late final IconData iconData;
                late final String title;
                if (i == 0) {
                  iconData = FontAwesomeIcons.shirt;
                  title = user.house ?? '-';
                } else if (i == 1) {
                  iconData = FontAwesomeIcons.school;
                  title = user.qualification!.title ?? '-';
                } else {
                  iconData = FontAwesomeIcons.computer;
                  title = user.occupation!.title ?? '-';
                }
                return UserQualificationItemWidget(title: title, iconData: iconData);
              },
              itemCount: 3,
              physics: const ClampingScrollPhysics(),
              scrollDirection: Axis.horizontal,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 20,
            child: ListView.builder(
              itemBuilder: (context, i) {
                late final IconData iconData;
                String title = '';
                if (i == 0) {
                  iconData = FontAwesomeIcons.cakeCandles;
                  if (user.displaySettings != null) {
                    if (user.displaySettings!.birthDayMonth == 'all' ||
                        (user.isConnected! &&
                            user.displaySettings!.birthDayMonth == 'my_connections')) {
                      title = sl<CommonFunctions>()
                          .getBirthMonth(user.birthDate ?? DateTime.now().toIso8601String());
                    }
                    if (user.displaySettings!.birthYear == 'all' ||
                        (user.isConnected! &&
                            user.displaySettings!.birthYear == 'my_connections')) {
                      if (title.isEmpty) {
                        title = sl<CommonFunctions>()
                            .getBirthYear(user.birthDate ?? DateTime.now().toIso8601String());
                      } else {
                        title =
                            '$title,${sl<CommonFunctions>().getBirthYear(user.birthDate ?? DateTime.now().toIso8601String())}';
                      }
                    }
                  }
                } else if (i == 1) {
                  iconData = FontAwesomeIcons.user;
                  title = user.gender ?? '-';
                } else {
                  iconData = FontAwesomeIcons.phone;
                  if (user.displaySettings != null) {
                    if (user.displaySettings!.phone == 'all' ||
                        (user.isConnected! && user.displaySettings!.phone == 'my_connections')) {
                      title = '${user.countryCode}-${user.phone}';
                    }
                  }
                }
                return title.isEmpty
                    ? const SizedBox.shrink()
                    : UserQualificationItemWidget(title: title, iconData: iconData);
              },
              itemCount: 3,
              physics: const ClampingScrollPhysics(),
              scrollDirection: Axis.horizontal,
            ),
          ),
          const SizedBox(height: 10),
          UserConnectMessageAndOptionWidget(user: user),
        ],
      ),
    );
  }
}
