import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:navolaya_flutter/presentation/basicWidget/date_input_widget.dart';
import 'package:navolaya_flutter/presentation/profileImageWidget/profile_image_widget.dart';

import '../../../../data/model/masters_model.dart';
import '../../../../domain/master_repository.dart';
import '../../../../injection_container.dart';
import '../../../../resources/string_resources.dart';
import '../../../basicWidget/custom_button.dart';
import '../../../basicWidget/drop_down_widget.dart';
import '../../../basicWidget/loading_widget.dart';
import '../../../basicWidget/text_field_widget.dart';
import '../../../bloc/authBloc/auth_bloc.dart';

class AdditionalInfoWidget extends StatefulWidget {
  const AdditionalInfoWidget({Key? key}) : super(key: key);

  @override
  State<AdditionalInfoWidget> createState() => _AdditionalInfoWidgetState();
}

class _AdditionalInfoWidgetState extends State<AdditionalInfoWidget> {
  late JnvHouses _jnvHousesValues;
  late final List<JnvHouses> _jnvHousesList;

  CroppedFile? _croppedFile;
  String _selectedDate = '';
  final TextEditingController _aboutController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final masterRepository = sl<MasterRepository>();

    ///
    _jnvHousesList = masterRepository.jnvHousesList;
    _jnvHousesValues = _jnvHousesList.first;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          ProfileImageWidget(
            onImageSelected: (CroppedFile file) {
              _croppedFile = file;
            },
          ),
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
          DateInputWidget(onDateSelected: (String birthDate) {
            _selectedDate = birthDate;
          }),
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
          BlocBuilder<AuthBloc, AuthState>(builder: (_, state) {
            if (state is AuthLoadingState) {
              return const LoadingWidget();
            } else {
              return ButtonWidget(
                  buttonText: StringResources.submit.toUpperCase(),
                  padding: 0,
                  onPressButton: () {
                    context.read<AuthBloc>().add(
                          InitiateUpdateAdditionalInfo(
                              userImage: _croppedFile == null ? '' : _croppedFile!.path,
                              house: _jnvHousesValues.id!.isEmpty ? '' : _jnvHousesValues.title!,
                              birthDate: _selectedDate,
                              aboutMe: _aboutController.text),
                        );
                  });
            }
          }),
        ],
      ),
    );
  }
}
