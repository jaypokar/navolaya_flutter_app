import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navolaya_flutter/presentation/ui/registration/widget/password_input_widget.dart';

import '../../../injection_container.dart';
import '../../../resources/color_constants.dart';
import '../../../resources/string_resources.dart';
import '../../../util/common_functions.dart';
import '../../basicWidget/custom_button.dart';
import '../../basicWidget/loading_widget.dart';
import '../../bloc/profileBloc/profile_bloc.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final TextEditingController _oldPasswordTextController = TextEditingController();
  final TextEditingController _newPasswordTextController = TextEditingController();
  final TextEditingController _cfmPasswordTextController = TextEditingController();

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
        } else if (state is ChangePasswordState) {
          await sl<CommonFunctions>().showFlushBar(
            context: context,
            message: state.changePasswordResponse.message!,
            duration: 1,
          );
          if (!mounted) return;
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            StringResources.changePassword,
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              PasswordInputWidget(
                textEditingController: _oldPasswordTextController,
                showOrHidePassword: true,
                hint: StringResources.passwordOldHint,
              ),
              const SizedBox(
                height: 10,
              ),
              PasswordInputWidget(
                textEditingController: _newPasswordTextController,
                showOrHidePassword: true,
                hint: StringResources.passwordNewHint,
              ),
              const SizedBox(
                height: 10,
              ),
              PasswordInputWidget(
                textEditingController: _cfmPasswordTextController,
                showOrHidePassword: true,
                hint: StringResources.passwordCFMHint,
              ),
              const SizedBox(
                height: 10,
              ),
              buildButton()
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButton() {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (_, state) {
      if (state is ProfileLoadingState) {
        return const LoadingWidget();
      } else {
        return ButtonWidget(
          buttonText: StringResources.submit.toUpperCase(),
          onPressButton: () {
            if (_oldPasswordTextController.text.isEmpty) {
              sl<CommonFunctions>().showFlushBar(
                context: context,
                message: StringResources.pleaseEnterOldPassword,
                bgColor: ColorConstants.messageErrorBgColor,
              );
              return;
            } else if (_newPasswordTextController.text.isEmpty) {
              sl<CommonFunctions>().showFlushBar(
                context: context,
                message: StringResources.pleaseEnterNewPassword,
                bgColor: ColorConstants.messageErrorBgColor,
              );
              return;
            } else if (_cfmPasswordTextController.text.isEmpty) {
              sl<CommonFunctions>().showFlushBar(
                context: context,
                message: StringResources.pleaseEnterCFMPassword,
                bgColor: ColorConstants.messageErrorBgColor,
              );
              return;
            } else if (_cfmPasswordTextController.text != _newPasswordTextController.text) {
              sl<CommonFunctions>().showFlushBar(
                context: context,
                message: StringResources.passwordDidNotMatched,
                bgColor: ColorConstants.messageErrorBgColor,
              );
              return;
            } else {
              context.read<ProfileBloc>().add(ChangePasswordEvent(
                  oldPassword: _oldPasswordTextController.text,
                  newPassword: _newPasswordTextController.text));
            }
          },
        );
      }
    });
  }
}
