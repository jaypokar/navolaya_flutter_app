import 'package:flutter/material.dart';

import '../../../resources/image_resources.dart';
import 'widget/mobile_number_widget.dart';
import 'widget/password_widget.dart';
import 'widget/verify_mobile_number_widget.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  final PageController _controller = PageController();
  final TextEditingController _mobileTextController = TextEditingController();
  double _screenHeight = 0.0;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _screenHeight = MediaQuery.of(context).size.height * 0.10;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(
            height: 60,
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(image: AssetImage(ImageResources.imgBg), fit: BoxFit.cover),
            ),
            child: const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 40,
              ),
              child: Image(
                image: AssetImage(ImageResources.textLogo),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          Expanded(
            child: PageView(
              controller: _controller,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                MobileNumberWidget(
                  pageController: _controller,
                  textController: _mobileTextController,
                  screenHeight: _screenHeight,
                ),
                VerifyMobileNumberWidget(
                  pageController: _controller,
                  screenHeight: _screenHeight,
                  mobileTextController: _mobileTextController,
                ),
                SetNewPasswordWidget(
                  screenHeight: _screenHeight,
                  pageController: _controller,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _mobileTextController.dispose();
    super.dispose();
  }
}
