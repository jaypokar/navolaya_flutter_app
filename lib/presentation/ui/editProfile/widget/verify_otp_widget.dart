import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navolaya_flutter/presentation/bloc/profileBloc/profile_bloc.dart';
import 'package:navolaya_flutter/presentation/cubit/mobileVerificationCubit/mobile_verification_cubit.dart';

import '../../../../injection_container.dart';
import '../../../../resources/color_constants.dart';
import '../../../../resources/string_resources.dart';
import '../../../../util/common_functions.dart';
import '../../../basicWidget/auth_rich_text_widget.dart';
import '../../../basicWidget/custom_button.dart';
import '../../../basicWidget/loading_widget.dart';
import '../../../basicWidget/otp_widget.dart';
import '../../../cubit/keyboardVisibilityCubit/key_board_visibility_cubit.dart';
import '../../../cubit/otpTimerCubit/otpTimer_cubit.dart';

class VerifyOTPWidget extends StatefulWidget {
  final bool isEmail;
  final PageController pageController;
  final ValueNotifier<String> titleChangeNotifier;
  final Function updatePhoneOrEmail;
  final Function reSendOTP;

  const VerifyOTPWidget({
    required this.isEmail,
    required this.reSendOTP,
    required this.pageController,
    required this.titleChangeNotifier,
    required this.updatePhoneOrEmail,
    Key? key,
  }) : super(
          key: key,
        );

  @override
  State<VerifyOTPWidget> createState() => _VerifyOTPWidgetState();
}

class _VerifyOTPWidgetState extends State<VerifyOTPWidget> {
  final TextEditingController _textController1 = TextEditingController();
  final TextEditingController _textController2 = TextEditingController();
  final TextEditingController _textController3 = TextEditingController();
  final TextEditingController _textController4 = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final FocusNode textController1FocusNode = FocusNode();
  final FocusNode textController2FocusNode = FocusNode();
  final FocusNode textController3FocusNode = FocusNode();
  final FocusNode textController4FocusNode = FocusNode();

  final int timerMaxSeconds = 120;
  int currentSeconds = 0;
  Timer? _timer;

  String get timerText =>
      '${((timerMaxSeconds - currentSeconds) ~/ 60).toString().padLeft(2, '0')}: ${((timerMaxSeconds - currentSeconds) % 60).toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
        listeners: [
          BlocListener<ProfileBloc, ProfileState>(listener: (_, state) {
            if (state is ProfileErrorState) {
              textController1FocusNode.requestFocus();
            }
          }),
          BlocListener<KeyBoardVisibilityCubit, bool>(
            listener: (_, isVisible) => sl<CommonFunctions>().animateWidgetWhenKeyboardOpens(
              scrollController: _scrollController,
              isKeyBoardVisible: isVisible,
            ),
          )
        ],
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.2,
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
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: BlocBuilder<MobileVerificationCubit, String>(builder: (_, emailOrNumber) {
                    _startTimer();
                    final verificationSubTitleHint = widget.isEmail
                        ? StringResources.verificationPageEmailSubTitle
                            .replaceAll("{email}", emailOrNumber)
                        : StringResources.verificationPageMobileSubTitle
                            .replaceAll("{number}", emailOrNumber);
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
                    OtpWidget(
                      textEditingController: _textController1,
                      textControllerFocusNode: textController1FocusNode,
                    ),
                    OtpWidget(
                        textEditingController: _textController2,
                        textControllerFocusNode: textController2FocusNode),
                    OtpWidget(
                        textEditingController: _textController3,
                        textControllerFocusNode: textController3FocusNode),
                    OtpWidget(
                        textEditingController: _textController4,
                        textControllerFocusNode: textController4FocusNode),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                BlocBuilder<ProfileBloc, ProfileState>(builder: (_, state) {
                  if (state is ProfileLoadingState) {
                    return const LoadingWidget();
                  } else {
                    return ButtonWidget(
                      buttonText: StringResources.verify.toUpperCase(),
                      onPressButton: () {
                        if (_textController1.text.isEmpty ||
                            _textController2.text.isEmpty ||
                            _textController3.text.isEmpty ||
                            _textController4.text.isEmpty) {
                          sl<CommonFunctions>().showFlushBar(
                            context: context,
                            message: StringResources.pleaseEnterOTP,
                            bgColor: ColorConstants.messageErrorBgColor,
                          );
                          return;
                        }
                        widget.updatePhoneOrEmail(_textController1.text +
                            _textController2.text +
                            _textController3.text +
                            _textController4.text);
                      },
                    );
                  }
                }),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
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
                      onClickEvent: () {
                        if (widget.isEmail) {
                          widget.titleChangeNotifier.value = StringResources.updateEmail;
                        } else {
                          widget.titleChangeNotifier.value = StringResources.updatePhone;
                        }
                        widget.pageController.jumpToPage(0);
                      },
                      textOne: widget.isEmail
                          ? StringResources.changeEmail
                          : StringResources.changePhoneNumber,
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
        ));
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      currentSeconds = timer.tick;
      if (!mounted) return;
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
