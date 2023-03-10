// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:navolaya_flutter/core/logger.dart';
import 'package:navolaya_flutter/util/common_functions.dart';

import '../../injection_container.dart';
import '../../resources/image_resources.dart';
import '../../resources/string_resources.dart';
import 'text_field_widget.dart';

class DateInputWidget extends StatefulWidget {
  final Function onDateSelected;
  String? initialDate;

  DateInputWidget({required this.onDateSelected, this.initialDate, Key? key}) : super(key: key);

  @override
  State<DateInputWidget> createState() => _DateInputWidgetState();
}

class _DateInputWidgetState extends State<DateInputWidget> {
  DateTime? selectedDate;
  final TextEditingController _birthdateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    logger.i('date selected is ${widget.initialDate}');
    if (widget.initialDate != null) {
      if (widget.initialDate!.isNotEmpty) {
        _birthdateController.text = widget.initialDate!;
        if (_birthdateController.text.contains('-')) {
          _birthdateController.text =
              sl<CommonFunctions>().convertDateToDayMonthYear(_birthdateController.text);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        selectDate();
      },
      child: IgnorePointer(
        ignoring: true,
        ignoringSemantics: true,
        child: TextFieldWidget(
          controller: _birthdateController,
          hint: StringResources.birthDateOptional,
          isEnabled: true,
          suffixIcon: Padding(
            padding: const EdgeInsets.all(15),
            child: Image.asset(
              ImageResources.calenderIcon,
              height: 5,
            ),
          ),
        ),
      ),
    );
  }

  void selectDate() async {
    await showDatePicker(
      context: context,
      initialDatePickerMode: DatePickerMode.day,
      initialDate: selectedDate == null ? getAge18Date() : selectedDate!,
      lastDate: DateTime.now(),
      firstDate: DateTime(1970),
    ).then((newDate) {
      if (newDate != null) {
        selectedDate = newDate;
        String formattedDate = DateFormat('yyyy-MM-dd').format(newDate);
        String displayDate = DateFormat('dd/MM/yyyy').format(newDate);
        _birthdateController.text = displayDate;
        widget.onDateSelected(formattedDate);
      }
    });
  }

  DateTime getAge18Date() {
    String datePattern = "dd-MM-yyyy";

    // Current time - at this moment
    DateTime today = DateTime.now();

    String formattedDate = DateFormat('dd-MM-yyyy').format(today);
    // Parsed date to check
    DateTime birthDate = DateFormat(datePattern).parse(formattedDate);

    // Date to check but moved 18 years ahead

    DateTime adultDate = DateTime(
      birthDate.year - 18,
      birthDate.month,
      birthDate.day,
    );

    return adultDate;
  }

  @override
  void dispose() {
    _birthdateController.dispose();
    super.dispose();
  }
}
