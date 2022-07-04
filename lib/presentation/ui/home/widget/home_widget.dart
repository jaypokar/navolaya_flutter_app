import 'package:flutter/material.dart';
import 'package:navolaya_flutter/core/color_constants.dart';
import 'package:navolaya_flutter/presentation/ui/home/widget/dummy_widget.dart';
import 'package:navolaya_flutter/presentation/ui/home/widget/recent_users_widget.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({Key? key}) : super(key: key);

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> with SingleTickerProviderStateMixin {
  late List<Widget> _widgetOptions;
  late TabController _tabController;
  int _currentIndex = 0;
  late List tabs;

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

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
    tabs = ['Recent', 'Near By', 'Popular'];
    _tabController = TabController(length: tabs.length, vsync: this);
    _tabController.addListener(_handleTabControllerTick);
  }

  void _handleTabControllerTick() {
    setState(() {
      _currentIndex = _tabController.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
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
            unselectedLabelColor: ColorConstants.textColor2,
            indicator: BoxDecoration(color: Colors.black12.withOpacity(0.1)),
            controller: _tabController,
            tabs: tabs
                .map((e) => Tab(
                      child: Text(
                        e,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ))
                .toList(),
          ),
        ),
        Expanded(child: _widgetOptions[_currentIndex])
      ],
    );
  }
}
