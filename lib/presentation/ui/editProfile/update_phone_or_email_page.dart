import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navolaya_flutter/injection_container.dart';
import 'package:navolaya_flutter/presentation/bloc/profileBloc/profile_bloc.dart';
import 'package:navolaya_flutter/presentation/ui/editProfile/widget/update_email_widget.dart';
import 'package:navolaya_flutter/presentation/ui/editProfile/widget/update_phone_widget.dart';
import 'package:navolaya_flutter/presentation/ui/editProfile/widget/verify_otp_widget.dart';
import 'package:navolaya_flutter/util/common_functions.dart';

import '../../../resources/string_resources.dart';
import '../../cubit/mobileVerificationCubit/mobile_verification_cubit.dart';

class UpdatePhoneOrEmailPage extends StatefulWidget {
  final bool isEmail;

  const UpdatePhoneOrEmailPage({required this.isEmail, Key? key}) : super(key: key);

  @override
  State<UpdatePhoneOrEmailPage> createState() => _UpdatePhoneOrEmailPageState();
}

class _UpdatePhoneOrEmailPageState extends State<UpdatePhoneOrEmailPage> {
  final PageController _controller = PageController();
  final ValueNotifier<String> _titleChangeNotifier = ValueNotifier(StringResources.updatePhone);

  String _countryCode = '';
  String _number = '';
  String _email = '';

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (_, state) {
        if (state is ProfileErrorState) {
          sl<CommonFunctions>().showSnackBar(
            context: context,
            message: state.message,
            bgColor: Colors.red,
            textColor: Colors.white,
          );
        } else if (state is LoadUpdateOTPState) {
          sl<CommonFunctions>().showSnackBar(
            context: context,
            message: state.updateSendOtpResponse.message!,
            bgColor: Colors.green,
            textColor: Colors.white,
          );
          _controller.jumpToPage(1);
          _titleChangeNotifier.value = StringResources.verificationPageTitle;
          if (!widget.isEmail) {
            context.read<MobileVerificationCubit>().changeNumber(_countryCode + _number);
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: ValueListenableBuilder<String>(
            valueListenable: _titleChangeNotifier,
            builder: (_, title, __) {
              return Text(
                title,
                style: const TextStyle(color: Colors.white),
              );
            },
          ),
        ),
        body: PageView(
          controller: _controller,
          /*physics: const NeverScrollableScrollPhysics(),*/
          children: [
            if (widget.isEmail) ...[
              UpdateEmailWidget(sendOTPViaEmail: sendOTPViaEmail),
            ] else ...[
              UpdatePhoneWidget(
                onUpdateClick: sendOTP,
              )
            ],
            VerifyOTPWidget(
                isEmail: widget.isEmail,
                reSendOTP: reSendOTP,
                pageController: _controller,
                titleChangeNotifier: _titleChangeNotifier,
                updatePhoneOrEmail: updatePhoneOrEmail)
          ],
        ),
      ),
    );
  }

  void sendOTP(String countryCode, String number) {
    _countryCode = countryCode;
    _number = number;
    reSendOTP();
  }

  void reSendOTP() {
    context.read<ProfileBloc>().add(
          SendOTPEvent(countryCode: _countryCode, email: '', mobileNumber: _number),
        );
  }

  void sendOTPViaEmail(String email) {
    _email = email;
    context.read<ProfileBloc>().add(
          SendOTPEvent(countryCode: '', email: _email, mobileNumber: ''),
        );
  }

  void updatePhoneOrEmail(String otp) {
    if (widget.isEmail) {
      context.read<ProfileBloc>().add(UpdateEmailEvent(
            email: _email,
            otpNumber: otp,
          ));
    } else {
      context.read<ProfileBloc>().add(UpdatePhoneEvent(
            countryCode: _countryCode,
            mobileNumber: _number,
            otpNumber: otp,
          ));
    }
  }

  void updateEmail(String otp) {}

  @override
  void dispose() {
    _titleChangeNotifier.dispose();
    super.dispose();
  }
}
