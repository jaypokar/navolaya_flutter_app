import 'package:flutter/material.dart';
import 'package:navolaya_flutter/presentation/uiNotifiers/ui_notifiers.dart';

import '../../../injection_container.dart';
import 'widget/dummy_widget.dart';
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
      const DummyWidget(
        key: PageStorageKey('NearBy'),
      ),
      const DummyWidget(
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
          child: ValueListenableBuilder<int>(
              valueListenable: sl<UiNotifiers>().recentNearByPopularUserTabNotifier,
              builder: (_, pos, __) {
                return PageStorage(
                  bucket: _bucket,
                  child: _widgetOptions[pos],
                );
              }),
        )
      ],
    );
  }

  @override
  bool get wantKeepAlive => true;
}
