import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navolaya_flutter/presentation/cubit/dashBoardTabChangeNotifier/dash_board_tab_change_notifier_cubit.dart';

import '../../../../resources/color_constants.dart';
import '../../../../resources/image_resources.dart';

class TabWidget extends StatelessWidget {
  final TabController controller;

  const TabWidget({required this.controller, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 63,
      padding: const EdgeInsets.only(bottom: 6),
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
          insets: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 54.0),
        ),
        onTap: (index) {
          context.read<DashBoardTabChangeNotifierCubit>().changeTab(index);
          if (index == 2) {
            return;
          }
          //setState((){widget.controller.index = index;});
        },
        tabs: [
          BlocBuilder<DashBoardTabChangeNotifierCubit, int>(
            builder: (_, pos) {
              return Tab(
                text: null,
                icon: Image.asset(
                  ImageResources.homeIcon,
                  height: 22,
                  color: pos == 0 ? ColorConstants.appColor : ColorConstants.dashBoardTabColor,
                ),
              );
            },
          ),
          BlocBuilder<DashBoardTabChangeNotifierCubit, int>(
            builder: (_, pos) {
              return Tab(
                text: null,
                icon: Image.asset(
                  ImageResources.groupIcon,
                  height: 20,
                  color: pos == 1 ? ColorConstants.appColor : ColorConstants.dashBoardTabColor,
                ),
              );
            },
          ),
          const IgnorePointer(
            ignoring: true,
            ignoringSemantics: true,
            child: Tab(
              height: 55,
              text: '',
              icon: null,
            ),
          ),
          BlocBuilder<DashBoardTabChangeNotifierCubit, int>(
            builder: (_, pos) {
              return Tab(
                text: null,
                icon: Image.asset(
                  ImageResources.chatIcon,
                  height: 24,
                  color: pos == 3 ? ColorConstants.appColor : ColorConstants.dashBoardTabColor,
                ),
              );
            },
          ),
          BlocBuilder<DashBoardTabChangeNotifierCubit, int>(
            builder: (_, pos) {
              return Tab(
                text: null,
                icon: Image.asset(
                  ImageResources.notificationBellIcon,
                  height: 22,
                  color: pos == 4 ? ColorConstants.appColor : ColorConstants.dashBoardTabColor,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
