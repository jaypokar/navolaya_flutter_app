import 'package:flutter/material.dart';

import '../../dashBoard/widget/recent_users_widget.dart';
import '../../dashBoard/widget/user_tabs_widget.dart';
import 'dummy_widget.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> with AutomaticKeepAliveClientMixin {
  late List<Widget> _widgetOptions;
  final PageStorageBucket _bucket = PageStorageBucket();
  final _tabChangeNotifier = ValueNotifier(0);

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
        UserTabsWidget(tabChangeNotifier: _tabChangeNotifier),
        Expanded(
          child: ValueListenableBuilder<int>(
              valueListenable: _tabChangeNotifier,
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
