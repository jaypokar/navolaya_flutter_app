import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navolaya_flutter/presentation/cubit/homeTabsNotifierCubit/home_tabs_notifier_cubit.dart';
import 'package:navolaya_flutter/presentation/ui/home/widget/near_by_users_widget.dart';
import 'package:navolaya_flutter/presentation/ui/home/widget/popular_users_widget.dart';

import 'widget/recent_users_widget.dart';
import 'widget/user_tabs_widget.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> with AutomaticKeepAliveClientMixin {
  late List<Widget> _widgetOptions;
  final PageStorageBucket _bucket = PageStorageBucket();

  @override
  void initState() {
    super.initState();
    _widgetOptions = <Widget>[
      const RecentUsersWidget(
        key: PageStorageKey('Recent'),
      ),
      const NearByUsersWidget(
        key: PageStorageKey('NearBy'),
      ),
      const PopularUsersWidget(
        key: PageStorageKey('Popular'),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        const UserTabsWidget(),
        Expanded(
          child: BlocBuilder<HomeTabsNotifierCubit, int>(
            builder: (_, pos) {
              return PageStorage(
                bucket: _bucket,
                child: _widgetOptions[pos],
              );
            },
          ),
        )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
