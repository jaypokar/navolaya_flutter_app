import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:navolaya_flutter/presentation/ui/home/widget/dummy_widget.dart';
import 'package:navolaya_flutter/presentation/ui/user/widget/tab_widget.dart';

import '../../../core/color_constants.dart';
import 'widget/home_widget.dart';

import 'dart:math' as math;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  final String _selectedTitle = 'Discover';
  late List<Widget> _widgetOptions;
  late TabController _tabController;

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
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      initialIndex: 0,
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: ColorConstants.appColor,
                ),
                child: Text('Drawer Header'),
              ),
              ListTile(
                title: const Text('Item 1'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                title: const Text('Item 2'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
            ],
          ),
        ),
        appBar: AppBar(
          leading: Builder(builder: (ctx) {
            return IconButton(
                onPressed: () {
                  Scaffold.of(ctx).openDrawer();
                },
                icon: const Icon(
                  Icons.menu_sharp,
                  color: Colors.white,
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
              _widgetOptions[0],
              _widgetOptions[1],
              _widgetOptions[2],
              _widgetOptions[3],
              _widgetOptions[4],
            ]),
        floatingActionButton: SizedBox(
          height: 70,
          width: 70,
          child: FloatingActionButton(
            onPressed: () {},
            shape: const StadiumBorder(side: BorderSide(color: Colors.white, width: 2)),
            child: const Icon(
              Icons.search,
              color: Colors.white,
              size: 35,
            ),
          ),
        ),
        bottomNavigationBar: TabWidget(controller: _tabController),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      ),
    );
  }

  Widget menu() {
    return Container(
      height: 65,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            offset: const Offset(0.0, -5.0), //(x,y)
            blurRadius: 5.0,
          ),
        ],
      ),
      child: TabBar(
        labelColor: ColorConstants.appColor,
        unselectedLabelColor: Colors.grey,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorWeight: 3,
        indicatorColor: ColorConstants.appColor,
        onTap: (index) {
          if (index == 2) {
            return;
          }
          _tabController.index = index;
        },
        tabs: const [
          Tab(
            text: null,
            icon: Icon(
              FontAwesomeIcons.house,
              size: 25,
            ),
          ),
          Tab(
            text: null,
            icon: Icon(
              FontAwesomeIcons.peopleGroup,
              size: 25,
            ),
          ),
          IgnorePointer(
            child: Tab(
              text: '',
              icon: null,
            ),
          ),
          Tab(
            text: null,
            icon: Icon(
              FontAwesomeIcons.facebookMessenger,
              size: 25,
            ),
          ),
          Tab(
            text: null,
            icon: Icon(
              Icons.notifications,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}
