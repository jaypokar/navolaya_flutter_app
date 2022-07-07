import 'package:flutter/material.dart';
import 'package:navolaya_flutter/presentation/basicWidget/drop_down_widget.dart';
import 'package:navolaya_flutter/presentation/basicWidget/text_field_widget.dart';
import 'package:navolaya_flutter/presentation/ui/registration/widget/gender_radio_widget.dart';

import '../../../../resources/string_resources.dart';
import '../../../basicWidget/custom_button.dart';

class BasicInfoWidget extends StatefulWidget {
  final PageController pageController;

  const BasicInfoWidget({required this.pageController, Key? key}) : super(key: key);

  @override
  State<BasicInfoWidget> createState() => _BasicInfoWidgetState();
}

class _BasicInfoWidgetState extends State<BasicInfoWidget> {
  final String _schoolValue = 'Select School';
  final String _relationWithJNVValue = 'Relation with JNV';
  final String _fromYearsValue = '1970';
  String _toYearsValue = '';
  final String _qualificationValue = 'Qualification';
  final String _occupationAreaValue = 'Occupation Area';
  final String _occupationValue = 'Occupation';
  final String _genderValue = 'Male';

  final List<String> _schoolList = ['Select School', 'Navolaya'];
  final List<String> _relationWithJNVList = ['Relation with JNV', 'Student'];
  final List<String> _formYearsList = [];
  final List<String> _toYearsList = [];
  final List<String> _qualificationList = ['Qualification', 'Engineer'];
  final List<String> _occupationAreaList = ['Occupation Area', 'Private Company'];
  final List<String> _occupationList = ['Occupation', 'Banking Professional'];

  final TextEditingController _nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    createYears();
  }

  void createYears() {
    int toYears = (DateTime.now().year + 7) - 1970;
    _toYearsValue = '${DateTime.now().year}';
    for (int i = 0; i < toYears; i++) {
      if (!_formYearsList.contains('${DateTime.now().year}')) {
        _formYearsList.add('${1970 + i}');
      }
      _toYearsList.add('${1970 + i}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFieldWidget(
              controller: _nameController,
              hint: StringResources.enterNameHint,
              textInputType: TextInputType.name,
            ),
            const SizedBox(
              height: 15,
            ),
            DropDownWidget<String>(
              list: _schoolList,
              value: _schoolValue,
            ),
            const SizedBox(
              height: 15,
            ),
            DropDownWidget<String>(
              list: _relationWithJNVList,
              value: _relationWithJNVValue,
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                    child: DropDownWidget<String>(
                  list: _formYearsList,
                  value: _fromYearsValue,
                )),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: DropDownWidget<String>(
                  list: _toYearsList,
                  value: _toYearsValue,
                )),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            DropDownWidget<String>(
              list: _qualificationList,
              value: _qualificationValue,
            ),
            const SizedBox(
              height: 15,
            ),
            DropDownWidget<String>(
              list: _occupationAreaList,
              value: _occupationAreaValue,
            ),
            const SizedBox(
              height: 15,
            ),
            DropDownWidget<String>(
              list: _occupationList,
              value: _occupationValue,
            ),
            const SizedBox(
              height: 15,
            ),
            GenderRadioWidget(
              gender: _genderValue,
            ),
            const SizedBox(
              height: 10,
            ),
            ButtonWidget(
                buttonText: StringResources.next.toUpperCase(),
                padding: 0,
                onPressButton: () {
                  widget.pageController.jumpToPage(1);
                }),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
}
