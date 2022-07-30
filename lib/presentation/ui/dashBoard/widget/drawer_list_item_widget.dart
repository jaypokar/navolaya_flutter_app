import 'package:flutter/material.dart';
import 'package:navolaya_flutter/core/route_generator.dart';

import '../../../../resources/color_constants.dart';
import '../../../../resources/image_resources.dart';

class DrawerListItemWidget extends StatelessWidget {
  final String title;
  final String icon;
  final int index;
  final TabController tabController;

  const DrawerListItemWidget(
      {required this.title,
      required this.icon,
      required this.index,
      required this.tabController,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 5,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      leading: icon == ImageResources.settingsIcon
          ? const Icon(
              Icons.settings_outlined,
              size: 24,
            )
          : Image.asset(
              icon,
              height: 24,
              width: 24,
              color: ColorConstants.dashBoardDrawerItemColor,
            ),
      title: Text(
        title,
        style: const TextStyle(color: ColorConstants.dashBoardDrawerItemColor, fontSize: 15),
      ),
      onTap: () {
        if (index == 0) {
          Navigator.of(context).pushNamed(RouteGenerator.editProfilePage);
        } else if (index == 1) {
          Scaffold.of(context).closeDrawer();
          tabController.index = 3;
        } else if (index == 2) {
          Scaffold.of(context).closeDrawer();
          tabController.index = 1;
        } else if (index == 3) {
          Navigator.of(context).pushNamed(RouteGenerator.userVerificationRequestPage);
        } else if (index == 4) {
          Navigator.of(context).pushNamed(RouteGenerator.connectionRequestPage);
        } else if (index == 5) {
          Navigator.of(context).pushNamed(RouteGenerator.settingsPage);
        } else {
          Navigator.of(context).pushNamed(RouteGenerator.helpAndInfoPage);
        }
      },
    );
  }
}
