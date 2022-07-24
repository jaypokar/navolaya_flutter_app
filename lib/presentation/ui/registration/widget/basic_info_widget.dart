import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navolaya_flutter/data/model/basic_info_request_model.dart';
import 'package:navolaya_flutter/data/model/login_and_basic_info_model.dart';
import 'package:navolaya_flutter/domain/master_repository.dart';
import 'package:navolaya_flutter/presentation/basicWidget/drop_down_widget.dart';
import 'package:navolaya_flutter/presentation/basicWidget/text_field_widget.dart';
import 'package:navolaya_flutter/presentation/bloc/profileBloc/profile_bloc.dart';
import 'package:navolaya_flutter/presentation/ui/registration/widget/gender_radio_widget.dart';

import '../../../../data/model/masters_model.dart';
import '../../../../injection_container.dart';
import '../../../../resources/string_resources.dart';
import '../../../../util/common_functions.dart';
import '../../../basicWidget/custom_button.dart';
import '../../../basicWidget/group_drop_down_widget.dart';
import '../../../basicWidget/loading_widget.dart';
import '../../../bloc/authBloc/auth_bloc.dart';
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
  late Schools _schoolValue;
  late JnvRelations _relationWithJNVValue;
  late OccupationAreas _occupationAreaValue;
  late Qualifications _qualificationValue;
  late Occupations _occupationsValue;

  String _fromYearsValue = '1970';
  String _toYearsValue = '';
  String _genderValue = 'Male';

  final List<String> _formYearsList = [];
  final List<String> _toYearsList = [];
  late final List<Schools> _schoolList;
  late final List<JnvRelations> _relationWithJNVList;
  late final List<OccupationAreas> _occupationAreaList;
  late final List<Qualifications> _qualificationList;
  late final List<Occupations> _occupationList;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final masterRepository = sl<MasterRepository>();

    ///
    _schoolList = masterRepository.schoolsList;
    _schoolValue = _schoolList.first;

    ///
    _relationWithJNVList = masterRepository.relationWithJNVList;
    _relationWithJNVValue = _relationWithJNVList.first;

    ///
    _occupationAreaList = masterRepository.occupationAreasList;
    _occupationAreaValue = _occupationAreaList.first;

    ///
    _qualificationList = masterRepository.qualificationsList;
    _qualificationValue = _qualificationList.first;

    ///
    _occupationList = masterRepository.occupationsList;
    _occupationsValue = _occupationList.first;

    ///
    createYears();

    if (widget.isEdit) {
      context.read<ProfileBloc>().add(const FetchPersonalDetails());
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
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (_, state) {
        if (state is LoadPersonalDetailsState) {
          loadPersonalDetails(state.loginAndBasicInfoData);
        } else if (state is ProfileErrorState) {
          sl<CommonFunctions>().showSnackBar(
            context: context,
            message: state.message,
            bgColor: Colors.red,
            textColor: Colors.white,
          );
        } else if (state is LoadUpdateProfileBasicInfoState) {
          sl<CommonFunctions>().showSnackBar(
            context: context,
            message: state.loginAndBasicInfoData.message!,
            bgColor: Colors.green,
            textColor: Colors.white,
          );
        }
      },
      child: SingleChildScrollView(
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
                textInputType: TextInputType.name,
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
                    list: _formYearsList,
                    value: _fromYearsValue,
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
                    onValueSelect: (String value) {
                      _toYearsValue = value;
                    },
                  )),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              GroupDropDownWidget<Qualifications>(
                list: _qualificationList,
                value: _qualificationValue,
                onValueSelect: (Qualifications value) {
                  _qualificationValue = value;
                },
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
              GroupDropDownWidget<Occupations>(
                list: _occupationList,
                value: _occupationsValue,
                onValueSelect: (Occupations value) {
                  _occupationsValue = value;
                },
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
                height: 10,
              ),
              if (!widget.isEdit) ...[
                PasswordInputWidget(
                  textEditingController: _passwordController,
                  showOrHidePassword: true,
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
              getButton()
            ],
          ),
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
        return ButtonWidget(
          buttonText: StringResources.next.toUpperCase(),
          padding: 0,
          onPressButton: () => initiateUpdateBasicInfo(),
        );
      }
    });
  }

  void initiateUpdateBasicInfo() {
    if (_nameController.text.isEmpty) {
      showValidationMessage(StringResources.pleaseEnterName);
    } else if (_schoolValue.id!.isEmpty) {
      showValidationMessage(StringResources.pleaseSelectSchool);
    } else if (_relationWithJNVValue.id!.isEmpty) {
      showValidationMessage(StringResources.pleaseSelectRelationWithJNV);
    } else if (_qualificationValue.id!.isEmpty) {
      showValidationMessage(StringResources.pleaseSelectGraduations);
    } else if (_occupationAreaValue.id!.isEmpty) {
      showValidationMessage(StringResources.pleaseSelectOccupationArea);
    } else if (_occupationsValue.id!.isEmpty) {
      showValidationMessage(StringResources.pleaseSelectProfession);
    } else if (_passwordController.text.isEmpty && !widget.isEdit) {
      showValidationMessage(StringResources.pleaseEnterPassword);
    } else {
      final basicInfoRequestData = BasicInfoRequestModel(
          widget.countryCode,
          widget.mobileNumber,
          _nameController.text,
          _schoolValue.id!,
          _relationWithJNVValue.title!,
          _fromYearsValue,
          _toYearsValue,
          {
            'area': _qualificationValue.area!,
            'title': _qualificationValue.title!,
            'shortname': _qualificationValue.shortName!
          },
          {
            'area': _occupationAreaValue.title!,
            'type': _occupationsValue.area,
            'title': _occupationsValue.title,
          },
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
      sl<CommonFunctions>().showSnackBar(
        context: context,
        message: message,
        bgColor: Colors.orange,
        textColor: Colors.white,
      );
    }
    return;
  }

  void loadPersonalDetails(LoginAndBasicInfoModel data) {
    if (data.data != null) {
      _nameController.text = data.data!.fullName!;

      ///
      _schoolValue = _schoolList.firstWhere((element) => data.data!.school!.state == element.state);

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
      }

      ///
      if (data.data!.occupation != null) {
        _occupationsValue =
            _occupationList.firstWhere((element) => data.data!.occupation?.title == element.title);
      }

      ///
      _fromYearsValue = '${data.data!.fromYear}';

      ///
      _toYearsValue = '${data.data!.toYear}';

      ///
      if (data.data!.gender == 'male') {
        _genderValue = 'Male';
      } else if (data.data!.gender == 'female') {
        _genderValue = 'Female';
      } else {
        _genderValue = 'Other';
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
}
