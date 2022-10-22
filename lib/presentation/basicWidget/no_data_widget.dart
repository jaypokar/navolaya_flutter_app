import 'package:flutter/material.dart';
import 'package:navolaya_flutter/resources/color_constants.dart';

class NoDataWidget extends StatelessWidget {
  final String message;
  final String icon;
  final bool showBackgroundBorder;

  const NoDataWidget(
      {required this.message, required this.icon, this.showBackgroundBorder = true, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              height: 100,
              width: 100,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: showBackgroundBorder
                          ? ColorConstants.textColor3
                          : ColorConstants.transparent)),
              child: Image.asset(icon)),
          const SizedBox(
            height: 10,
          ),
          Text(
            message,
            style: const TextStyle(fontSize: 16, color: ColorConstants.textColor3),
          )
        ],
      ),
    );
  }
}
