import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navolaya_flutter/presentation/bloc/authBloc/auth_bloc.dart';
import 'package:navolaya_flutter/resources/string_resources.dart';
import 'package:navolaya_flutter/util/common_functions.dart';

import '../../../../core/color_constants.dart';
import '../../../../core/logger.dart';
import '../../../../injection_container.dart';
import '../../../basicWidget/custom_button.dart';
import '../../../basicWidget/loading_widget.dart';

class MobileNumberWidget extends StatefulWidget {
  final PageController pageController;

  final double screenHeight;
  final Function validatePhone;

  const MobileNumberWidget(
      {required this.pageController,
      required this.screenHeight,
      required this.validatePhone,
      Key? key})
      : super(key: key);

  @override
  State<MobileNumberWidget> createState() => _MobileNumberWidgetState();
}

class _MobileNumberWidgetState extends State<MobileNumberWidget> {
  String _countryCode = '+91';
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: widget.screenHeight,
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
                      onChanged: (code) {
                        _countryCode = code.dialCode!;
                        logger.i("New Country selected: $_countryCode");
                      },
                      flagWidth: 15,
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
                      controller: _textController,
                      keyboardType: const TextInputType.numberWithOptions(decimal: false),
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                      maxLength: 10,
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                      ],
                      decoration: const InputDecoration(
                        /*labelText: StringResources.phoneNumberHint,*/
                        isDense: true,
                        counterText: '',
                        hintText: StringResources.phoneNumberHint,
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
            buildButton(),
          ],
        ),
      ),
    );
  }

  Widget buildButton() {
    return BlocBuilder<AuthBloc, AuthState>(builder: (_, state) {
      if (state is AuthLoadingState) {
        return const LoadingWidget();
      } else {
        return ButtonWidget(
          buttonText: StringResources.continueText.toUpperCase(),
          onPressButton: () {
            if (_textController.text.isEmpty) {
              sl<CommonFunctions>().showSnackBar(
                  context: context,
                  message: StringResources.phoneNumberHint,
                  bgColor: Colors.orange,
                  textColor: Colors.white);
              return;
            }
            widget.validatePhone(_countryCode, _textController.text);
          },
        );
      }
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
