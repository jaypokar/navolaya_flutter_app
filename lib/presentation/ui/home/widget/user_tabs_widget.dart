import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:navolaya_flutter/presentation/cubit/homeTabsNotifierCubit/home_tabs_notifier_cubit.dart';

import '../../../../resources/color_constants.dart';

class UserTabsWidget extends StatefulWidget {
  const UserTabsWidget({Key? key}) : super(key: key);

  @override
  State<UserTabsWidget> createState() => _UserTabsWidgetState();
}

class _UserTabsWidgetState extends State<UserTabsWidget> with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeTabsNotifierCubit, int>(
      listener: (_, state) {
        _tabController.index = state;
      },
      child: Neumorphic(
        style: NeumorphicStyle(
            shape: NeumorphicShape.flat,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(0)),
            depth: 0.3,
            color: ColorConstants.transparent,
            lightSource: LightSource.topRight,
            intensity: 0.9),
        child: TabBar(
          indicatorColor: ColorConstants.appColor,
          labelColor: ColorConstants.textColor2,
          controller: _tabController,
          unselectedLabelColor: ColorConstants.textColor2,
          indicator: BoxDecoration(color: Colors.black12.withOpacity(0.1)),
          onTap: (index) {
            context.read<HomeTabsNotifierCubit>().changeHomeTabs(index);
          },
          tabs: ['Recent', 'Near By', 'Popular']
              .map((e) => Tab(
                    child: Text(
                      e,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: ColorConstants.textColor3),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
