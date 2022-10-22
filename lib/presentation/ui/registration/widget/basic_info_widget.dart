import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:navolaya_flutter/core/logger.dart';
import 'package:navolaya_flutter/data/model/basic_info_request_model.dart';
import 'package:navolaya_flutter/data/model/login_and_basic_info_model.dart';
import 'package:navolaya_flutter/domain/master_repository.dart';
import 'package:navolaya_flutter/presentation/basicWidget/bottom_sheet_search_widget.dart';
import 'package:navolaya_flutter/presentation/basicWidget/drop_down_widget.dart';
import 'package:navolaya_flutter/presentation/basicWidget/text_field_widget.dart';
import 'package:navolaya_flutter/presentation/bloc/profileBloc/profile_bloc.dart';
import 'package:navolaya_flutter/presentation/ui/registration/widget/gender_radio_widget.dart';

import '../../../../data/model/masters_model.dart';
import '../../../../injection_container.dart';
import '../../../../resources/color_constants.dart';
import '../../../../resources/string_resources.dart';
import '../../../../util/common_functions.dart';
import '../../../basicWidget/custom_button.dart';
import '../../../basicWidget/image_loader_widget.dart';
import '../../../basicWidget/loading_widget.dart';
import '../../../bloc/authBloc/auth_bloc.dart';
import '../../../cubit/helpAndInfoCubit/help_and_info_cubit.dart';
import '../../helpAndInfo/privacy_policy_page.dart';
import '../../helpAndInfo/terms_and_condition_page.dart';
import 'password_input_widget.dart';

class BasicInfoWidget extends StatefulWidget {
  final String countryCode;
  final String mobileNumber;
  final bool isEdit;

  const BasicInfoWidget({
    required this.countryCode,
    required this.mobileNumber,
    this.isEdit = false,
    Key? key,
  }) : super(key: key);

  @override
  State<BasicInfoWidget> createState() => _BasicInfoWidgetState();
}

class _BasicInfoWidgetState extends State<BasicInfoWidget> {
  Schools? _schoolValue;
  late JnvRelations _relationWithJNVValue;
  late OccupationAreas _occupationAreaValue;
  Qualifications? _qualificationValue;
  Occupations? _occupationsValue;

  String _fromYearsValue = StringResources.batchFrom;
  String _toYearsValue = StringResources.batchTo;
  String _genderValue = StringResources.male;

  final List<String> _fromYearsList = [];
  final List<String> _toYearsList = [];
  late final List<Schools> _schoolList;
  late final List<JnvRelations> _relationWithJNVList;
  late final List<OccupationAreas> _occupationAreaList;
  late final List<Qualifications> _qualificationList;
  late final List<Occupations> _occupationList;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late final ValueNotifier<Schools?> _schoolSelectNotifier;
  late final ValueNotifier<Qualifications?> _qualificationSelectNotifier;
  late final ValueNotifier<Occupations?> _occupationSelectNotifier;
  late final Future<void> _fetchFutureEditData;
  final _termAndConditionReadNotifier = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _fetchFutureEditData = fetchPersonalDetails();

    final masterRepository = sl<MasterRepository>();

    ///
    _schoolList = masterRepository.schoolsList;
    //_schoolValue = _schoolList.first;
    _schoolSelectNotifier = ValueNotifier(_schoolValue);

    ///
    _relationWithJNVList = masterRepository.relationWithJNVList;
    _relationWithJNVValue = _relationWithJNVList.first;

    ///
    _occupationAreaList = masterRepository.occupationAreasList;
    _occupationAreaValue = _occupationAreaList.first;

    ///
    _qualificationList = masterRepository.qualificationsList;
    //_qualificationValue = _qualificationList.first;
    _qualificationSelectNotifier = ValueNotifier(_qualificationValue);

    ///
    _occupationList = masterRepository.occupationsList;
    //_occupationsValue = _occupationList.first;
    _occupationSelectNotifier = ValueNotifier(_occupationsValue);

    ///
    createYears();
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
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (_, state) async {
        if (state is LoadPersonalDetailsState) {
          loadPersonalDetails(state.loginAndBasicInfoData);
        } else if (state is ProfileErrorState) {
          sl<CommonFunctions>().showFlushBar(
            context: context,
            message: state.message,
            bgColor: ColorConstants.messageErrorBgColor,
          );
        } else if (state is LoadUpdateProfileBasicInfoState) {
          await sl<CommonFunctions>().showFlushBar(
              context: context, message: state.loginAndBasicInfoData.message!, duration: 1);
          if (!mounted) return;
          Navigator.of(context).pop();
        }
      },
      child: widget.isEdit
          ? FutureBuilder(
              future: _fetchFutureEditData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const ImageLoaderWidget();
                }
                return loadMainView();
              })
          : loadMainView(),
    );
  }

  Widget loadMainView() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.isEdit) ...[
              const SizedBox(
                height: 20,
              ),
            ],
            TextFieldWidget(
              controller: _nameController,
              hint: StringResources.enterNameHint,
              textInputType: TextInputType.text,
              regex: "^[A-Za-z]+[A-Za-z ]*",
              textInCaps: true,
              /*isEnabled: !widget.isEdit,*/
            ),
            const SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: /*widget.isEdit
                  ? null
                  :*/
                  () => showSearchBottomSheet<Schools>(
                _schoolList,
                _schoolValue,
                StringResources.searchSchool,
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                decoration: BoxDecoration(
                  border: Border.all(color: ColorConstants.inputBorderColor, width: 1),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(children: [
                  Expanded(
                    child: ValueListenableBuilder<Schools?>(
                      valueListenable: _schoolSelectNotifier,
                      builder: (_, value, __) {
                        final String school = _schoolValue == null
                            ? 'Select School'
                            : 'JNV ${_schoolValue!.city!}, ${_schoolValue!.district!}';
                        return Text(
                          school,
                          style: const TextStyle(
                              color: /*widget.isEdit ? ColorConstants.disabledColor :*/ Colors
                                  .black),
                        );
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
            DropDownWidget<JnvRelations>(
              list: _relationWithJNVList,
              value: _relationWithJNVValue,
              onValueSelect: (JnvRelations value) {
                _relationWithJNVValue = value;
              },
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
                  /*isDropDownEnabled: !widget.isEdit,*/
                  onValueSelect: (String value) {
                    _fromYearsValue = value;
                  },
                )),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: DropDownWidget<String>(
                  list: _toYearsList,
                  value: _toYearsValue,
                  /*isDropDownEnabled: !widget.isEdit,*/
                  onValueSelect: (String value) {
                    _toYearsValue = value;
                  },
                )),
              ],
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
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
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
                            ? 'Qualification'
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
            DropDownWidget<OccupationAreas>(
              list: _occupationAreaList,
              value: _occupationAreaValue,
              onValueSelect: (OccupationAreas value) {
                _occupationAreaValue = value;
              },
            ),
            const SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () => showSearchBottomSheet(
                _occupationList,
                _occupationsValue,
                StringResources.searchOccupation,
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                decoration: BoxDecoration(
                  border: Border.all(color: ColorConstants.inputBorderColor, width: 1),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Row(children: [
                  Expanded(
                    child: ValueListenableBuilder<Occupations?>(
                      valueListenable: _occupationSelectNotifier,
                      builder: (_, value, __) {
                        return Text(
                            _occupationsValue == null ? 'Occupation' : _occupationsValue!.title!);
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
            GenderRadioWidget(
              gender: _genderValue,
              onValueSelect: (String value) {
                _genderValue = value;
              },
            ),
            const SizedBox(
              height: 15,
            ),
            if (!widget.isEdit) ...[
              PasswordInputWidget(
                textEditingController: _passwordController,
                showOrHidePassword: true,
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ValueListenableBuilder<bool>(
                    valueListenable: _termAndConditionReadNotifier,
                    builder: (_, checked, ___) {
                      return Checkbox(
                        value: checked,
                        visualDensity: const VisualDensity(horizontal: -4),
                        onChanged: (bool? value) {
                          _termAndConditionReadNotifier.value = value!;
                        },
                      );
                    },
                  ),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 11.0,
                          color: Colors.black,
                          fontFamily: 'Montserrat',
                        ),
                        children: <TextSpan>[
                          const TextSpan(text: 'I agree to the '),
                          TextSpan(
                            text: 'Privacy Policy ',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => BlocProvider.value(
                                          value: BlocProvider.of<HelpAndInfoCubit>(context),
                                          child: const PrivacyPolicyPage(),
                                        )));
                              },
                          ),
                          const TextSpan(text: 'and '),
                          TextSpan(
                            text: 'Terms & Conditions.',
                            style:
                                const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => BlocProvider.value(
                                          value: BlocProvider.of<HelpAndInfoCubit>(context),
                                          child: const TermsAndConditionPage(),
                                        )));
                              },
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
            ],
            getButton(),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget getButton() {
    if (widget.isEdit) {
      return BlocBuilder<ProfileBloc, ProfileState>(builder: (_, state) {
        if (state is ProfileLoadingState) {
          return const LoadingWidget();
        } else {
          return ButtonWidget(
            buttonText: StringResources.save.toUpperCase(),
            padding: 0,
            onPressButton: () => initiateUpdateBasicInfo(),
          );
        }
      });
    }

    return BlocBuilder<AuthBloc, AuthState>(builder: (_, state) {
      if (state is AuthLoadingState) {
        return const LoadingWidget();
      } else {
        return ValueListenableBuilder<bool>(
          valueListenable: _termAndConditionReadNotifier,
          builder: (_, checked_, ___) {
            logger.i(checked_);
            return ButtonWidget(
              buttonText: StringResources.next.toUpperCase(),
              padding: 0,
              isEnabled: checked_,
              onPressButton: () => initiateUpdateBasicInfo(),
            );
          },
        );
      }
    });
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
        builder: (_) {
          return BottomSheetSearchWidget<T>(
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
          );
        });
  }

  void initiateUpdateBasicInfo() {
    if (_nameController.text.isEmpty) {
      showValidationMessage(StringResources.pleaseEnterName);
    } else if (_nameController.text.length < 3) {
      showValidationMessage(StringResources.pleaseEnterValidName);
    } else if (_schoolValue == null) {
      showValidationMessage(StringResources.pleaseSelectSchool);
    } else if (_relationWithJNVValue.id!.isEmpty) {
      showValidationMessage(StringResources.pleaseSelectRelationWithJNV);
    } else if (_fromYearsValue == StringResources.batchFrom) {
      showValidationMessage(StringResources.pleaseSelectBatchFrom);
    } else if (_toYearsValue == StringResources.batchTo) {
      showValidationMessage(StringResources.pleaseSelectBatchTo);
    } else if (int.parse(_toYearsValue) < int.parse(_fromYearsValue)) {
      showValidationMessage(StringResources.batchSelectionIsWrong);
    } else if (_qualificationValue == null) {
      showValidationMessage(StringResources.pleaseSelectGraduations);
    } else if (_occupationAreaValue.id!.isEmpty) {
      showValidationMessage(StringResources.pleaseSelectOccupationArea);
    } else if (_occupationsValue == null) {
      showValidationMessage(StringResources.pleaseSelectProfession);
    } else if (_passwordController.text.isEmpty && !widget.isEdit) {
      showValidationMessage(StringResources.pleaseEnterPassword);
    } else {
      final basicInfoRequestData = BasicInfoRequestModel(
          widget.countryCode,
          widget.mobileNumber,
          _nameController.text,
          _schoolValue!.id!,
          _relationWithJNVValue.title!,
          _fromYearsValue,
          _toYearsValue,
          _qualificationValue!.id!,
          _occupationsValue!.id!,
          _occupationAreaValue.id!,
          _genderValue,
          widget.isEdit ? '' : _passwordController.text);

      if (!widget.isEdit) {
        context
            .read<AuthBloc>()
            .add(InitiateUpdateBasicInfoEvent(basicInfoRequestData: basicInfoRequestData));
      } else {
        context
            .read<ProfileBloc>()
            .add(UpdateProfileBasicInfoEvent(basicInfoRequestData: basicInfoRequestData));
      }
    }
  }

  void showValidationMessage(String message) {
    if (mounted) {
      sl<CommonFunctions>().showFlushBar(
        context: context,
        message: message,
        bgColor: ColorConstants.messageErrorBgColor,
      );
    }
    return;
  }

  void loadPersonalDetails(LoginAndBasicInfoModel data) {
    if (data.data != null) {
      _nameController.text = data.data!.fullName!;

      ///
      _schoolValue = _schoolList.firstWhere((element) => data.data!.school!.city == element.city);
      _schoolSelectNotifier.value = _schoolValue;

      ///
      _relationWithJNVValue =
          _relationWithJNVList.firstWhere((element) => data.data!.relationWithJnv == element.title);

      ///
      if (data.data!.occupation != null) {
        _occupationAreaValue = _occupationAreaList
            .firstWhere((element) => data.data!.occupation?.area! == element.title);
      }

      ///
      if (data.data!.qualification != null) {
        _qualificationValue = _qualificationList
            .firstWhere((element) => data.data!.qualification?.title == element.title);
        _qualificationSelectNotifier.value = _qualificationValue;
      }

      ///
      if (data.data!.occupation != null) {
        _occupationsValue =
            _occupationList.firstWhere((element) => data.data!.occupation?.title == element.title);
        _occupationSelectNotifier.value = _occupationsValue;
      }

      ///
      _fromYearsValue = '${data.data!.fromYear}';

      ///
      _toYearsValue = '${data.data!.toYear}';

      ///
      if (data.data!.gender != null) {
        /*if (data.data!.gender == 'Male') {
          _genderValue = StringResources.male;
        } else if (data.data!.gender == 'Female') {
          _genderValue = StringResources.female;
        } else {
          _genderValue = StringResources.other;
        }*/
        _genderValue = data.data!.gender!;
      }

      ///

      setState(() {});
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> fetchPersonalDetails() async {
    if (widget.isEdit) {
      await Future.delayed(const Duration(milliseconds: 500));
      if (!mounted) return;
      context.read<ProfileBloc>().add(const FetchPersonalDetails());
    }
  }
}
