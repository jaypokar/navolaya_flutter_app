import 'package:flutter/material.dart';
import 'package:navolaya_flutter/presentation/ui/registration/widget/basic_info_widget.dart';

import '../../../core/color_constants.dart';
import '../../../injection_container.dart';
import '../../../util/common_functions.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final PageController _controller = PageController();
  int _selectedIndex = 0;

  List<Widget> _buildPageIndicator() {
    final List<Widget> pageIndicatorViews = [];
    for (int i = 0; i < 2; i++) {
      pageIndicatorViews.add(i == _selectedIndex ? _indicator(true, i) : _indicator(false, i));
    }
    return pageIndicatorViews;
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
              image: DecorationImage(
                  image: AssetImage(sl<CommonFunctions>().getImage(ImageType.imageBg)),
                  fit: BoxFit.cover),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
              ),
              child: Image(
                image: AssetImage(sl<CommonFunctions>().getImage(ImageType.textLogo)),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              const Center(
                  child: SizedBox(
                      width: 50,
                      child: Divider(
                        color: ColorConstants.greyColor,
                        thickness: 5,
                      ))),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildPageIndicator(),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            flex: 7,
            child: PageView(
              onPageChanged: (int page) {
                setState(() {
                  _selectedIndex = page;
                });
              },
              controller: _controller,
              children: [
                BasicInfoWidget(pageController: _controller),
                BasicInfoWidget(pageController: _controller)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _indicator(bool isActive, int position) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      height: isActive ? 40 : 32.0,
      width: isActive ? 40 : 32.0,
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
        color: isActive ? ColorConstants.appColor : ColorConstants.greyColor,
      ),
      child: Center(
        child: Text(
          '${(position + 1)}',
          style:
              TextStyle(color: isActive ? Colors.white : ColorConstants.textColor4, fontSize: 16),
        ),
      ),
    );
  }
}
