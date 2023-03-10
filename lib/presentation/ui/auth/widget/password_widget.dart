import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navolaya_flutter/presentation/ui/registration/widget/password_input_widget.dart';

import '../../../../injection_container.dart';
import '../../../../resources/color_constants.dart';
import '../../../../resources/string_resources.dart';
import '../../../../util/common_functions.dart';
import '../../../basicWidget/auth_rich_text_widget.dart';
import '../../../basicWidget/custom_button.dart';
import '../../../basicWidget/loading_widget.dart';
import '../../../bloc/authBloc/auth_bloc.dart';
import '../../../cubit/keyboardVisibilityCubit/key_board_visibility_cubit.dart';

class SetNewPasswordWidget extends StatefulWidget {
  final double screenHeight;
  final PageController pageController;
  final Function login;
  final Function navigateToUpdatePassword;

  const SetNewPasswordWidget({
    required this.pageController,
    required this.screenHeight,
    required this.login,
    required this.navigateToUpdatePassword,
    Key? key,
  }) : super(key: key);

  @override
  State<SetNewPasswordWidget> createState() => _SetNewPasswordWidgetState();
}

class _SetNewPasswordWidgetState extends State<SetNewPasswordWidget> {
  final TextEditingController _newPassController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

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
                StringResources.passwordPageTitle,
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 28),
              ),
              const SizedBox(
                height: 10,
              ),
              const SizedBox(
                  width: 60, child: Divider(color: ColorConstants.appColor, thickness: 2)),
              const SizedBox(
                height: 10,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: Text(
                  StringResources.passwordPageSubTitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ColorConstants.textColor1,
                    height: 1.8,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: PasswordInputWidget(
                  textEditingController: _newPassController,
                  showOrHidePassword: true,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              BlocBuilder<AuthBloc, AuthState>(builder: (_, state) {
                if (state is AuthLoadingState) {
                  return const LoadingWidget();
                } else {
                  return ButtonWidget(
                    buttonText: StringResources.submit.toUpperCase(),
                    onPressButton: () {
                      if (_newPassController.text.isEmpty) {
                        sl<CommonFunctions>().showFlushBar(
                          context: context,
                          message: StringResources.pleaseEnterPassword,
                          bgColor: ColorConstants.messageErrorBgColor,
                        );
                        return;
                      }
                      widget.login(_newPassController.text);
                    },
                  );
                }
              }),
              SizedBox(
                height: widget.screenHeight + 5,
              ),
              Column(
                children: [
                  AuthRichTextWidget(
                    onClickEvent: () => widget.navigateToUpdatePassword(),
                    textOne: StringResources.forgotPassword,
                    textTwo: StringResources.resetNow,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  AuthRichTextWidget(
                    onClickEvent: () => widget.pageController.jumpToPage(0),
                    textOne: StringResources.changePhoneNumber,
                    textTwo: StringResources.goBack,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
