import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navolaya_flutter/presentation/basicWidget/text_field_widget.dart';

import '../../../../injection_container.dart';
import '../../../../resources/color_constants.dart';
import '../../../../resources/string_resources.dart';
import '../../../../util/common_functions.dart';
import '../../../basicWidget/custom_button.dart';
import '../../../basicWidget/loading_widget.dart';
import '../../../bloc/profileBloc/profile_bloc.dart';
import '../../../cubit/keyboardVisibilityCubit/key_board_visibility_cubit.dart';

class UpdateEmailWidget extends StatefulWidget {
  final Function sendOTPViaEmail;

  const UpdateEmailWidget({required this.sendOTPViaEmail, Key? key}) : super(key: key);

  @override
  State<UpdateEmailWidget> createState() => _UpdateEmailWidgetState();
}

class _UpdateEmailWidgetState extends State<UpdateEmailWidget> {
  final TextEditingController _textController = TextEditingController();
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
                height: MediaQuery.of(context).size.height * 0.2,
              ),
              const Text(
                StringResources
                    .updateEmail /*'Dear ${sl<SessionManager>().getUserDetails()!.data!.fullName}'*/,
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
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Text(
                  StringResources.updateEmailPageSubtitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      height: 1.8,
                      color: ColorConstants.textColor1,
                      fontWeight: FontWeight.w400,
                      fontSize: 14),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextFieldWidget(
                  controller: _textController,
                  hint: 'Enter email address',
                  textInputType: TextInputType.emailAddress,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              buildButton(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
              ),
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
          buttonText: StringResources.continueText.toUpperCase(),
          onPressButton: () {
            if (_textController.text.isEmpty) {
              sl<CommonFunctions>().showFlushBar(
                context: context,
                message: StringResources.phoneNumberHint,
                bgColor: ColorConstants.messageErrorBgColor,
              );
              return;
            }
            widget.sendOTPViaEmail(_textController.text);
          },
        );
      }
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
}
