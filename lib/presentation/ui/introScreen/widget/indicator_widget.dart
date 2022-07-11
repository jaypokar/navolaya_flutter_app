import 'package:flutter/material.dart';

import '../../../../core/color_constants.dart';
import '../../../../injection_container.dart';
import '../../../uiNotifiers/ui_notifiers.dart';

class IndicatorWidget extends StatelessWidget {
  const IndicatorWidget({Key? key}) : super(key: key);

  List<Widget> _buildPageIndicator(int position) {
    final List<Widget> pageIndicatorViews = [];
    for (int i = 0; i < 3; i++) {
      pageIndicatorViews.add(i == position ? _indicator(true) : _indicator(false));
    }
    return pageIndicatorViews;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: sl<UiNotifiers>().indicatorNotifier,
      builder: (_, pos, __) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _buildPageIndicator(pos),
        );
      },
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
