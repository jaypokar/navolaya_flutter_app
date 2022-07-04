import 'package:flutter/material.dart';
import 'package:navolaya_flutter/core/string_file.dart';

import '../../../../core/color_constants.dart';
import '../../../../injection_container.dart';
import '../../../basicWidget/custom_button.dart';

class VerifyMobileNumberWidget extends StatefulWidget {
  final PageController pageController;
  final TextEditingController mobileTextController;
  final double screenHeight;

  const VerifyMobileNumberWidget(
      {required this.pageController,
      required this.mobileTextController,
      required this.screenHeight,
      Key? key})
      : super(key: key);

  @override
  State<VerifyMobileNumberWidget> createState() => _VerifyMobileNumberWidgetState();
}

class _VerifyMobileNumberWidgetState extends State<VerifyMobileNumberWidget> {
  final TextEditingController _textController1 = TextEditingController();
  final TextEditingController _textController2 = TextEditingController();
  final TextEditingController _textController3 = TextEditingController();
  final TextEditingController _textController4 = TextEditingController();

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
              sl<StringFile>().verificationPageTitle,
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: Text(
                sl<StringFile>().verificationPageSubTitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    height: 1.8,
                    color: ColorConstants.textColor1,
                    fontWeight: FontWeight.w400,
                    fontSize: 14),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 50,
                  width: 50,
                  margin: const EdgeInsets.all(5),
                  child: TextField(
                    controller: _textController1,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    textAlign: TextAlign.center,
                    onChanged: (_) {
                      FocusScope.of(context).nextFocus();
                    },
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                      isDense: true,
                      counterText: '',
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: 50,
                  margin: const EdgeInsets.all(5),
                  child: TextField(
                    controller: _textController2,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    onChanged: (_) {
                      FocusScope.of(context).nextFocus();
                    },
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                      isDense: true,
                      counterText: '',
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: 50,
                  margin: const EdgeInsets.all(5),
                  child: TextField(
                    controller: _textController3,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    onChanged: (_) {
                      FocusScope.of(context).nextFocus();
                    },
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                      isDense: true,
                      counterText: '',
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: 50,
                  margin: const EdgeInsets.all(5),
                  child: TextField(
                    controller: _textController4,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    onChanged: (_) {
                      FocusScope.of(context).nextFocus();
                    },
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
                      isDense: true,
                      counterText: '',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            ButtonWidget(
                buttonText: sl<StringFile>().verify.toUpperCase(),
                onPressButton: () {
                  widget.pageController.jumpToPage(2);
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
                      TextSpan(text: sl<StringFile>().receivedOTP),
                      TextSpan(
                          text: sl<StringFile>().resendOTP,
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

  @override
  void dispose() {
    _textController1.dispose();
    super.dispose();
  }
}
