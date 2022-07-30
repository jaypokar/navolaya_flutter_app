import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navolaya_flutter/presentation/basicWidget/text_field_widget.dart';

import '../../../../data/sessionManager/session_manager.dart';
import '../../../../injection_container.dart';
import '../../../../resources/color_constants.dart';
import '../../../../resources/string_resources.dart';
import '../../../../util/common_functions.dart';
import '../../../basicWidget/custom_button.dart';
import '../../../basicWidget/loading_widget.dart';
import '../../../bloc/profileBloc/profile_bloc.dart';

class UpdateEmailWidget extends StatefulWidget {
  final Function sendOTPViaEmail;

  const UpdateEmailWidget({required this.sendOTPViaEmail, Key? key}) : super(key: key);

  @override
  State<UpdateEmailWidget> createState() => _UpdateEmailWidgetState();
}

class _UpdateEmailWidgetState extends State<UpdateEmailWidget> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
            ),
            Text(
              'Dear ${sl<SessionManager>().getUserDetails()!.data!.fullName}',
              style: const TextStyle(
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
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: Text(
                StringResources.emailPageSubtitle,
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
            TextFieldWidget(
              controller: _textController,
              hint: 'Enter email address',
              textInputType: TextInputType.emailAddress,
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
              sl<CommonFunctions>().showSnackBar(
                  context: context,
                  message: StringResources.phoneNumberHint,
                  bgColor: Colors.orange,
                  textColor: Colors.white);
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
