import 'package:flutter/material.dart';
class CustomDropDown extends StatelessWidget {
  final String value;
  final List<String> itemsList;
  final Color dropdownColor;
  final Function(dynamic value) onChanged;

  const CustomDropDown({
    required this.value,
    required this.itemsList,
    required this.dropdownColor,
    required this.onChanged,
    required Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(5),
      ),
      child: DropdownButtonHideUnderline(
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: DropdownButton(
            isExpanded: true,
            isDense: true,
            dropdownColor: dropdownColor,
            value: value,
            items: itemsList
                .map((String item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(item),
                    ))
                .toList(),
            onChanged: (value) => onChanged(value),
          ),
        ),
      ),
    );
  }
}