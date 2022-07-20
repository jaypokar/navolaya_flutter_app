import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navolaya_flutter/presentation/cubit/pageIndicatorCubit/page_indicator_page_cubit.dart';

import '../../../../core/color_constants.dart';

class StepIndicatorWidget extends StatelessWidget {
  const StepIndicatorWidget({Key? key}) : super(key: key);

  List<Widget> _buildPageIndicator(int position) {
    final List<Widget> pageIndicatorViews = [];
    for (int i = 0; i < 2; i++) {
      pageIndicatorViews.add(i == position ? _indicator(true, i) : _indicator(false, i));
    }
    return pageIndicatorViews;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PageIndicatorPageCubit, int>(
      builder: (_, pos) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _buildPageIndicator(pos),
        );
      },
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
