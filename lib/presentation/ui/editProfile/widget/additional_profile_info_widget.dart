import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navolaya_flutter/data/model/login_and_basic_info_model.dart';

import '../../../../data/model/masters_model.dart';
import '../../../../domain/master_repository.dart';
import '../../../../injection_container.dart';
import '../../../../resources/color_constants.dart';
import '../../../../resources/string_resources.dart';
import '../../../../util/common_functions.dart';
import '../../../basicWidget/custom_button.dart';
import '../../../basicWidget/date_input_widget.dart';
import '../../../basicWidget/drop_down_widget.dart';
import '../../../basicWidget/loading_widget.dart';
import '../../../basicWidget/text_field_widget.dart';
import '../../../bloc/profileBloc/profile_bloc.dart';

class AdditionalProfileInfoWidget extends StatefulWidget {
  final bool isEdit;

  const AdditionalProfileInfoWidget({this.isEdit = false, Key? key}) : super(key: key);

  @override
  State<AdditionalProfileInfoWidget> createState() => _AdditionalProfileInfoWidgetState();
}

class _AdditionalProfileInfoWidgetState extends State<AdditionalProfileInfoWidget> {
  late JnvHouses _jnvHousesValues;
  late final List<JnvHouses> _jnvHousesList;
  String _selectedDate = '';
  final TextEditingController _aboutController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final masterRepository = sl<MasterRepository>();

    ///
    _jnvHousesList = masterRepository.jnvHousesList;
    _jnvHousesValues = _jnvHousesList.first;

    if (widget.isEdit) {
      context.read<ProfileBloc>().add(const FetchPersonalDetails());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (_, state) {
        if (widget.isEdit) {
          if (state is ProfileErrorState) {
            showMessage(true, state.message);
          } else if (state is UpdateAdditionalInfoState) {
            showMessage(false, state.updateAdditionalInfo.message!);
          } else if (state is LoadPersonalDetailsState) {
            _loadPersonalDetails(state.loginAndBasicInfoData);
          }
        }
      },
      child: Column(
        children: [
          const SizedBox(
            height: 40,
          ),
          DropDownWidget<JnvHouses>(
            list: _jnvHousesList,
            value: _jnvHousesValues,
            onValueSelect: (JnvHouses value) {
              _jnvHousesValues = value;
            },
          ),
          const SizedBox(
            height: 15,
          ),
          BlocBuilder<ProfileBloc, ProfileState>(
            buildWhen: (_, state) => state is LoadPersonalDetailsState,
            builder: (_, state) {
              if (state is LoadPersonalDetailsState) {
                if (state.loginAndBasicInfoData.data!.birthDate != null) {
                  _selectedDate =
                      state.loginAndBasicInfoData.data!.birthDate!.toString().substring(0, 10);
                }
              }
              return DateInputWidget(
                onDateSelected: (String birthDate) {
                  _selectedDate = birthDate;
                },
                initialDate: _selectedDate,
              );
            },
          ),
          const SizedBox(
            height: 15,
          ),
          TextFieldWidget(
            controller: _aboutController,
            hint: StringResources.aboutMe,
            textInputType: TextInputType.text,
            max: 1000,
            maxLines: 6,
          ),
          const SizedBox(
            height: 15,
          ),
          BlocBuilder<ProfileBloc, ProfileState>(builder: (_, state) {
            if (state is ProfileLoadingState) {
              return const LoadingWidget();
            } else {
              return ButtonWidget(
                  buttonText: widget.isEdit
                      ? StringResources.save.toUpperCase()
                      : StringResources.submit.toUpperCase(),
                  padding: 0,
                  onPressButton: () {
                    if (_jnvHousesValues.id!.isNotEmpty) {
                      context.read<ProfileBloc>().add(
                            InitiateUpdateAdditionalInfo(
                                house: _jnvHousesValues.id!.isEmpty ? '' : _jnvHousesValues.title!,
                                birthDate: _selectedDate,
                                aboutMe: _aboutController.text),
                          );
                    } else {
                      sl<CommonFunctions>().showSnackBar(
                          context: context,
                          message: StringResources.pleaseSelectHouse,
                          bgColor: Colors.orange,
                          textColor: Colors.white);
                    }
                  });
            }
          }),
        ],
      ),
    );
  }

  void _loadPersonalDetails(LoginAndBasicInfoModel loginAndBasicInfo) {
    if (loginAndBasicInfo.data!.house != null) {
      if (loginAndBasicInfo.data!.house!.isNotEmpty) {
        _jnvHousesValues =
            _jnvHousesList.firstWhere((element) => loginAndBasicInfo.data!.house == element.title);
        _aboutController.text = loginAndBasicInfo.data!.aboutMe!;
        setState(() {});
      }
    }
  }

  void showMessage(bool isError, String message) {
    if (mounted) {
      sl<CommonFunctions>().showSnackBar(
        context: context,
        message: message,
        bgColor: isError ? Colors.red : ColorConstants.appColor,
        textColor: Colors.white,
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _aboutController.dispose();
  }
}
