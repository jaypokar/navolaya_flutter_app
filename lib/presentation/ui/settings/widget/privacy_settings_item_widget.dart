import 'package:flutter/material.dart';

import '../../../../core/color_constants.dart';
import '../../../../resources/string_resources.dart';
import '../../../basicWidget/drop_down_widget.dart';

class PrivacySettingsItemWidget extends StatefulWidget {
  final String title;

  const PrivacySettingsItemWidget({required this.title, Key? key}) : super(key: key);

  @override
  State<PrivacySettingsItemWidget> createState() => _PrivacySettingsItemWidgetState();
}

class _PrivacySettingsItemWidgetState extends State<PrivacySettingsItemWidget> {
  List<String> privacySettingsOptionsList = List.generate(3, (i) {
    if (i == 0) {
      return StringResources.all;
    } else if (i == 1) {
      return StringResources.myConnections;
    } else {
      return StringResources.none;
    }
  });
  final String _value = 'All';

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Text(
          widget.title,
          style: const TextStyle(
            color: ColorConstants.textColor3,
            fontSize: 12,
          ),
        )),
        DropDownWidget<String>(
          list: privacySettingsOptionsList,
          value: _value,
          isExpanded: false,
          paddingLeft: 10,
          paddingRight: 6,
          paddingBottom: 2,
          paddingTop: 2,
          margin: 5,
          height: 30,
          textSize: 12,
          showDropDown: true,
        ),
      ],
    );
  }
}
