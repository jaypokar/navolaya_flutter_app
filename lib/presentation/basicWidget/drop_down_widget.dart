import 'package:flutter/material.dart';

import '../../core/color_constants.dart';

// ignore: must_be_immutable
class DropDownWidget<T> extends StatefulWidget {
  T? value;
  final List<T> list;

  DropDownWidget({this.value, required this.list, Key? key}) : super(key: key);

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
      height: 50,
      padding: const EdgeInsets.all(10),
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
        items: widget.list.map((value) {
          return DropdownMenuItem<T>(value: value, child: setText(value));
        }).toList(),
        isExpanded: true,
        style: const TextStyle(
            fontSize: 14, color: ColorConstants.textColor3, fontFamily: 'Montserrat'),
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
