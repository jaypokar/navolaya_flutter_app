import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:navolaya_flutter/presentation/ui/dashBoard/widget/dash_board_drawer_widget.dart';
import 'package:navolaya_flutter/presentation/ui/user/widget/tab_widget.dart';
import 'package:navolaya_flutter/resources/image_resources.dart';

import '../dashBoard/widget/floating_action_button_widget.dart';
import 'widget/dummy_widget.dart';
import 'widget/home_widget.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({Key? key}) : super(key: key);

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> with TickerProviderStateMixin {
  final String _selectedTitle = 'Discover';
  late List<Widget> _widgetOptions;
  late TabController _tabController;
  final PageStorageBucket _bucket = PageStorageBucket();

  @override
  void initState() {
    super.initState();
    _widgetOptions = <Widget>[
      const HomeWidget(
        key: PageStorageKey('home'),
      ),
      const DummyWidget(
        key: PageStorageKey('connect'),
      ),
      const DummyWidget(
        key: PageStorageKey('search'),
      ),
      const DummyWidget(
        key: PageStorageKey('chat'),
      ),
      const DummyWidget(
        key: PageStorageKey('notification'),
      ),
    ];

    _tabController = TabController(
      initialIndex: 0,
      length: 5,
      vsync: this,
    );

    _tabController.addListener(() {
      if (_tabController.indexIsChanging == false) {
        if (_tabController.index == 1) {
          //Trigger your request
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      initialIndex: 0,
      child: Scaffold(
        drawer: const DashBoardDrawerWidget(),
        appBar: AppBar(
          leading: Builder(builder: (ctx) {
            return IconButton(
                onPressed: () {
                  Scaffold.of(ctx).openDrawer();
                },
                icon: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Image.asset(
                    ImageResources.menuIcon,
                    color: Colors.white,
                  ),
                ));
          }),
          title: Text(
            _selectedTitle,
            style: const TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () async {},
              icon: Transform.rotate(
                  angle: 90 * math.pi / 180,
                  child: const Icon(
                    Icons.more_horiz,
                    color: Colors.white,
                  )),
            ),
          ],
        ),
        body: TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _tabController,
            children: [
              PageStorage(
                bucket: _bucket,
                child: _widgetOptions[0],
              ),
              PageStorage(
                bucket: _bucket,
                child: _widgetOptions[1],
              ),
              PageStorage(
                bucket: _bucket,
                child: _widgetOptions[2],
              ),
              PageStorage(
                bucket: _bucket,
                child: _widgetOptions[3],
              ),
              PageStorage(
                bucket: _bucket,
                child: _widgetOptions[4],
              ),
            ]),
        floatingActionButton: const FloatingActionButtonWidget(),
        bottomNavigationBar: TabWidget(controller: _tabController),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
