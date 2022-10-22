import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:navolaya_flutter/core/logger.dart';
import 'package:navolaya_flutter/data/model/filter_data_request_model.dart';
import 'package:navolaya_flutter/presentation/basicWidget/bottom_sheet_search_widget.dart';
import 'package:navolaya_flutter/presentation/basicWidget/custom_slider_widget.dart';
import 'package:navolaya_flutter/presentation/basicWidget/loading_widget.dart';
import 'package:navolaya_flutter/presentation/ui/dashBoard/widget/search_locality_widget.dart';
import 'package:navolaya_flutter/resources/color_constants.dart';
import 'package:navolaya_flutter/resources/value_key_resources.dart';

import '../../../../data/model/masters_model.dart';
import '../../../../domain/master_repository.dart';
import '../../../../injection_container.dart';
import '../../../../resources/image_resources.dart';
import '../../../../resources/string_resources.dart';
import '../../../basicWidget/custom_button.dart';
import '../../../basicWidget/drop_down_widget.dart';
import '../../../basicWidget/text_field_widget.dart';
import '../../../cubit/nearByUsersCubit/near_by_users_cubit.dart';
import '../../registration/widget/gender_radio_widget.dart';

class BottomSheetFilterWidget extends StatefulWidget {
  const BottomSheetFilterWidget({Key? key}) : super(key: key);

  @override
  State<BottomSheetFilterWidget> createState() => _BottomSheetFilterWidgetState();
}

class _BottomSheetFilterWidgetState extends State<BottomSheetFilterWidget> {
  final TextEditingController _searchNameController = TextEditingController();
  final TextEditingController _searchLocalityController = TextEditingController();

  Schools? _schoolValue;
  Qualifications? _qualificationValue;
  Occupations? _occupationsValue;

  String _fromYearsValue = StringResources.batchFrom;
  String _toYearsValue = StringResources.batchTo;
  String _genderValue = '';
  String _searchedByLocality = '';
  double _sliderValue = 50.0;
  double latitude = 0.0;
  double longitude = 0.0;
  bool _isSearchByLocalitySearched = false;

  late final List<Schools> _schoolList;
  late final List<Qualifications> _qualificationList;
  late final List<Occupations> _occupationList;

  final List<String> _fromYearsList = [];
  final List<String> _toYearsList = [];

  late final Future<void> fetchFilterData;

  late final ValueNotifier<Schools?> _schoolSelectNotifier;
  late final ValueNotifier<Qualifications?> _qualificationSelectNotifier;
  late final ValueNotifier<Occupations?> _occupationSelectNotifier;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    fetchFilterData = manageFilterData();
  }

  Future<void> manageFilterData() async {
    createYears();

    final masterRepository = sl<MasterRepository>();
    _schoolList = masterRepository.schoolsList;
    _qualificationList = masterRepository.qualificationsList;
    _occupationList = masterRepository.occupationsList;

    final filterData = context.read<NearByUsersCubit>().fetchCachedFilterData();

    if (filterData['keyword'].toString().isNotEmpty) {
      _searchNameController.text = filterData['keyword'].toString();
    }
    if (filterData['distance_range'] != 0.0) {
      _sliderValue = filterData['distance_range'];
    }
    if (filterData['to_year'].toString().isNotEmpty) {
      _toYearsValue = filterData['to_year'];
    }
    if (filterData['from_year'].toString().isNotEmpty) {
      _fromYearsValue = filterData['from_year'];
    }
    if (filterData['gender'].toString().isNotEmpty) {
      _genderValue = filterData['gender'];
    }
    logger.i('genderValue : $_genderValue');

    if (filterData['school'].toString().isNotEmpty) {
      _schoolValue = _schoolList.firstWhere((element) => element.id! == filterData['school']);
    }

    _schoolSelectNotifier = ValueNotifier(_schoolValue);

    if (filterData['qualification'].toString().isNotEmpty) {
      _qualificationValue =
          _qualificationList.firstWhere((element) => element.id! == filterData['qualification']);
    }

    _qualificationSelectNotifier = ValueNotifier(_qualificationValue);

    if (filterData['occupation'].toString().isNotEmpty) {
      _occupationsValue =
          _occupationList.firstWhere((element) => element.id! == filterData['occupation']);
    }

    _occupationSelectNotifier = ValueNotifier(_occupationsValue);
    logger.i('the search by locality :${filterData['searchByLocality']}');
    _searchedByLocality = filterData['searchByLocality'].toString();
    _searchLocalityController.text = _searchedByLocality;
  }

  void createYears() {
    int toYears = (DateTime.now().year + 8) - 1970;
    _fromYearsList.add(StringResources.batchFrom);
    _toYearsList.add(StringResources.batchTo);
    for (int i = 0; i < toYears; i++) {
      if (!_fromYearsList.contains('${DateTime.now().year}')) {
        _fromYearsList.add('${1970 + i}');
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

        return SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Image.asset(
                          ImageResources.closeIcon,
                          height: 16,
                        ),
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
                    InkWell(
                      onTap: () => showSearchBottomSheet<Schools>(
                        _schoolList,
                        _schoolValue,
                        StringResources.searchSchool,
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          border: Border.all(color: ColorConstants.inputBorderColor, width: 1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(children: [
                          Expanded(
                            child: ValueListenableBuilder<Schools?>(
                              valueListenable: _schoolSelectNotifier,
                              builder: (_, value, __) {
                                return Text(_schoolValue == null
                                    ? 'Search By School'
                                    : 'JNV ${_schoolValue!.city!}, ${_schoolValue!.district!}');
                              },
                            ),
                          ),
                          const Icon(
                            FontAwesomeIcons.chevronDown,
                            size: 10,
                            color: ColorConstants.textColor2,
                          )
                        ]),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: () => showSearchBottomSheet<Qualifications>(
                        _qualificationList,
                        _qualificationValue,
                        StringResources.searchQualification,
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          border: Border.all(color: ColorConstants.inputBorderColor, width: 1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(children: [
                          Expanded(
                            child: ValueListenableBuilder<Qualifications?>(
                              valueListenable: _qualificationSelectNotifier,
                              builder: (_, value, __) {
                                return Text(_qualificationValue == null
                                    ? 'Search By Qualification'
                                    : '${_qualificationValue!.title} (${_qualificationValue!.shortName!})');
                              },
                            ),
                          ),
                          const Icon(
                            FontAwesomeIcons.chevronDown,
                            size: 10,
                            color: ColorConstants.textColor2,
                          )
                        ]),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    InkWell(
                      onTap: () => showSearchBottomSheet<Occupations>(
                        _occupationList,
                        _occupationsValue,
                        StringResources.searchOccupation,
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          border: Border.all(color: ColorConstants.inputBorderColor, width: 1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(children: [
                          Expanded(
                            child: ValueListenableBuilder<Occupations?>(
                              valueListenable: _occupationSelectNotifier,
                              builder: (_, value, __) {
                                return Text(_occupationsValue == null
                                    ? 'Search By Occupation'
                                    : _occupationsValue!.title!);
                              },
                            ),
                          ),
                          const Icon(
                            FontAwesomeIcons.chevronDown,
                            size: 10,
                            color: ColorConstants.textColor2,
                          )
                        ]),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: DropDownWidget<String>(
                          list: _fromYearsList,
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
                      onValueSelect: (String value) {
                        _genderValue = value;
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    InkWell(
                        onTap: () {
                          showSearchByLocalityBottomSheet();
                        },
                        child: TextField(
                          controller: _searchLocalityController,
                          keyboardType: TextInputType.streetAddress,
                          enabled: false,
                          style: const TextStyle(fontSize: 14, color: Colors.black),
                          textAlign: TextAlign.start,
                          decoration: setInputDecoration(),
                        )),
                    /* SearchLocalityWidget(
                        searchedValue: _searchedByLocality,
                        onValueSelect: (AutocompletePrediction value) {
                          logger.i(value.description!);
                          _searchedByLocality = value.description!;
                          _isSearchByLocalitySearched = true;
                          context.read<NearByUsersCubit>().updateUserNearByLatLng(value.placeId!);
                        }),*/
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
              ),
            ],
          ),
        );
      },
    );
  }

  InputDecoration setInputDecoration() {
    return InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(width: 1),
        ),
        labelText: StringResources.searchByLocalityAddress,
        counterText: "",
        labelStyle: const TextStyle(color: ColorConstants.textColor3),
        isDense: true,
        alignLabelWithHint: true,
        hintStyle: const TextStyle(
          fontSize: 14,
          color: ColorConstants.inputBorderColor,
        ),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorConstants.inputBorderColor,
          ),
        ),
        disabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: ColorConstants.inputBorderColor,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10));
  }

  void showSearchBottomSheet<T>(List<T> list, T? selectedValue, String hint) {
    showModalBottomSheet(
        constraints: BoxConstraints.loose(
            Size(MediaQuery.of(context).size.width, (MediaQuery.of(context).size.height) - 60)),
        // <= this is set to 3/4 of screen size.
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
        ),
        context: context,
        builder: (_) => BottomSheetSearchWidget<T>(
              selectedValue: selectedValue,
              data: list,
              hint: hint,
              onValueSelect: (value) {
                if (value is Qualifications) {
                  _qualificationValue = value;
                  _qualificationSelectNotifier.value = value;
                } else if (value is Occupations) {
                  _occupationsValue = value;
                  _occupationSelectNotifier.value = value;
                } else if (value is Schools) {
                  _schoolValue = value;
                  _schoolSelectNotifier.value = value;
                }
                Navigator.of(context).pop();
              },
            ));
  }

  void showSearchByLocalityBottomSheet() {
    final blocNearByUserCubit = context.read<NearByUsersCubit>();
    showModalBottomSheet(
        constraints: BoxConstraints.loose(
            Size(MediaQuery.of(context).size.width, (MediaQuery.of(context).size.height) - 60)),
        // <= this is set to 3/4 of screen size.
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
        ),
        context: context,
        builder: (_) => BlocProvider.value(
              value: blocNearByUserCubit,
              child: SizedBox(
                height: (MediaQuery.of(context).size.height) - 100,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SearchLocalityWidget(
                        searchedValue: _searchedByLocality,
                        onValueSelect: (AutocompletePrediction value) {
                          logger.i(value.description!);
                          _searchedByLocality = value.description!;
                          _isSearchByLocalitySearched = true;
                          _searchLocalityController.text = _searchedByLocality;
                          context.read<NearByUsersCubit>().updateUserNearByLatLng(value.placeId!);
                          Navigator.of(context).pop();
                        })
                  ],
                ),
              ),
            ));
  }

  void _applyFilter(BuildContext parentContext) {
    final keyword = _searchNameController.text;
    final school = _schoolValue == null ? '' : _schoolValue!.id!;
    final qualification = _qualificationValue == null ? '' : _qualificationValue!.id!;
    final occupation = _occupationsValue == null ? '' : _occupationsValue!.id!;

    final filterData = FilterDataRequestModel(
        page: 1,
        keyword: keyword,
        toYear: _toYearsValue == StringResources.batchTo ? '' : _toYearsValue,
        fromYear: _fromYearsValue == StringResources.batchFrom ? '' : _fromYearsValue,
        gender: _genderValue,
        state: '',
        distanceRange: _sliderValue,
        school: school,
        qualification: qualification,
        searchNearBy: _searchLocalityController.text,
        occupation: occupation);

    Navigator.of(context).pop({
      ValueKeyResources.filterDataKey: filterData,
      ValueKeyResources.isApplyFilterKey: true,
      ValueKeyResources.isSearchByLocality: _isSearchByLocalitySearched
    });
  }

  void _clearFilter(BuildContext parentContext) async {
    final filterData = FilterDataRequestModel(page: 1);

    Navigator.of(context).pop({
      ValueKeyResources.filterDataKey: filterData,
      ValueKeyResources.isApplyFilterKey: false,
      ValueKeyResources.isSearchByLocality: false
    });
  }

  @override
  void dispose() {
    _searchNameController.dispose();
    _searchLocalityController.dispose();
    super.dispose();
  }
}
