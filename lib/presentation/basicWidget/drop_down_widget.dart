import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:navolaya_flutter/data/model/masters_model.dart';

import '../../resources/color_constants.dart';

// ignore: must_be_immutable
class DropDownWidget<T> extends StatefulWidget {
  final T? value;
  final List<T> list;
  final bool isExpanded;
  final double paddingLeft;
  final double paddingRight;
  final double paddingTop;
  final double paddingBottom;
  final double margin;
  final double height;
  final double textSize;
  final bool showDropDown;
  final Function? onValueSelect;
  final bool isDropDownEnabled;

  const DropDownWidget({
    required this.value,
    required this.list,
    this.isExpanded = true,
    this.paddingLeft = 10,
    this.paddingRight = 10,
    this.paddingTop = 10,
    this.paddingBottom = 10,
    this.margin = 0,
    this.height = 50,
    this.textSize = 14,
    this.showDropDown = true,
    this.isDropDownEnabled = true,
    this.onValueSelect,
    Key? key,
  }) : super(key: key);

  @override
  State<DropDownWidget<T>> createState() => _DropDownWidgetState<T>();
}

class _DropDownWidgetState<T> extends State<DropDownWidget<T>> {
  T? _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      padding: EdgeInsets.only(
        left: widget.paddingLeft,
        top: widget.paddingTop,
        right: widget.paddingRight,
        bottom: widget.paddingBottom,
      ),
      margin: EdgeInsets.all(widget.margin),
      decoration: BoxDecoration(
        border: Border.all(
          color: widget.isDropDownEnabled
              ? ColorConstants.inputBorderColor
              : ColorConstants.disabledColor,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(
          5,
        ),
      ),
      child: IgnorePointer(
        ignoring: !widget.isDropDownEnabled,
        child: DropdownButton<T>(
          value: _selectedValue,
          underline: const SizedBox.shrink(),
          isDense: true,
          items: widget.list.map((value) {
            return DropdownMenuItem<T>(
              value: value,
              child: setText(value),
            );
          }).toList(),
          isExpanded: widget.isExpanded,
          icon: widget.showDropDown
              ? const Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Icon(
                    FontAwesomeIcons.chevronDown,
                    size: 10,
                  ))
              : const SizedBox.shrink(),
          style: TextStyle(
              fontSize: widget.textSize,
              color: widget.isDropDownEnabled ? Colors.black : ColorConstants.disabledColor),
          onChanged: (newValue) {
            _selectedValue = newValue;
            if (widget.onValueSelect != null) {
              widget.onValueSelect!(newValue);
            }
            setState(() {});
          },
        ),
      ),
    );
  }

  Widget setText(T value) {
    late final String title;
    if (value is String) {
      title = value;
    } else if (value is JnvRelations) {
      title = value.title!;
    } else if (value is JnvHouses) {
      title = value.title!;
    } else if (value is OccupationAreas) {
      title = value.title!;
    } else if (value is Schools) {
      title = value.city!;
    } else if (value is StateCities) {
      title = value.name!;
    }

    return Text(title,
        style: TextStyle(
            color: widget.isDropDownEnabled ? Colors.black : ColorConstants.disabledColor));
  }
}
