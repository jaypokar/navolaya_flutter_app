import 'package:flutter/material.dart';
import 'package:navolaya_flutter/injection_container.dart';
import 'package:navolaya_flutter/presentation/uiNotifiers/ui_notifiers.dart';

import '../../../../core/color_constants.dart';

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
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            offset: const Offset(0.0, 5.0), //(x,y)
            blurRadius: 5.0,
          ),
        ],
      ),
      child: TabBar(
        indicatorColor: ColorConstants.appColor,
        labelColor: ColorConstants.textColor2,
        controller: _tabController,
        unselectedLabelColor: ColorConstants.textColor2,
        indicator: BoxDecoration(color: Colors.black12.withOpacity(0.1)),
        onTap: (index) {
          sl<UiNotifiers>().recentNearByPopularUserTabNotifier.value = index;
        },
        tabs: ['Recent', 'Near By', 'Popular']
            .map((e) => Tab(
                  child: Text(
                    e,
                    style: const TextStyle(fontSize: 16),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
