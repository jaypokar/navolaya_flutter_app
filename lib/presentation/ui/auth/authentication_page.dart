import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navolaya_flutter/core/color_constants.dart';
import 'package:navolaya_flutter/core/route_generator.dart';
import 'package:navolaya_flutter/presentation/bloc/authBloc/auth_bloc.dart';
import 'package:navolaya_flutter/presentation/cubit/mobileVerificationCubit/mobile_verification_cubit.dart';
import 'package:navolaya_flutter/resources/value_key_resources.dart';

import '../../../injection_container.dart';
import '../../../resources/image_resources.dart';
import '../../../util/common_functions.dart';
import 'widget/mobile_number_widget.dart';
import 'widget/password_widget.dart';
import 'widget/verify_mobile_number_widget.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  final PageController _controller = PageController();
  double _screenHeight = 0.0;
  bool _isUserRegistered = false;
  String _countryCode = '+91';
  String _mobileNumber = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _screenHeight = MediaQuery.of(context).size.height * 0.10;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (BuildContext blocContext, state) {
        if (state is AuthErrorState) {
          showMessage(true, state.message);
        } else if (state is ValidatePhoneState) {
          showMessage(false, state.validatePhoneData.message!);
          _isUserRegistered = state.validatePhoneData.data!.isUserAccountVerified == 1;
          context.read<MobileVerificationCubit>().changeNumber(_mobileNumber);
          _controller.jumpToPage(_isUserRegistered ? 2 : 1);
        } else if (state is VerifyOtpState) {
          showMessage(false, state.verifyOtpData.message!);
          _isUserRegistered
              ? _controller.jumpToPage(2)
              : Navigator.of(context).pushReplacementNamed(RouteGenerator.registrationPage,
                  arguments: {
                      ValueKeyResources.mobileNumberKey: _mobileNumber,
                      ValueKeyResources.countryCodeKey: _countryCode
                    });
        } else if (state is SendOtpState) {
          showMessage(false, state.sendOtpData.message!);
        } else if (state is LoginState) {
          Navigator.of(context).pushReplacementNamed(RouteGenerator.dashBoardPage);
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                image: const DecorationImage(
                    image: AssetImage(ImageResources.imgBg), fit: BoxFit.cover),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 40,
                ),
                child: Image(
                  image: AssetImage(ImageResources.textLogo),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            Expanded(
              child: PageView(
                controller: _controller,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  MobileNumberWidget(
                    pageController: _controller,
                    screenHeight: _screenHeight,
                    validatePhone: validatePhone,
                  ),
                  VerifyMobileNumberWidget(
                    pageController: _controller,
                    screenHeight: _screenHeight,
                    verifyOTP: verifyPhone,
                    reSendOTP: reSendOTP,
                    mobileNumber: _mobileNumber,
                  ),
                  SetNewPasswordWidget(
                    screenHeight: _screenHeight,
                    pageController: _controller,
                    login: login,
                    navigateToUpdatePassword: navigateToUpdatePassword,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void validatePhone(String countryCode, String mobileNumber) {
    _countryCode = countryCode;
    _mobileNumber = mobileNumber;
    context.read<AuthBloc>().add(InitiateValidatePhoneEvent(
          countryCode: _countryCode,
          phone: _mobileNumber,
        ));
  }

  void verifyPhone(String otp) {
    context.read<AuthBloc>().add(
          InitiateVerifyOtpEvent(
            countryCode: _countryCode,
            phone: _mobileNumber,
            otpNumber: otp,
          ),
        );
  }

  void reSendOTP() {
    context.read<AuthBloc>().add(
          InitiateSendOtpEvent(
            countryCode: _countryCode,
            phone: _mobileNumber,
            otpFor: 'register',
          ),
        );
  }

  void login(String password) {
    context.read<AuthBloc>().add(
          InitiateLoginEvent(
            countryCode: _countryCode,
            phone: _mobileNumber,
            password: password,
          ),
        );
  }

  void navigateToUpdatePassword() {
    Navigator.of(context).pushNamed(
      RouteGenerator.updatePasswordPage,
      arguments: {
        ValueKeyResources.countryCodeKey: _countryCode,
        ValueKeyResources.mobileNumberKey: _mobileNumber,
      },
    );
  }

  void showMessage(bool isError, String message) {
    sl<CommonFunctions>().showSnackBar(
      context: context,
      message: message,
      bgColor: isError ? Colors.red : ColorConstants.appColor,
      textColor: Colors.white,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
