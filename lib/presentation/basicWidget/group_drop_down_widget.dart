import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:navolaya_flutter/data/model/masters_model.dart';

import '../../resources/color_constants.dart';

// ignore: must_be_immutable
class GroupDropDownWidget<T> extends StatefulWidget {
  T? value;
  final List<T> list;
  final bool isExpanded;
  final double margin;
  final double height;
  final double textSize;
  final Function? onValueSelect;

  GroupDropDownWidget({
    this.value,
    required this.list,
    this.isExpanded = true,
    this.margin = 0,
    this.height = 50,
    this.textSize = 14,
    this.onValueSelect,
    Key? key,
  }) : super(key: key);

  @override
  State<GroupDropDownWidget<T>> createState() => _GroupDropDownWidgetState<T>();
}

class _GroupDropDownWidgetState<T> extends State<GroupDropDownWidget<T>> {
  final double _itemHeight = 50;

  @override
  Widget build(BuildContext context) {
    return Container(
      /*height: widget.height,*/
      margin: EdgeInsets.all(widget.margin),
      decoration: BoxDecoration(
        border: Border.all(color: ColorConstants.inputBorderColor, width: 1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: DropdownButton<T>(
        value: widget.value,
        underline: const SizedBox.shrink(),
        isDense: false,
        itemHeight: _itemHeight,
        items: widget.list.map((value) {
          return setDropDownMenuItems(value);
        }).toList(),
        isExpanded: widget.isExpanded,
        icon: const Padding(
            padding: EdgeInsets.only(left: 5, right: 10),
            child: Icon(FontAwesomeIcons.chevronDown, size: 10)),
        style: TextStyle(
          fontSize: widget.textSize,
          color: ColorConstants.textColor3,
          fontFamily: 'Montserrat',
        ),
        onChanged: (newValue) => updateValue(newValue as T),
      ),
    );
  }

  void updateValue(T newValue) {
    widget.value = newValue;
    if (widget.onValueSelect != null) {
      widget.onValueSelect!(newValue);
    }
    setState(() {});
  }

  DropdownMenuItem<T> setDropDownMenuItems(T value) {
    late final String title;
    bool isWidgetEnabled = true;
    if (value is Qualifications) {
      isWidgetEnabled = !value.isSeparator!;
      title = value.title!;
    } else if (value is Occupations) {
      isWidgetEnabled = !value.isSeparator!;
      title = value.title!;
    }
    final Widget widget = getTextWidget(isWidgetEnabled, title);
    return DropdownMenuItem<T>(
      value: value,
      enabled: isWidgetEnabled,
      child: widget,
    );
  }

  Widget getTextWidget(bool isWidgetEnabled, String title) {
    late final Widget widget;
    if (isWidgetEnabled) {
      widget = Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              title,
              style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
            ),
          ));
    } else {
      widget = Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          color: Colors.grey.withOpacity(0.2),
          child: Text(
            title,
            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ));
    }
    return widget;
  }
}
