import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navolaya_flutter/core/route_generator.dart';
import 'package:navolaya_flutter/data/sessionManager/session_manager.dart';
import 'package:navolaya_flutter/presentation/basicWidget/hidden_button_widget.dart';
import 'package:navolaya_flutter/presentation/basicWidget/jnv_note_rich_text_widget.dart';
import 'package:navolaya_flutter/presentation/bloc/profileBloc/profile_bloc.dart';
import 'package:navolaya_flutter/presentation/cubit/dashBoardTabChangeNotifier/dash_board_tab_change_notifier_cubit.dart';
import 'package:navolaya_flutter/presentation/ui/dashBoard/widget/dash_board_drawer_widget.dart';
import 'package:navolaya_flutter/presentation/ui/dashBoard/widget/tab_widget.dart';
import 'package:navolaya_flutter/presentation/ui/dashBoard/widget/verify_identity_radio_widget.dart';
import 'package:navolaya_flutter/presentation/ui/messages/messages_widget.dart';
import 'package:navolaya_flutter/presentation/ui/notifications/notifications_widget.dart';
import 'package:navolaya_flutter/resources/image_resources.dart';

import '../../../injection_container.dart';
import '../../../resources/color_constants.dart';
import '../../../resources/string_resources.dart';
import '../../basicWidget/custom_button.dart';
import '../../cubit/dashBoardTitleNotifierCubit/dash_board_title_notifier_cubit.dart';
import '../../cubit/notificationsCubit/notifications_cubit.dart';
import '../dashBoard/widget/floating_search_button_widget.dart';
import '../home/home_widget.dart';
import '../myConnections/my_connections_widget.dart';

enum ClearNotification { clear }

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
          /*key: PageStorageKey('home'),*/
          ),
      const MyConnectionsWidget(
          /*key: PageStorageKey('myConnections'),*/
          ),
      const SizedBox(
          /*key: PageStorageKey('search'),*/
          ),
      const MessagesWidget(
          /*key: PageStorageKey('messages'),*/
          ),
      const NotificationsWidget(
          /*key: PageStorageKey('notifications'),*/
          ),
    ];

    _tabController = TabController(
      initialIndex: 0,
      length: 5,
      vsync: this,
    );

    _tabController.addListener(_tabChangeListener);

    showJNVVerificationDialog();

    context.read<ProfileBloc>().add(const GetProfileEvent());

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
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<DashBoardTabChangeNotifierCubit, int>(
          listener: (_, state) async => _tabController.index = state,
        ),
        BlocListener<ProfileBloc, ProfileState>(listener: (_, state) {
          if (state is GetProfileState) {}
        })
      ],
      child: DefaultTabController(
        length: 5,
        initialIndex: 0,
        child: Scaffold(
          drawer: const DashBoardDrawerWidget(),
          appBar: AppBar(
            leading: Builder(builder: (ctx) {
              return IconButton(
                  onPressed: () => Scaffold.of(ctx).openDrawer(),
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
              BlocBuilder<DashBoardTabChangeNotifierCubit, int>(
                builder: (_, index) {
                  return index == 4
                      ? IconButton(
                          onPressed: () async => showClearNotificationBottomSheet(),
                          icon: Transform.rotate(
                              angle: 90 * math.pi / 180,
                              child: const Icon(
                                Icons.more_horiz,
                                color: Colors.white,
                              )),
                        )
                      : const SizedBox.shrink();
                },
              ),
            ],
          ),
          body: Stack(
            children: [
              TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _tabController,
                  children: [
                    _widgetOptions[0],
                    _widgetOptions[1],
                    _widgetOptions[2],
                    _widgetOptions[3],
                    _widgetOptions[4],
                    /* PageStorage(
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
                    ),*/
                  ])
            ],
          ),
          floatingActionButton: const FloatingActionButtonWidget(),
          bottomNavigationBar: Stack(
            alignment: Alignment.center,
            children: [
              TabWidget(
                controller: _tabController,
              ),
              const HiddenButtonWidget()
            ],
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
        ),
      ),
    );
  }

  void showJNVVerificationDialog() async {
    final showJNVVerificationPopup = !sl<SessionManager>().checkVerificationPopupDisplayed();
    if (sl<SessionManager>().getUserDetails()!.data!.jnvVerificationStatus == 0 &&
        showJNVVerificationPopup) {
      sl<SessionManager>().jnvVerificationPopupHasBeenDisplayed();
      await Future.delayed(const Duration(seconds: 2));

      ValueNotifier<String> jnvNoteNotifier = ValueNotifier(StringResources.jnvNote1);
      String verifyBy = StringResources.verifyByUserReference;

      if (!mounted) return;
      final result = await showDialog(
        context: context,
        barrierLabel: "Barrier",
        barrierDismissible: false,
        barrierColor: Colors.black.withOpacity(0.6),
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
            child: SizedBox(
              height: 377,
              width: 300,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        StringResources.jnvVerificationTitle,
                        style: TextStyle(
                            color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          StringResources.jnvVerificationSubTitle,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      VerifyIdentityRadioWidget(
                          verificationOption: verifyBy,
                          jnvNoteNotifier: jnvNoteNotifier,
                          onValueSelect: (String value) {
                            verifyBy = value;
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                      ValueListenableBuilder<String>(
                        valueListenable: jnvNoteNotifier,
                        builder: (_, note, __) {
                          return JnvNoteRichTextWidget(
                            onClickEvent: () {},
                            textOne: 'Note: ',
                            textTwo: note,
                          );
                        },
                      ),
                      ButtonWidget(
                          buttonText: StringResources.continueText.toUpperCase(),
                          buttonPaddingLeft: 40,
                          buttonPaddingRight: 40,
                          isWrap: true,
                          onPressButton: () {
                            Navigator.of(context).pop(verifyBy);
                          })
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );

      if (result != null) {
        if (verifyBy == StringResources.verifyByDocument) {
          if (!mounted) return;
          Navigator.of(context).pushNamed(RouteGenerator.jnvVerificationPage);
        }
      }
    }
  }

  void showClearNotificationBottomSheet() async {
    final result = await showModalBottomSheet(
        constraints: BoxConstraints.loose(Size(MediaQuery.of(context).size.width, 100)),
        isDismissible: true,
        isScrollControlled: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        context: context,
        builder: (_) {
          return const ClearNotificationItemWidget();
        });

    if (!mounted) return;
    if (result != null) {
      context.read<NotificationsCubit>().removeNotifications();
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_tabChangeListener);
    _tabController.dispose();
    super.dispose();
  }
}

class ClearNotificationItemWidget extends StatelessWidget {
  const ClearNotificationItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          horizontalTitleGap: 0,
          contentPadding: const EdgeInsets.only(left: 20, top: 5),
          leading: const Icon(
            Icons.notifications_off_outlined,
            size: 30,
            color: ColorConstants.messageErrorBgColor,
          ),
          title: const Text(
            StringResources.clearNotification,
            style: TextStyle(color: Colors.black, fontSize: 16),
          ),
          onTap: () {
            Navigator.of(context).pop(ClearNotification.clear);
          },
        )
      ],
    );
  }
}
