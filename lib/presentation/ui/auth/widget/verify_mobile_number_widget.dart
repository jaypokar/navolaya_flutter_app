import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navolaya_flutter/presentation/basicWidget/auth_rich_text_widget.dart';
import 'package:navolaya_flutter/presentation/basicWidget/otp_widget.dart';
import 'package:navolaya_flutter/presentation/cubit/otpTimerCubit/otptimer_cubit.dart';
import 'package:navolaya_flutter/resources/string_resources.dart';

import '../../../../injection_container.dart';
import '../../../../resources/color_constants.dart';
import '../../../../util/common_functions.dart';
import '../../../basicWidget/custom_button.dart';
import '../../../basicWidget/loading_widget.dart';
import '../../../bloc/authBloc/auth_bloc.dart';
import '../../../cubit/mobileVerificationCubit/mobile_verification_cubit.dart';

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

  final int timerMaxSeconds = 120;
  int currentSeconds = 0;
  Timer? _timer;

  String get timerText =>
      '${((timerMaxSeconds - currentSeconds) ~/ 60).toString().padLeft(2, '0')}: ${((timerMaxSeconds - currentSeconds) % 60).toString().padLeft(2, '0')}';

  @override
  void initState() {
    _startTimer();
    super.initState();
  }

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
              child: BlocBuilder<MobileVerificationCubit, String>(builder: (_, number) {
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
                BlocBuilder<OTPTimerCubit, int>(builder: (_, value) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AuthRichTextWidget(
                        onClickEvent: value >= timerMaxSeconds
                            ? () {
                                _startTimer();
                                widget.reSendOTP();
                              }
                            : null,
                        textOne: StringResources.receivedOTP,
                        textTwo: StringResources.resendOTP,
                        color: value >= timerMaxSeconds
                            ? ColorConstants.appColor
                            : ColorConstants.greyColor,
                      ),
                      const SizedBox(width: 5),
                      if (value < timerMaxSeconds) ...[Text(timerText)]
                    ],
                  );
                }),
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

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      currentSeconds = timer.tick;
      context.read<OTPTimerCubit>().timerTick(timer.tick);
      if (timer.tick >= timerMaxSeconds) {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _textController1.dispose();
    _textController2.dispose();
    _textController3.dispose();
    _textController4.dispose();
    if (_timer != null) {
      _timer!.cancel();
    }
    super.dispose();
  }
}
