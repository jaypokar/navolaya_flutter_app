import 'package:flutter/material.dart';
import 'package:navolaya_flutter/core/color_constants.dart';
import 'package:navolaya_flutter/presentation/basicWidget/custom_slider_widget.dart';

import '../../../../resources/image_resources.dart';
import '../../../../resources/string_resources.dart';
import '../../../basicWidget/custom_button.dart';
import '../../../basicWidget/drop_down_widget.dart';
import '../../../basicWidget/text_field_widget.dart';
import '../../registration/widget/gender_radio_widget.dart';

class BottomSheetFilterWidget extends StatefulWidget {
  const BottomSheetFilterWidget({Key? key}) : super(key: key);

  @override
  State<BottomSheetFilterWidget> createState() => _BottomSheetFilterWidgetState();
}

class _BottomSheetFilterWidgetState extends State<BottomSheetFilterWidget> {
  final TextEditingController _searchNameController = TextEditingController();
  final TextEditingController _searchLocalityController = TextEditingController();

  final String _stateValue = 'Select State';
  final String _schoolValue = 'Select School';
  final String _fromYearsValue = '1970';
  String _toYearsValue = '';
  final String _genderValue = 'Male';
  final double _sliderValue = 50.0;

  final List<String> _stateList = ['Select State', 'Gujarat'];
  final List<String> _schoolList = ['Select School', 'Navolaya'];
  final List<String> _formYearsList = [];
  final List<String> _toYearsList = [];

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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                StringResources.filters,
                style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
              ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Image.asset(
                  ImageResources.closeIcon,
                  height: 16,
                ),
              )
            ],
          ),
        ),
        const Divider(
          height: 1,
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFieldWidget(
                controller: _searchNameController,
                hint: StringResources.searchByName,
                textInputType: TextInputType.name,
              ),
              const SizedBox(
                height: 15,
              ),
              DropDownWidget<String>(
                list: _stateList,
                value: _stateValue,
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
              GenderRadioWidget(
                gender: _genderValue,
              ),
              const SizedBox(
                height: 5,
              ),
              CustomSliderWidget(sliderValue: _sliderValue),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Expanded(
                      child: ButtonWidget(
                    buttonText: StringResources.apply.toUpperCase(),
                    onPressButton: () {
                      Navigator.of(context).pop();
                    },
                  )),
                  Expanded(
                      child: ButtonWidget(
                    buttonText: StringResources.clearAll.toUpperCase(),
                    onPressButton: () {
                      Navigator.of(context).pop();
                    },
                    color: ColorConstants.red,
                  ))
                ],
              )
            ],
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    _searchNameController.dispose();
    _searchLocalityController.dispose();
    super.dispose();
  }
}
