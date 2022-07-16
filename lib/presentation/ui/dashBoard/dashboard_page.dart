import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:navolaya_flutter/presentation/ui/dashBoard/widget/dash_board_drawer_widget.dart';
import 'package:navolaya_flutter/presentation/ui/messages/messages_widget.dart';
import 'package:navolaya_flutter/presentation/ui/notifications/notifications_widget.dart';
import 'package:navolaya_flutter/presentation/ui/user/widget/tab_widget.dart';
import 'package:navolaya_flutter/resources/image_resources.dart';

import '../../../injection_container.dart';
import '../../../resources/string_resources.dart';
import '../../uiNotifiers/ui_notifiers.dart';
import '../dashBoard/widget/floating_search_button_widget.dart';
import '../home/home_widget.dart';
import '../home/widget/dummy_widget.dart';
import '../myConnections/my_connections_widget.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({Key? key}) : super(key: key);

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> with TickerProviderStateMixin {
  late List<Widget> _widgetOptions;
  late TabController _tabController;
  final PageStorageBucket _bucket = PageStorageBucket();

  @override
  void initState() {
    _widgetOptions = <Widget>[
      const HomeWidget(
        key: PageStorageKey('home'),
      ),
      const MyConnectionsWidget(
        key: PageStorageKey('myConnections'),
      ),
      const DummyWidget(
        key: PageStorageKey('search'),
      ),
      const MessagesWidget(
        key: PageStorageKey('messages'),
      ),
      const NotificationsWidget(
        key: PageStorageKey('notifications'),
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
      if (_tabController.index == 0) {
        sl<UiNotifiers>().dashBoardTitleNotifier.value = StringResources.discover;
      } else if (_tabController.index == 1) {
        sl<UiNotifiers>().dashBoardTitleNotifier.value = StringResources.myConnections;
      } else if (_tabController.index == 3) {
        sl<UiNotifiers>().dashBoardTitleNotifier.value = StringResources.messages;
      } else if (_tabController.index == 4) {
        sl<UiNotifiers>().dashBoardTitleNotifier.value = StringResources.notifications;
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      initialIndex: 0,
      child: Scaffold(
        drawer: DashBoardDrawerWidget(tabController: _tabController),
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
          title: ValueListenableBuilder<String>(
            valueListenable: sl<UiNotifiers>().dashBoardTitleNotifier,
            builder: (_, title, __) {
              return Text(
                title,
                style: const TextStyle(color: Colors.white),
              );
            },
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
        bottomNavigationBar: TabWidget(
          controller: _tabController,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    sl<UiNotifiers>().dashBoardTitleNotifier.dispose();
    sl<UiNotifiers>().recentNearByPopularUserTabNotifier.dispose();
    super.dispose();
  }
}
