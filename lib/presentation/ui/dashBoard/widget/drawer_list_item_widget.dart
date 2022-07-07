import 'package:flutter/material.dart';

import '../../../../core/color_constants.dart';
import '../../../../resources/image_resources.dart';

class DrawerListItemWidget extends StatelessWidget {
  final String title;
  final String icon;
  final int index;

  const DrawerListItemWidget(
      {required this.title, required this.icon, required this.index, Key? key})
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
      onTap: () {},
    );
  }
}
