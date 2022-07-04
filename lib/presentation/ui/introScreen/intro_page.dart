import 'package:flutter/material.dart';
import 'package:navolaya_flutter/core/color_constants.dart';
import 'package:navolaya_flutter/core/route_generator.dart';
import 'package:navolaya_flutter/core/string_file.dart';
import 'package:navolaya_flutter/presentation/basicWidget/custom_button.dart';

import '../../../injection_container.dart';
import '../../../util/common_functions.dart';
import 'widget/first_intro_widget.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final PageController _controller = PageController();
  int _selectedIndex = 0;

  List<Widget> _buildPageIndicator() {
    final List<Widget> pageIndicatorViews = [];
    for (int i = 0; i < 3; i++) {
      pageIndicatorViews.add(i == _selectedIndex ? _indicator(true) : _indicator(false));
    }
    return pageIndicatorViews;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image(
            image: AssetImage(sl<CommonFunctions>().getImage(ImageType.imageBg)),
            fit: BoxFit.fill,
          ),
          Column(
            children: [
              Expanded(
                flex: 7,
                child: PageView(
                  onPageChanged: (int page) {
                    setState(() {
                      _selectedIndex = page;
                    });
                  },
                  controller: _controller,
                  children: const [
                    FirstIntroWidget(),
                    FirstIntroWidget(),
                    FirstIntroWidget(),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildPageIndicator(),
              ),
              Padding(
                  padding: const EdgeInsets.all(20),
                  child: ButtonWidget(
                      buttonText: sl<StringFile>().getStarted,
                      onPressButton: () {
                        Navigator.of(context)
                            .pushReplacementNamed(RouteGenerator.authenticationPage);
                      })),
            ],
          ),
        ],
      ),
    );
  }

  Widget _indicator(bool isActive) {
    return SizedBox(
      height: 5,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.symmetric(horizontal: 4.0),
        height: isActive ? 10 : 8.0,
        width: isActive ? 12 : 8.0,
        decoration: BoxDecoration(
          boxShadow: [
            isActive
                ? BoxShadow(
                    color: ColorConstants.appColor.withOpacity(0.72),
                    blurRadius: 1.0,
                    spreadRadius: 1.0,
                    offset: const Offset(
                      0.0,
                      0.0,
                    ),
                  )
                : const BoxShadow(
                    color: Colors.transparent,
                  )
          ],
          shape: BoxShape.circle,
          color: isActive ? ColorConstants.appColor : const Color(0XFFEAEAEA),
        ),
      ),
    );
  }
}
