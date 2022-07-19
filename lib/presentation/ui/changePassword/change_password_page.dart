import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navolaya_flutter/presentation/ui/registration/widget/password_input_widget.dart';

import '../../../injection_container.dart';
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
      listener: (_, state) {
        if (state is ProfileErrorState) {
          sl<CommonFunctions>().showSnackBar(
              context: context,
              message: state.message,
              bgColor: Colors.red,
              textColor: Colors.white);
        } else if (state is ChangePasswordState) {
          sl<CommonFunctions>().showSnackBar(
              context: context,
              message: state.changePasswordResponse.message!,
              bgColor: Colors.green,
              textColor: Colors.white);
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
                showOrHidePassword: false,
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
                showOrHidePassword: false,
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
              sl<CommonFunctions>().showSnackBar(
                  context: context,
                  message: StringResources.pleaseEnterOldPassword,
                  bgColor: Colors.orange,
                  textColor: Colors.white);
              return;
            } else if (_newPasswordTextController.text.isEmpty) {
              sl<CommonFunctions>().showSnackBar(
                  context: context,
                  message: StringResources.pleaseEnterNewPassword,
                  bgColor: Colors.orange,
                  textColor: Colors.white);
              return;
            } else if (_cfmPasswordTextController.text.isEmpty) {
              sl<CommonFunctions>().showSnackBar(
                  context: context,
                  message: StringResources.pleaseEnterCFMPassword,
                  bgColor: Colors.orange,
                  textColor: Colors.white);
              return;
            } else if (_cfmPasswordTextController.text != _newPasswordTextController.text) {
              sl<CommonFunctions>().showSnackBar(
                  context: context,
                  message: StringResources.passwordDidNotMatched,
                  bgColor: Colors.orange,
                  textColor: Colors.white);
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
