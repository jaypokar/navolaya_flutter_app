import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navolaya_flutter/data/model/notification_model.dart';
import 'package:navolaya_flutter/presentation/basicWidget/image_loader_widget.dart';
import 'package:navolaya_flutter/presentation/cubit/notificationsCubit/notifications_cubit.dart';

import '../../../resources/image_resources.dart';
import '../../../resources/string_resources.dart';
import '../../basicWidget/no_data_widget.dart';
import 'widget/notifications_item_widget.dart';

class NotificationsWidget extends StatefulWidget {
  const NotificationsWidget({Key? key}) : super(key: key);

  @override
  State<NotificationsWidget> createState() => _NotificationsWidgetState();
}

class _NotificationsWidgetState extends State<NotificationsWidget> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    loadUsers();
    setupScrollController();
  }

  void setupScrollController() {
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels != 0 &&
            !context.read<NotificationsCubit>().isListFetchingComplete) {
          context.read<NotificationsCubit>().loadNotifications();
        }
      }
    });
  }

  void loadUsers() {
    context.read<NotificationsCubit>().loadNotifications(reset: true);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationsCubit, NotificationsState>(
      buildWhen: (_, state) {
        if (state is LoadingNotificationsState || state is LoadNotificationsState) {
          return true;
        }
        return false;
      },
      builder: (_, state) {
        if (state is LoadingNotificationsState && state.isFirstFetch) {
          return const ImageLoaderWidget();
        }
        List<NotificationDataModel> notifications = [];
        bool isLoading = false;
        if (state is LoadingNotificationsState) {
          notifications = state.oldNotifications;
          isLoading = true;
        } else if (state is LoadNotificationsState) {
          notifications = state.notificationsData;
        }

        if (notifications.isEmpty && !isLoading) {
          return const NoDataWidget(
            message: StringResources.noDataAvailableMessage,
            icon: ImageResources.notificationBellIcon,
          );
        }

        return ListView.builder(
          itemCount: notifications.length + (isLoading ? 1 : 0),
          controller: _scrollController,
          shrinkWrap: true,
          itemBuilder: (ctx, index) {
            if (index < notifications.length) {
              return NotificationsItemWidget(
                key: ValueKey(notifications[index].id!),
                notification: notifications[index],
              );
            } else {
              Timer(const Duration(milliseconds: 30), () {
                if (notifications.length > 5) {
                  _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
                }
              });

              return const ImageLoaderWidget();
            }
          },
        );
      },
    );
  }
}
