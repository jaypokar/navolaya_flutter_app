import 'package:flutter/material.dart';
import 'package:navolaya_flutter/core/route_generator.dart';

import '../../../../core/color_constants.dart';
import '../../../../core/string_file.dart';
import '../../../../injection_container.dart';
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
            Text(
              sl<StringFile>().passwordPageTitle,
              style:
                  const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 28),
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(width: 60, child: Divider(color: ColorConstants.appColor, thickness: 2)),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: Text(
                sl<StringFile>().passwordPageSubTitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
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
                    labelText: sl<StringFile>().passwordHint,
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
                buttonText: sl<StringFile>().submit.toUpperCase(),
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
                  text: TextSpan(
                    style: const TextStyle(
                        fontSize: 14.0, color: Colors.black, fontFamily: 'Montserrat'),
                    children: <TextSpan>[
                      TextSpan(text: sl<StringFile>().forgotPassword),
                      TextSpan(
                          text: sl<StringFile>().resetNow,
                          style: const TextStyle(
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
                    text: TextSpan(
                      style: const TextStyle(
                          fontSize: 14.0, color: Colors.black, fontFamily: 'Montserrat'),
                      children: <TextSpan>[
                        TextSpan(text: sl<StringFile>().changePhoneNumber),
                        TextSpan(
                            text: sl<StringFile>().goBack,
                            style: const TextStyle(
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
