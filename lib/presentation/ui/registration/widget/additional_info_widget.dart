import 'package:flutter/material.dart';
import 'package:navolaya_flutter/core/color_constants.dart';
import 'package:navolaya_flutter/resources/image_resources.dart';

import '../../../../core/route_generator.dart';
import '../../../../resources/string_resources.dart';
import '../../../basicWidget/custom_button.dart';
import '../../../basicWidget/drop_down_widget.dart';
import '../../../basicWidget/text_field_widget.dart';

class AdditionalInfoWidget extends StatefulWidget {
  const AdditionalInfoWidget({Key? key}) : super(key: key);

  @override
  State<AdditionalInfoWidget> createState() => _AdditionalInfoWidgetState();
}

class _AdditionalInfoWidgetState extends State<AdditionalInfoWidget> {
  final TextEditingController _birthdateController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();

  final String _houseValue = 'House';
  final List<String> _houseList = ['House', 'Aravali'];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 116,
            width: 116,
            child: Stack(
              children: [
                Container(
                  height: 114,
                  width: 114,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: ColorConstants.inputBorderColor,
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: Image.asset(
                      ImageResources.cameraIcon,
                      color: Colors.black,
                    ),
                  ),
                ),
                Positioned(
                    bottom: 4,
                    right: 8,
                    child: SizedBox(
                      height: 28,
                      width: 28,
                      child: RawMaterialButton(
                        onPressed: () {},
                        elevation: 2.0,
                        fillColor: Colors.red,
                        padding: const EdgeInsets.all(0),
                        shape: const CircleBorder(),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    )),
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          DropDownWidget<String>(
            list: _houseList,
            value: _houseValue,
          ),
          const SizedBox(
            height: 15,
          ),
          TextFieldWidget(
            controller: _birthdateController,
            hint: StringResources.birthDate,
            textInputType: TextInputType.name,
            isEnabled: false,
            suffixIcon: Padding(
              padding: const EdgeInsets.all(15),
              child: Image.asset(
                ImageResources.calenderIcon,
                height: 5,
              ),
            ),
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
          ButtonWidget(
              buttonText: StringResources.submit.toUpperCase(),
              padding: 0,
              onPressButton: () {
                Navigator.of(context).pushReplacementNamed(RouteGenerator.dashBoardPage);
              }),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _birthdateController.dispose();
    super.dispose();
  }
}
