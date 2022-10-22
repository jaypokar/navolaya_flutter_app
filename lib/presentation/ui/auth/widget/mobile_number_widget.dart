import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navolaya_flutter/core/logger.dart';
import 'package:navolaya_flutter/presentation/basicWidget/country_flag_and_code_rich_text_widget.dart';
import 'package:navolaya_flutter/presentation/bloc/authBloc/auth_bloc.dart';
import 'package:navolaya_flutter/resources/string_resources.dart';
import 'package:navolaya_flutter/util/common_functions.dart';
import 'package:phone_number/phone_number.dart';

import '../../../../injection_container.dart';
import '../../../../resources/color_constants.dart';
import '../../../basicWidget/custom_button.dart';
import '../../../basicWidget/loading_widget.dart';
import '../../../cubit/keyboardVisibilityCubit/key_board_visibility_cubit.dart';

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
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textController = TextEditingController();
  final CountryCodeSelection _countryCodeSelection =
      CountryCodeSelection(flagEmoji: '🇮🇳', countryCode: '+91');
  late final ValueNotifier<CountryCodeSelection> countryPickerNotifier;

  @override
  void initState() {
    super.initState();
    countryPickerNotifier = ValueNotifier(_countryCodeSelection);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<KeyBoardVisibilityCubit, bool>(
      listener: (_, isVisible) => sl<CommonFunctions>().animateWidgetWhenKeyboardOpens(
        scrollController: _scrollController,
        isKeyBoardVisible: isVisible,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          controller: _scrollController,
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
                    ValueListenableBuilder<CountryCodeSelection>(
                      valueListenable: countryPickerNotifier,
                      builder: (_, code, __) {
                        return Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: CountryFlagAndCodeRichTextWidget(
                              onClickEvent: () => showCountryPickerDialog(),
                              textOne: code.flagEmoji,
                              textTwo: code.countryCode,
                            ));
                      },
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
                        maxLength: 15,
                        textInputAction: TextInputAction.done,
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
      ),
    );
  }

  void showCountryPickerDialog() {
    showCountryPicker(
        context: context,
        showPhoneCode: true,
        favorite: ['IN'],
        countryListTheme: CountryListThemeData(
          flagSize: 25,
          backgroundColor: Colors.white,
          textStyle: const TextStyle(fontSize: 16, color: Colors.blueGrey),
          bottomSheetHeight: 500,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          inputDecoration: InputDecoration(
            labelText: StringResources.searchByCountry,
            hintText: 'Start typing to search',
            prefixIcon: const Icon(Icons.search),
            contentPadding: EdgeInsets.zero,
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: const Color(0xFF8C98A8).withOpacity(0.2),
              ),
            ),
          ),
        ),
        onSelect: (Country country) {
          _countryCode = '+${country.phoneCode}';
          countryPickerNotifier.value = CountryCodeSelection(
              flagEmoji: country.flagEmoji, countryCode: '+${country.phoneCode}');
        });
  }

  Widget buildButton() {
    return BlocBuilder<AuthBloc, AuthState>(builder: (_, state) {
      if (state is AuthLoadingState) {
        return const LoadingWidget();
      } else {
        return ButtonWidget(
          buttonText: StringResources.continueText.toUpperCase(),
          onPressButton: () async {
            if (_textController.text.isEmpty) {
              sl<CommonFunctions>().showFlushBar(
                context: context,
                message: StringResources.phoneNumberHint,
                bgColor: ColorConstants.messageErrorBgColor,
              );
              return;
            } else if (_textController.text.length < 7) {
              sl<CommonFunctions>().showFlushBar(
                context: context,
                message: StringResources.pleaseEnterValidPhoneNumber,
                bgColor: ColorConstants.messageErrorBgColor,
              );
              return;
            }
            bool isValid = await PhoneNumberUtil().validate('$_countryCode${_textController.text}');
            logger.i('phone number is valid: $isValid');
            if (isValid) {
              FocusManager.instance.primaryFocus?.unfocus();
              widget.validatePhone(_countryCode, _textController.text);
            } else {
              sl<CommonFunctions>().showFlushBar(
                context: context,
                message: StringResources.phoneNumberIsInvalid,
                bgColor: ColorConstants.messageErrorBgColor,
              );
              return;
            }
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

class CountryCodeSelection {
  final String flagEmoji;
  final String countryCode;

  CountryCodeSelection({required this.flagEmoji, required this.countryCode});
}
