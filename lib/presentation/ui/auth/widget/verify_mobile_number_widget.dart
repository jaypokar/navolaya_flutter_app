import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navolaya_flutter/presentation/basicWidget/auth_rich_text_widget.dart';
import 'package:navolaya_flutter/presentation/basicWidget/otp_widget.dart';
import 'package:navolaya_flutter/presentation/uiNotifiers/ui_notifiers.dart';
import 'package:navolaya_flutter/resources/string_resources.dart';

import '../../../../core/color_constants.dart';
import '../../../../injection_container.dart';
import '../../../../util/common_functions.dart';
import '../../../basicWidget/custom_button.dart';
import '../../../basicWidget/loading_widget.dart';
import '../../../bloc/authBloc/auth_bloc.dart';

class VerifyMobileNumberWidget extends StatefulWidget {
  final PageController pageController;
  final double screenHeight;
  final Function verifyOTP;
  final Function reSendOTP;
  final String mobileNumber;

  const VerifyMobileNumberWidget(
      {required this.pageController,
      required this.screenHeight,
      required this.verifyOTP,
      required this.reSendOTP,
      required this.mobileNumber,
      Key? key})
      : super(key: key);

  @override
  State<VerifyMobileNumberWidget> createState() => _VerifyMobileNumberWidgetState();
}

class _VerifyMobileNumberWidgetState extends State<VerifyMobileNumberWidget> {
  final TextEditingController _textController1 = TextEditingController();
  final TextEditingController _textController2 = TextEditingController();
  final TextEditingController _textController3 = TextEditingController();
  final TextEditingController _textController4 = TextEditingController();

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
              StringResources.verificationPageTitle,
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: ValueListenableBuilder<String>(
                  valueListenable: sl<UiNotifiers>().mobileVerificationTitleNotifier,
                  builder: (_, number, __) {
                    final verificationSubTitleHint =
                        StringResources.verificationPageSubTitle.replaceAll("{number}", number);
                    return Text(
                      verificationSubTitleHint,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          height: 1.8,
                          color: ColorConstants.textColor1,
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                    );
                  }),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OtpWidget(textEditingController: _textController1),
                OtpWidget(textEditingController: _textController2),
                OtpWidget(textEditingController: _textController3),
                OtpWidget(textEditingController: _textController4),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            BlocBuilder<AuthBloc, AuthState>(builder: (_, state) {
              if (state is AuthLoadingState) {
                return const LoadingWidget();
              } else {
                return ButtonWidget(
                  buttonText: StringResources.verify.toUpperCase(),
                  onPressButton: () {
                    if (_textController1.text.isEmpty ||
                        _textController2.text.isEmpty ||
                        _textController3.text.isEmpty ||
                        _textController4.text.isEmpty) {
                      sl<CommonFunctions>().showSnackBar(
                          context: context,
                          message: StringResources.pleaseEnterOTP,
                          bgColor: Colors.orange,
                          textColor: Colors.white);
                      return;
                    }

                    widget.verifyOTP(_textController1.text +
                        _textController2.text +
                        _textController3.text +
                        _textController4.text);
                  },
                );
              }
            }),
            SizedBox(
              height: widget.screenHeight + 20,
            ),
            Column(
              children: [
                AuthRichTextWidget(
                  onClickEvent: () => widget.reSendOTP(),
                  textOne: StringResources.receivedOTP,
                  textTwo: StringResources.resendOTP,
                ),
                const SizedBox(height: 10),
                AuthRichTextWidget(
                  onClickEvent: () => widget.pageController.jumpToPage(0),
                  textOne: StringResources.changePhoneNumber,
                  textTwo: StringResources.goBack,
                )
              ],
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textController1.dispose();
    super.dispose();
  }
}
