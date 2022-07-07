import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:navolaya_flutter/resources/string_resources.dart';

import '../../../../core/color_constants.dart';
import '../../../../core/logger.dart';
import '../../../basicWidget/custom_button.dart';

class MobileNumberWidget extends StatelessWidget {
  final PageController pageController;
  final TextEditingController textController;
  final double screenHeight;

  const MobileNumberWidget(
      {required this.pageController,
      required this.textController,
      required this.screenHeight,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: screenHeight,
            ),
            const Text(
              StringResources.welcomeBack,
              style: TextStyle(
                color: ColorConstants.textColor1,
                fontWeight: FontWeight.bold,
                fontSize: 28,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
                width: 60,
                child: Divider(
                  color: ColorConstants.appColor,
                  thickness: 2,
                )),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: Text(
                StringResources.mobileNumberPageSubtitle,
                textAlign: TextAlign.center,
                style: TextStyle(
                    height: 1.8,
                    color: ColorConstants.textColor1,
                    fontWeight: FontWeight.w400,
                    fontSize: 14),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: const BorderRadius.all(Radius.circular(5)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: CountryCodePicker(
                      onChanged: (countryCode) {
                        logger.i("New Country selected: $countryCode");
                      },
                      flagWidth: 20,
                      padding: const EdgeInsets.all(0),
                      initialSelection: 'IN',
                      textOverflow: TextOverflow.fade,
                      textStyle: const TextStyle(
                        color: ColorConstants.textColor3,
                        fontSize: 10,
                      ),
                      favorite: const ['+91'],
                      showCountryOnly: false,
                      showOnlyCountryWhenClosed: false,
                      alignLeft: true,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: VerticalDivider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: TextField(
                      controller: textController,
                      keyboardType: const TextInputType.numberWithOptions(decimal: false),
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                      maxLength: 10,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                      ],
                      decoration: const InputDecoration(
                        labelText: StringResources.phoneNumberHint,
                        isDense: true,
                        counterText: '',
                        hintStyle: TextStyle(
                          color: ColorConstants.textColor3,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ButtonWidget(
                buttonText: StringResources.continueText.toUpperCase(),
                onPressButton: () {
                  pageController.jumpToPage(1);
                }),
          ],
        ),
      ),
    );
  }
}
