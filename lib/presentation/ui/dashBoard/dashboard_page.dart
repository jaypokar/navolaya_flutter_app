import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navolaya_flutter/data/sessionManager/session_manager.dart';
import 'package:navolaya_flutter/presentation/ui/dashBoard/widget/dash_board_drawer_widget.dart';
import 'package:navolaya_flutter/presentation/ui/dashBoard/widget/tab_widget.dart';
import 'package:navolaya_flutter/presentation/ui/messages/messages_widget.dart';
import 'package:navolaya_flutter/presentation/ui/notifications/notifications_widget.dart';
import 'package:navolaya_flutter/resources/image_resources.dart';

import '../../../injection_container.dart';
import '../../../resources/string_resources.dart';
import '../../basicWidget/custom_button.dart';
import '../../cubit/dashBoardTitleNotifierCubit/dash_board_title_notifier_cubit.dart';
import '../dashBoard/widget/floating_search_button_widget.dart';
import '../home/home_widget.dart';
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
      const SizedBox(
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

    _tabController.addListener(_tabChangeListener);

    super.initState();
  }

  void _tabChangeListener() {
    if (_tabController.indexIsChanging == false) {
      if (_tabController.index == 1) {
        //Trigger your request
      }
    }
    if (_tabController.index == 0) {
      context.read<DashBoardTitleNotifierCubit>().changeTitle(StringResources.discover);
    } else if (_tabController.index == 1) {
      context.read<DashBoardTitleNotifierCubit>().changeTitle(StringResources.myConnections);
    } else if (_tabController.index == 3) {
      context.read<DashBoardTitleNotifierCubit>().changeTitle(StringResources.messages);
    } else if (_tabController.index == 4) {
      context.read<DashBoardTitleNotifierCubit>().changeTitle(StringResources.notifications);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    showJNVVerificationDialog();
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
          title: BlocBuilder<DashBoardTitleNotifierCubit, String>(
            builder: (_, title) {
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
        body: Stack(
          children: [
            TabBarView(
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
                ])
          ],
        ),
        floatingActionButton: const FloatingActionButtonWidget(),
        bottomNavigationBar: TabWidget(
          controller: _tabController,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
      ),
    );
  }

  void showJNVVerificationDialog() async {
    if (sl<SessionManager>().getUserDetails()!.data!.jnvVerificationStatus == 0) {
      await Future.delayed(const Duration(seconds: 2));

      if (!mounted) return;
      showDialog(
        context: context,
        barrierLabel: "Barrier",
        barrierDismissible: true,
        barrierColor: Colors.black.withOpacity(0.5),
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.35,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      StringResources.jnvVerificationTitle,
                      style:
                          TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      StringResources.jnvVerificationSubTitle,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      StringResources.jnvVerificationNote,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ButtonWidget(
                        buttonText: StringResources.continueText.toUpperCase(),
                        padding: 0,
                        onPressButton: () {
                          Navigator.of(context).pop();
                        })
                  ],
                ),
              ),
            ),
          );
        },
      );
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_tabChangeListener);
    _tabController.dispose();
    super.dispose();
  }
}
