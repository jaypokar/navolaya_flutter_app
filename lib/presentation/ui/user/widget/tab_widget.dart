import 'package:flutter/material.dart';

import '../../../../core/color_constants.dart';
import '../../../../resources/image_resources.dart';

class TabWidget extends StatefulWidget {
  final TabController controller;

  const TabWidget({required this.controller, Key? key}) : super(key: key);

  @override
  State<TabWidget> createState() => _TabWidgetState();
}

class _TabWidgetState extends State<TabWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 62,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            offset: const Offset(0.0, -5.0), //(x,y)
            blurRadius: 5.0,
          ),
        ],
      ),
      child: TabBar(
        labelColor: ColorConstants.appColor,
        unselectedLabelColor: Colors.grey,
        indicator: const UnderlineTabIndicator(
          borderSide: BorderSide(
            color: ColorConstants.appColor,
            width: 3.0,
          ),
          insets: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 59.0),
        ),
        onTap: (index) {
          if (index == 2) {
            return;
          }
          setState(() {
            widget.controller.index = index;
          });
        },
        tabs: [
          Tab(
            text: null,
            icon: Image.asset(
              ImageResources.homeIcon,
              height: 22,
              color: widget.controller.index == 0
                  ? ColorConstants.appColor
                  : ColorConstants.dashBoardTabColor,
            ),
          ),
          Tab(
            text: null,
            icon: Image.asset(
              ImageResources.groupIcon,
              height: 22,
              color: widget.controller.index == 1
                  ? ColorConstants.appColor
                  : ColorConstants.dashBoardTabColor,
            ),
          ),
          const IgnorePointer(
            child: Tab(
              text: '',
              icon: null,
            ),
          ),
          Tab(
            text: null,
            icon: Image.asset(
              ImageResources.chatIcon,
              height: 22,
              color: widget.controller.index == 3
                  ? ColorConstants.appColor
                  : ColorConstants.dashBoardTabColor,
            ),
          ),
          Tab(
            text: null,
            icon: Image.asset(
              ImageResources.notificationBellIcon,
              height: 22,
              color: widget.controller.index == 4
                  ? ColorConstants.appColor
                  : ColorConstants.dashBoardTabColor,
            ),
          ),
        ],
      ),
    );
  }
}
