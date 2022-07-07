import 'package:flutter/material.dart';
import 'package:navolaya_flutter/core/route_generator.dart';

import '../../../../core/color_constants.dart';
import '../../../../resources/string_resources.dart';
import '../../../basicWidget/custom_button.dart';

class SetNewPasswordWidget extends StatefulWidget {
  final double screenHeight;
  final PageController pageController;

  const SetNewPasswordWidget({required this.pageController, required this.screenHeight, Key? key})
      : super(key: key);

  @override
  State<SetNewPasswordWidget> createState() => _SetNewPasswordWidgetState();
}

class _SetNewPasswordWidgetState extends State<SetNewPasswordWidget> {
  final TextEditingController _newPassController = TextEditingController();
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
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
            const SizedBox(width: 60, child: Divider(color: ColorConstants.appColor, thickness: 2)),
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
            Container(
              height: 40,
              margin: const EdgeInsets.all(10),
              child: TextField(
                controller: _newPassController,
                obscureText: _isObscure,
                keyboardType: TextInputType.text,
                style: const TextStyle(
                  fontSize: 14,
                ),
                decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                    labelText: StringResources.passwordHint,
                    counterText: "",
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                        icon: const Icon(Icons.remove_red_eye))),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ButtonWidget(
                buttonText: StringResources.submit.toUpperCase(),
                onPressButton: () {
                  //widget.pageController.jumpToPage(1);
                  Navigator.pushReplacementNamed(context, RouteGenerator.registrationPage);
                }),
            SizedBox(
              height: widget.screenHeight + 20,
            ),
            Column(
              children: [
                RichText(
                  text: const TextSpan(
                    style: TextStyle(fontSize: 14.0, color: Colors.black, fontFamily: 'Montserrat'),
                    children: <TextSpan>[
                      TextSpan(text: StringResources.forgotPassword),
                      TextSpan(
                          text: StringResources.resetNow,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: ColorConstants.appColor)),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {
                    widget.pageController.jumpToPage(0);
                  },
                  child: RichText(
                    text: const TextSpan(
                      style:
                          TextStyle(fontSize: 14.0, color: Colors.black, fontFamily: 'Montserrat'),
                      children: <TextSpan>[
                        TextSpan(text: StringResources.changePhoneNumber),
                        TextSpan(
                            text: StringResources.goBack,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: ColorConstants.appColor)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ),
    );
  }
}
