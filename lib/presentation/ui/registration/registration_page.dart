import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/color_constants.dart';
import '../../../injection_container.dart';
import '../../../resources/image_resources.dart';
import '../../../util/common_functions.dart';
import '../../bloc/authBloc/auth_bloc.dart';
import '../../uiNotifiers/ui_notifiers.dart';
import 'widget/additional_info_widget.dart';
import 'widget/basic_info_widget.dart';
import 'widget/step_indicator_widget.dart';

class RegistrationPage extends StatefulWidget {
  final String countryCode;
  final String mobileNumber;

  const RegistrationPage({required this.mobileNumber, required this.countryCode, Key? key})
      : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final PageController _controller = PageController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (BuildContext blocContext, state) {
        if (state is AuthErrorState) {
          showMessage(true, state.message);
        } else if (state is UpdateBasicInfoState) {
          showMessage(false, state.loginAndBasicInfoData.message!);
          _controller.jumpToPage(1);
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(
              height: 60,
            ),
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                    image: AssetImage(
                      ImageResources.imgBg,
                    ),
                    fit: BoxFit.cover),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                ),
                child: Image.asset(
                  ImageResources.textLogo,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Stack(
              alignment: Alignment.center,
              children: const [
                Center(
                    child: SizedBox(
                        width: 50,
                        child: Divider(
                          color: ColorConstants.greyColor,
                          thickness: 5,
                        ))),
                StepIndicatorWidget(),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              flex: 7,
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (int page) {
                  sl<UiNotifiers>().stepsIndicatorNotifier.value = page;
                },
                controller: _controller,
                children: [
                  BasicInfoWidget(
                    countryCode: widget.countryCode,
                    mobileNumber: widget.mobileNumber,
                  ),
                  const AdditionalInfoWidget()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showMessage(bool isError, String message) {
    if (mounted) {
      sl<CommonFunctions>().showSnackBar(
        context: context,
        message: message,
        bgColor: isError ? Colors.red : ColorConstants.appColor,
        textColor: Colors.white,
      );
    }
  }

  @override
  void dispose() {
    sl<UiNotifiers>().stepsIndicatorNotifier.dispose();
    super.dispose();
  }
}
