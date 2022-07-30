import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navolaya_flutter/data/model/filter_data_request_model.dart';
import 'package:navolaya_flutter/presentation/basicWidget/custom_slider_widget.dart';
import 'package:navolaya_flutter/presentation/basicWidget/loading_widget.dart';
import 'package:navolaya_flutter/resources/color_constants.dart';

import '../../../../data/model/masters_model.dart';
import '../../../../domain/master_repository.dart';
import '../../../../injection_container.dart';
import '../../../../resources/image_resources.dart';
import '../../../../resources/string_resources.dart';
import '../../../basicWidget/custom_button.dart';
import '../../../basicWidget/drop_down_widget.dart';
import '../../../basicWidget/text_field_widget.dart';
import '../../../cubit/nearByUsersCubit/near_by_users_cubit.dart';
import '../../../cubit/popularUsersCubit/popular_users_cubit.dart';
import '../../../cubit/recentUsersCubit/recent_users_cubit.dart';
import '../../registration/widget/gender_radio_widget.dart';

class BottomSheetFilterWidget extends StatefulWidget {
  final Map<String, dynamic> filterData;

  const BottomSheetFilterWidget({required this.filterData, Key? key}) : super(key: key);

  @override
  State<BottomSheetFilterWidget> createState() => _BottomSheetFilterWidgetState();
}

class _BottomSheetFilterWidgetState extends State<BottomSheetFilterWidget> {
  final TextEditingController _searchNameController = TextEditingController();
  final TextEditingController _searchLocalityController = TextEditingController();

  late Schools _schoolValue;
  late StateCities _stateValue;

  String _fromYearsValue = '1970';
  String _toYearsValue = '';
  String _genderValue = 'Male';
  double _sliderValue = 50.0;

  late final List<StateCities> _stateList;
  late final List<Schools> _schoolList;

  final List<String> _formYearsList = [];
  final List<String> _toYearsList = [];

  late final Future<void> fetchFilterData;

  @override
  void initState() {
    super.initState();
    fetchFilterData = manageFilterData();
  }

  Future<void> manageFilterData() async {
    createYears();

    final masterRepository = sl<MasterRepository>();
    _schoolList = masterRepository.schoolsList;
    _stateList = masterRepository.stateCitiesList;

    if (widget.filterData['keyword'].toString().isNotEmpty) {
      _searchNameController.text = widget.filterData['keyword'].toString();
    }
    if (widget.filterData['distance_range'] != 0.0) {
      _sliderValue = widget.filterData['distance_range'];
    }
    if (widget.filterData['to_year'].toString().isNotEmpty) {
      _toYearsValue = widget.filterData['to_year'];
    }
    if (widget.filterData['from_year'].toString().isNotEmpty) {
      _fromYearsValue = widget.filterData['from_year'];
    }
    if (widget.filterData['gender'].toString().isNotEmpty) {
      _genderValue = widget.filterData['gender'];
    }
    if (widget.filterData['state'].toString().isNotEmpty) {
      _stateValue = _stateList.firstWhere((element) => element.name! == widget.filterData['state']);
    } else {
      _stateValue = _stateList.first;
    }
    if (widget.filterData['school'].toString().isNotEmpty) {
      _schoolValue =
          _schoolList.firstWhere((element) => element.id! == widget.filterData['school']);
    } else {
      _schoolValue = _schoolList.first;
    }
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
  Widget build(BuildContext childContext) {
    return FutureBuilder(
      future: fetchFilterData,
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingWidget();
        }
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
                    style:
                        TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(childContext).pop();
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
                  DropDownWidget<StateCities>(
                    list: _stateList,
                    value: _stateValue,
                    onValueSelect: (StateCities value) {
                      _stateValue = value;
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  DropDownWidget<Schools>(
                    list: _schoolList,
                    value: _schoolValue,
                    onValueSelect: (Schools value) {
                      _schoolValue = value;
                    },
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
                        onValueSelect: (String? value) {
                          _fromYearsValue = value!;
                        },
                      )),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: DropDownWidget<String>(
                        list: _toYearsList,
                        value: _toYearsValue,
                        onValueSelect: (String? value) {
                          _toYearsValue = value!;
                        },
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
                  CustomSliderWidget(
                    sliderValue: _sliderValue,
                    onValueChange: (double value) {
                      _sliderValue = value;
                    },
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Expanded(child: Builder(
                        builder: (BuildContext ctx) {
                          return ButtonWidget(
                            buttonText: StringResources.apply.toUpperCase(),
                            onPressButton: () {
                              Navigator.of(context).pop();
                              _applyFilter(ctx);
                            },
                          );
                        },
                      )),
                      Expanded(child: Builder(
                        builder: (BuildContext ctx) {
                          return ButtonWidget(
                            buttonText: StringResources.clearAll.toUpperCase(),
                            onPressButton: () {
                              Navigator.of(context).pop();
                              _clearFilter(ctx);
                            },
                            color: ColorConstants.red,
                          );
                        },
                      ))
                    ],
                  )
                ],
              ),
            )
          ],
        );
      },
    );
  }

  void _applyFilter(BuildContext parentContext) {
    final keyword = _searchNameController.text;
    final school = _schoolValue.id!.isEmpty ? '' : _schoolValue.id!;
    final filterData = FilterDataRequestModel(
        page: 1,
        keyword: keyword,
        toYear: _toYearsValue,
        fromYear: _fromYearsValue,
        gender: _genderValue,
        state: _stateValue.name!,
        distanceRange: _sliderValue,
        school: school);

    applyFilterOrClear(filterData, parentContext, true);
  }

  void _clearFilter(BuildContext parentContext) {
    final filterData = FilterDataRequestModel(page: 1);
    applyFilterOrClear(filterData, parentContext, false);
  }

  void applyFilterOrClear(
      FilterDataRequestModel filterData, BuildContext parentContext, bool applyFilter) async {
    if (!applyFilter) {
      await parentContext.read<RecentUsersCubit>().clearFilter();
    }
    if (!mounted) return;

    parentContext.read<RecentUsersCubit>().filterList(filterData: filterData);
    parentContext.read<NearByUsersCubit>().filterList(filterData: filterData);
    parentContext.read<PopularUsersCubit>().filterList(filterData: filterData);

    //await Future.delayed(const Duration(seconds: 2));

    /* if (!mounted) return;
    Navigator.pop(context);*/
    //Navigator.of(widget.bottomSheetBuildContext).pop;
  }

  @override
  void dispose() {
    _searchNameController.dispose();
    _searchLocalityController.dispose();
    super.dispose();
  }
}
