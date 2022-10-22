import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:navolaya_flutter/core/route_generator.dart';

import '../../../../domain/master_repository.dart';
import '../../../../injection_container.dart';
import '../../../../resources/color_constants.dart';
import '../../../cubit/dashBoardTabChangeNotifier/dash_board_tab_change_notifier_cubit.dart';

class DrawerListItemWidget extends StatelessWidget {
  final String title;
  final String icon;
  final int index;
  final bool isHelpInfoIcon;

  const DrawerListItemWidget(
      {required this.title,
      required this.icon,
      required this.index,
      this.isHelpInfoIcon = false,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      horizontalTitleGap: 5,
      dense: true,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      leading: /*icon == ImageResources.settingsIcon
          ? const Icon(
              Icons.settings_outlined,
              size: 24,
            )
          :*/
          Image.asset(
        icon,
        height: isHelpInfoIcon ? 22 : 24,
        width: isHelpInfoIcon ? 22 : 24,
        color: ColorConstants.dashBoardDrawerItemColor,
      ),
      title: Text(
        title,
        style: const TextStyle(color: ColorConstants.dashBoardDrawerItemColor, fontSize: 15),
      ),
      onTap: () async {
        if (index == 0) {
          Navigator.of(context).pushNamed(RouteGenerator.editProfilePage);
        } else if (index == 1) {
          Scaffold.of(context).closeDrawer();
          context.read<DashBoardTabChangeNotifierCubit>().changeTab(3);
        } else if (index == 2) {
          Scaffold.of(context).closeDrawer();
          context.read<DashBoardTabChangeNotifierCubit>().changeTab(1);
        } else if (index == 3) {
          Navigator.of(context).pushNamed(RouteGenerator.userVerificationRequestPage);
        } else if (index == 4) {
          Navigator.of(context).pushNamed(RouteGenerator.connectionRequestPage);
        } else if (index == 5) {
          Navigator.of(context).pushNamed(RouteGenerator.settingsPage);
        } else if (index == 6) {
          Navigator.of(context).pushNamed(RouteGenerator.helpAndInfoPage);
        } else if (index == 7) {
          Scaffold.of(context).closeDrawer();
          share();
        }
      },
    );
  }

  Future<void> share() async {
    await FlutterShare.share(
        title: 'Navolaya',
        text: sl<MasterRepository>().appContents.data!.settings!.shareTheAppText!,
        chooserTitle: 'Choose App to share');
  }
}
