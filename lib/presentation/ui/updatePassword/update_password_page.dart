import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navolaya_flutter/presentation/basicWidget/auth_rich_text_widget.dart';
import 'package:navolaya_flutter/presentation/basicWidget/otp_widget.dart';

import '../../../injection_container.dart';
import '../../../resources/color_constants.dart';
import '../../../resources/string_resources.dart';
import '../../../util/common_functions.dart';
import '../../basicWidget/custom_button.dart';
import '../../basicWidget/loading_widget.dart';
import '../../bloc/authBloc/auth_bloc.dart';
import '../../cubit/otpTimerCubit/otptimer_cubit.dart';
import '../registration/widget/password_input_widget.dart';

class UpdatePasswordPage extends StatefulWidget {
  final String countryCode;
  final String mobileNumber;

  const UpdatePasswordPage({
    required this.countryCode,
    required this.mobileNumber,
    Key? key,
  }) : super(key: key);

  @override
  State<UpdatePasswordPage> createState() => _UpdatePasswordPageState();
}

class _UpdatePasswordPageState extends State<UpdatePasswordPage> {
  final TextEditingController _textController1 = TextEditingController();
  final TextEditingController _textController2 = TextEditingController();
  final TextEditingController _textController3 = TextEditingController();
  final TextEditingController _textController4 = TextEditingController();
  final TextEditingController _newPassController = TextEditingController();

  late final String _updatePasswordSubTitleHint;
  final int timerMaxSeconds = 120;
  int currentSeconds = 0;
  Timer? _timer;
  double _screenHeight = 0.0;

  String get timerText =>
      '${((timerMaxSeconds - currentSeconds) ~/ 60).toString().padLeft(2, '0')}: ${((timerMaxSeconds - currentSeconds) % 60).toString().padLeft(2, '0')}';

  @override
  void initState() {
    super.initState();
    _updatePasswordSubTitleHint = StringResources.updatePasswordSubTitle
        .replaceAll("{number}", '${widget.countryCode}-${widget.mobileNumber}');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _screenHeight = MediaQuery.of(context).size.height * 0.10;
    reSendOTP();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthErrorState) {
          sl<CommonFunctions>().showSnackBar(
              context: context,
              message: state.message,
              bgColor: Colors.red,
              textColor: Colors.white);
        } else if (state is UpdateForgotPasswordState) {
          if (mounted) {
            sl<CommonFunctions>().showSnackBar(
                context: context,
                message: state.updateForgotPasswordData.message!,
                bgColor: Colors.green,
                textColor: Colors.white);
          }
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            StringResources.updatePassword,
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: _screenHeight,
                ),
                const Text(
                  StringResources.newPassword,
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
                  child: Text(
                    _updatePasswordSubTitleHint,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        height: 1.8,
                        color: ColorConstants.textColor1,
                        fontWeight: FontWeight.w400,
                        fontSize: 14),
                  ),
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
                PasswordInputWidget(
                  textEditingController: _newPassController,
                  showOrHidePassword: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                buildButton(),
                SizedBox(
                  height: _screenHeight * 0.95,
                ),
                BlocBuilder<OTPTimerCubit, int>(builder: (_, value) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AuthRichTextWidget(
                        onClickEvent: () => value >= timerMaxSeconds ? reSendOTP() : null,
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
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
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
            } else if (_newPassController.text.isEmpty) {
              sl<CommonFunctions>().showSnackBar(
                  context: context,
                  message: StringResources.pleaseEnterPassword,
                  bgColor: Colors.orange,
                  textColor: Colors.white);
            } else {
              updatePassword();
            }
          },
        );
      }
    });
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

  void reSendOTP() {
    _startTimer();
    context.read<AuthBloc>().add(
          InitiateSendOtpEvent(
            countryCode: widget.countryCode,
            phone: widget.mobileNumber,
            otpFor: 'forgot_password',
          ),
        );
  }

  void updatePassword() {
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
    } else if (_newPassController.text.isEmpty) {
      sl<CommonFunctions>().showSnackBar(
          context: context,
          message: StringResources.pleaseEnterPassword,
          bgColor: Colors.orange,
          textColor: Colors.white);
    } else {
      final otp = _textController1.text +
          _textController2.text +
          _textController3.text +
          _textController4.text;
      context.read<AuthBloc>().add(
            InitiateUpdateForgotPasswordEvent(
              countryCode: widget.countryCode,
              phone: widget.mobileNumber,
              otpNumber: otp,
              newPassword: _newPassController.text,
            ),
          );
    }
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer!.cancel();
    }
    super.dispose();
  }
}
