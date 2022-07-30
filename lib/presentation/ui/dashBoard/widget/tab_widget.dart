import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navolaya_flutter/presentation/cubit/dashBoardTitleNotifierCubit/dash_board_title_notifier_cubit.dart';
import 'package:navolaya_flutter/resources/string_resources.dart';

import '../../../../resources/color_constants.dart';
import '../../../../resources/image_resources.dart';

class TabWidget extends StatelessWidget {
  final TabController controller;

  const TabWidget({required this.controller, Key? key}) : super(key: key);

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
        controller: controller,
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
          //setState((){widget.controller.index = index;});
        },
        tabs: [
          BlocBuilder<DashBoardTitleNotifierCubit, String>(
            builder: (_, title) {
              return Tab(
                text: null,
                icon: Image.asset(
                  ImageResources.homeIcon,
                  height: 22,
                  color: title == StringResources.discover
                      ? ColorConstants.appColor
                      : ColorConstants.dashBoardTabColor,
                ),
              );
            },
          ),
          BlocBuilder<DashBoardTitleNotifierCubit, String>(
            builder: (_, title) {
              return Tab(
                text: null,
                icon: Image.asset(
                  ImageResources.groupIcon,
                  height: 22,
                  color: title == StringResources.myConnections
                      ? ColorConstants.appColor
                      : ColorConstants.dashBoardTabColor,
                ),
              );
            },
          ),
          const IgnorePointer(
            child: Tab(
              text: '',
              icon: null,
            ),
          ),
          BlocBuilder<DashBoardTitleNotifierCubit, String>(
            builder: (_, title) {
              return Tab(
                text: null,
                icon: Image.asset(
                  ImageResources.chatIcon,
                  height: 22,
                  color: title == StringResources.messages
                      ? ColorConstants.appColor
                      : ColorConstants.dashBoardTabColor,
                ),
              );
            },
          ),
          BlocBuilder<DashBoardTitleNotifierCubit, String>(
            builder: (_, title) {
              return Tab(
                text: null,
                icon: Image.asset(
                  ImageResources.notificationBellIcon,
                  height: 22,
                  color: title == StringResources.notifications
                      ? ColorConstants.appColor
                      : ColorConstants.dashBoardTabColor,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
