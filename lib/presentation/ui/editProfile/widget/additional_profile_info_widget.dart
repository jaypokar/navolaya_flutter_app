import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navolaya_flutter/data/model/login_and_basic_info_model.dart';
import 'package:navolaya_flutter/presentation/basicWidget/image_loader_widget.dart';

import '../../../../core/route_generator.dart';
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
  final TextEditingController _currentAddressController = TextEditingController();
  final TextEditingController _permanentAddressController = TextEditingController();
  late final Future<void> _fetchFutureEditData;

  @override
  void initState() {
    super.initState();

    _fetchFutureEditData = fetchPersonalDetails();
    final masterRepository = sl<MasterRepository>();

    ///
    _jnvHousesList = masterRepository.jnvHousesList;
    _jnvHousesValues = _jnvHousesList.first;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (_, state) async {
        if (widget.isEdit) {
          if (state is ProfileErrorState) {
            showMessage(true, state.message);
          } else if (state is UpdateAdditionalInfoState) {
            if (widget.isEdit) {
              await showMessage(false, state.updateAdditionalInfo.message!, duration: 1);
              if (mounted) {
                Navigator.of(context).pop();
              }
            }
          } else if (state is LoadPersonalDetailsState) {
            _loadPersonalDetails(state.loginAndBasicInfoData);
          }
        }
      },
      child: widget.isEdit
          ? FutureBuilder(
              future: _fetchFutureEditData,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const ImageLoaderWidget();
                }
                return _loadMainView();
              })
          : _loadMainView(),
    );
  }

  Widget _loadMainView() {
    return SingleChildScrollView(
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
            hint: StringResources.aboutMeOptional,
            textInputType: TextInputType.multiline,
            allowSmileys: true,
            max: 1000,
            maxLines: 3,
          ),
          const SizedBox(
            height: 15,
          ),
          if (widget.isEdit) ...[
            TextFieldWidget(
              controller: _currentAddressController,
              hint: StringResources.currentAddressOptional,
              textInputType: TextInputType.streetAddress,
              max: 1000,
              maxLines: 3,
            ),
            const SizedBox(
              height: 15,
            ),
            TextFieldWidget(
              controller: _permanentAddressController,
              hint: StringResources.permanentAddressOptional,
              textInputType: TextInputType.streetAddress,
              max: 1000,
              maxLines: 3,
            ),
            const SizedBox(
              height: 15,
            ),
          ],
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
                    if (_jnvHousesValues.id!.isNotEmpty ||
                        _selectedDate.isNotEmpty ||
                        _aboutController.text.isNotEmpty ||
                        _currentAddressController.text.isNotEmpty ||
                        _permanentAddressController.text.isNotEmpty) {
                      context.read<ProfileBloc>().add(
                            InitiateUpdateAdditionalInfo(
                              house: _jnvHousesValues.id!.isEmpty ? '' : _jnvHousesValues.title!,
                              birthDate: _selectedDate,
                              aboutMe: _aboutController.text,
                              currentAddress: _currentAddressController.text,
                              permanentAddress: _permanentAddressController.text,
                            ),
                          );
                    } else {
                      if (!widget.isEdit) {
                        Navigator.of(context).pushReplacementNamed(RouteGenerator.dashBoardPage);
                      }
                    }
                  });
            }
          }),
          if (!widget.isEdit) ...[
            const SizedBox(
              height: 15,
            ),
            OutlinedButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(RouteGenerator.dashBoardPage);
              },
              style: OutlinedButton.styleFrom(
                minimumSize: const Size.fromHeight(42),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                side: const BorderSide(
                  width: 1.0,
                  color: ColorConstants.messageBgColor,
                ),
              ),
              child: Text(
                StringResources.skipAndContinue.toUpperCase(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: ColorConstants.messageBgColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
          ]
        ],
      ),
    );
  }

  Future<void> fetchPersonalDetails() async {
    if (widget.isEdit) {
      await Future.delayed(const Duration(milliseconds: 500));
      if (!mounted) return;
      context.read<ProfileBloc>().add(const FetchPersonalDetails());
    }
  }

  void _loadPersonalDetails(LoginAndBasicInfoModel loginAndBasicInfo) {
    if (loginAndBasicInfo.data!.house != null) {
      if (loginAndBasicInfo.data!.house!.isNotEmpty) {
        _jnvHousesValues =
            _jnvHousesList.firstWhere((element) => loginAndBasicInfo.data!.house == element.title);
      }
    }
    _aboutController.text = loginAndBasicInfo.data!.aboutMe!;
    if (loginAndBasicInfo.data!.currentAddress != null) {
      _currentAddressController.text = loginAndBasicInfo.data!.currentAddress!;
    }
    if (loginAndBasicInfo.data!.permanentAddress != null) {
      _permanentAddressController.text = loginAndBasicInfo.data!.permanentAddress!;
    }
    setState(() {});
  }

  Future<void> showMessage(bool isError, String message, {int duration = 2}) async {
    if (mounted) {
      await sl<CommonFunctions>().showFlushBar(
          context: context,
          message: message,
          bgColor: isError ? ColorConstants.messageErrorBgColor : ColorConstants.messageBgColor,
          duration: duration);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _aboutController.dispose();
  }
}
