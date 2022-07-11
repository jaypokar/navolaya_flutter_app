import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../core/color_constants.dart';

// ignore: must_be_immutable
class DropDownWidget<T> extends StatefulWidget {
  T? value;
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

  DropDownWidget({
    this.value,
    required this.list,
    this.isExpanded = true,
    this.paddingLeft = 10,
    this.paddingRight = 10,
    this.paddingTop = 10,
    this.paddingBottom = 10,
    this.margin = 0,
    this.height = 50,
    this.textSize = 14,
    this.showDropDown = false,
    Key? key,
  }) : super(key: key);

  @override
  State<DropDownWidget<T>> createState() => _DropDownWidgetState<T>();
}

class _DropDownWidgetState<T> extends State<DropDownWidget<T>> {
/*  late T value;

  @override
  void initState() {
    super.initState();
    value = widget.value as T;
  }*/

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
          color: ColorConstants.inputBorderColor,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(
          5,
        ),
      ),
      child: DropdownButton<T>(
        value: widget.value,
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
                padding: EdgeInsets.only(left: 5),
                child: Icon(
                  FontAwesomeIcons.chevronDown,
                  size: 10,
                ))
            : const SizedBox.shrink(),
        style: TextStyle(
          fontSize: widget.textSize,
          color: ColorConstants.textColor3,
          fontFamily: 'Montserrat',
        ),
        onChanged: (newValue) {
          setState(() {
            widget.value = newValue;
          });
        },
      ),
    );
  }

  Widget setText(T value) {
    if (value is String) {
      return Text(value);
    }
    return const Text('');
  }
}
