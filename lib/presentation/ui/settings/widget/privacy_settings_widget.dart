import 'package:flutter/material.dart';

import '../../../../resources/string_resources.dart';
import 'privacy_settings_item_widget.dart';

class PrivacySettingsWidget extends StatefulWidget {
  const PrivacySettingsWidget({Key? key}) : super(key: key);

  @override
  State<PrivacySettingsWidget> createState() => _PrivacySettingsWidgetState();
}

class _PrivacySettingsWidgetState extends State<PrivacySettingsWidget> {
  List<String> privacySettingsList = List.generate(7, (i) {
    if (i == 0) {
      return StringResources.phoneNumber;
    } else if (i == 1) {
      return StringResources.emailAddress;
    } else if (i == 2) {
      return StringResources.profileImage;
    } else if (i == 3) {
      return StringResources.birthDayAndMonth;
    } else if (i == 4) {
      return StringResources.birthYear;
    } else if (i == 5) {
      return StringResources.socialProfiles;
    } else {
      return StringResources.findMeNearBy;
    }
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const ClampingScrollPhysics(),
      itemBuilder: (_, i) {
        return PrivacySettingsItemWidget(title: privacySettingsList[i]);
      },
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: privacySettingsList.length,
    );
  }
}
