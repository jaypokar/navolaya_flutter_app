import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navolaya_flutter/data/model/notification_model.dart';
import 'package:navolaya_flutter/presentation/cubit/notificationsCubit/notifications_cubit.dart';

import '../../../injection_container.dart';
import '../../basicWidget/loading_widget.dart';
import 'widget/notifications_item_widget.dart';

class NotificationsWidget extends StatefulWidget {
  const NotificationsWidget({Key? key}) : super(key: key);

  @override
  State<NotificationsWidget> createState() => _NotificationsWidgetState();
}

class _NotificationsWidgetState extends State<NotificationsWidget>
    with AutomaticKeepAliveClientMixin {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    setupScrollController();
    loadUsers();
  }

  void setupScrollController() {
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels != 0 &&
            !sl<NotificationsCubit>().isListFetchingComplete) {
          loadUsers();
        }
      }
    });
  }

  void loadUsers() {
    context.read<NotificationsCubit>().loadNotifications();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocBuilder<NotificationsCubit, NotificationsState>(
      buildWhen: (_, state) {
        if (state is LoadingNotificationsState || state is LoadNotificationsState) {
          return true;
        }
        return false;
      },
      builder: (_, state) {
        if (state is LoadingNotificationsState && state.isFirstFetch) {
          return const LoadingWidget();
        }
        List<NotificationDataModel> notifications = [];
        bool isLoading = false;
        if (state is LoadingNotificationsState) {
          notifications = state.oldNotifications;
          isLoading = true;
        } else if (state is LoadNotificationsState) {
          notifications = state.notificationsData;
        }
        return ListView.builder(
          itemCount: notifications.length + (isLoading ? 1 : 0),
          controller: _scrollController,
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (ctx, index) {
            if (index < notifications.length) {
              return NotificationsItemWidget(
                key: ValueKey(notifications[index].id!),
                notification: notifications[index],
              );
            } else {
              Timer(const Duration(milliseconds: 30), () {
                _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
              });

              return const LoadingWidget();
            }
          },
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
