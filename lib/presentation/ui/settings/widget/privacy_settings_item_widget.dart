import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../resources/color_constants.dart';
import '../../../../resources/string_resources.dart';
import '../../../basicWidget/drop_down_widget.dart';
import '../../../bloc/profileBloc/profile_bloc.dart';

class PrivacySettingsItemWidget extends StatefulWidget {
  final String title;
  final String value;

  const PrivacySettingsItemWidget({required this.title, required this.value, Key? key})
      : super(key: key);

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

  @override
  void initState() {
    super.initState();
    context.read<ProfileBloc>().updatePrivacySettingsMap(widget.title, widget.value);
  }

  //String _value = StringResources.all;

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
          value: widget.value,
          isExpanded: false,
          paddingLeft: 10,
          paddingRight: 6,
          paddingBottom: 2,
          paddingTop: 2,
          margin: 5,
          height: 25,
          textSize: 12,
          showDropDown: true,
          onValueSelect: (String value) {
            /*widget.value = value;*/
            context.read<ProfileBloc>().updatePrivacySettingsMap(widget.title, value);
          },
        ),
      ],
    );
  }
}
