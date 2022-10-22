import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navolaya_flutter/injection_container.dart';
import 'package:navolaya_flutter/presentation/bloc/profileBloc/profile_bloc.dart';
import 'package:navolaya_flutter/presentation/ui/editProfile/widget/update_email_widget.dart';
import 'package:navolaya_flutter/presentation/ui/editProfile/widget/update_phone_widget.dart';
import 'package:navolaya_flutter/presentation/ui/editProfile/widget/verify_otp_widget.dart';
import 'package:navolaya_flutter/util/common_functions.dart';

import '../../../resources/color_constants.dart';
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
  late final ValueNotifier<String> _titleChangeNotifier;

  String _countryCode = '';
  String _number = '';
  String _email = '';

  @override
  void initState() {
    super.initState();
    _titleChangeNotifier =
        ValueNotifier(widget.isEmail ? StringResources.updateEmail : StringResources.updatePhone);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileBloc, ProfileState>(
      listener: (_, state) async {
        if (state is ProfileErrorState) {
          sl<CommonFunctions>().showFlushBar(
            context: context,
            message: state.message,
            bgColor: ColorConstants.messageErrorBgColor,
          );
        } else if (state is LoadUpdateOTPState) {
          /*  sl<CommonFunctions>().showFlushBar(
            context: context,
            message: state.updateSendOtpResponse.message!,
          );*/
          _controller.jumpToPage(1);
          _titleChangeNotifier.value = StringResources.verificationPageTitle;
          context
              .read<MobileVerificationCubit>()
              .changeNumber(widget.isEmail ? _email : '$_countryCode-$_number');
        } else if (state is LoadUpdateEmailState) {
          await sl<CommonFunctions>().showFlushBar(
              context: context, message: state.updateEmailResponse.message!, duration: 1);
          if (!mounted) return;
          Navigator.of(context).pop();
        } else if (state is LoadUpdatePhoneState) {
          await sl<CommonFunctions>().showFlushBar(
              context: context, message: state.updatePhoneResponse.message!, duration: 1);
          if (!mounted) return;
          Navigator.of(context).pop();
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
          physics: const NeverScrollableScrollPhysics(),
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
