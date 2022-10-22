import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navolaya_flutter/core/either_extension_function.dart';
import 'package:navolaya_flutter/data/model/notification_model.dart';
import 'package:navolaya_flutter/domain/notifications_repository.dart';
import 'package:navolaya_flutter/features/local_notificaion.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  int _page = 1;
  bool _isListFetchingComplete = false;
  final NotificationsRepository _repository;
  final LocalNotification _localNotification;

  NotificationsCubit(this._repository, this._localNotification)
      : super(const NotificationsInitial());

  void loadNotifications({bool reset = false}) async {
    _localNotification.removeAllBadgeCount();
    if (reset) {
      _page = 1;
    }
    if (state is LoadingNotificationsState || _isListFetchingComplete && !reset) return;

    final currentState = state;

    List<NotificationDataModel> oldPosts = [];
    if (currentState is LoadNotificationsState && _page != 1) {
      oldPosts = currentState.notificationsData;
    }

    emit(LoadingNotificationsState(oldPosts, isFirstFetch: _page == 1));

    final possibleData = await _repository.fetchNotificationsAPI(page: _page);

    if (possibleData.isLeft()) {
      emit(ErrorLoadingNotificationsState(message: possibleData.getLeft()!.error));
      return;
    }

    if (possibleData.getRight()!.data != null) {
      _isListFetchingComplete = !possibleData.getRight()!.data!.hasNextPage!;
    }

    _page++;
    final List<NotificationDataModel> notifications =
        reset ? [] : (state as LoadingNotificationsState).oldNotifications;
    notifications.addAll(possibleData.getRight()!.data!.docs!);
    emit(LoadNotificationsState(notificationsData: notifications));
  }

  void removeNotifications() async {
    _localNotification.removeAllBadgeCount();
    final currentState = state;
    if (currentState is LoadNotificationsState) {
      final list = currentState.notificationsData;
      if (list.isEmpty) {
        return;
      }
    }
    emit(LoadingNotificationsState(const [], isFirstFetch: _page == 1));
    final possibleData = await _repository.removeNotificationsAPI();
    if (possibleData.isLeft()) {
      emit(ErrorLoadingNotificationsState(message: possibleData.getLeft()!.error));
      return;
    }
    emit(const LoadNotificationsState(notificationsData: []));
  }

  bool get isListFetchingComplete => _isListFetchingComplete;
}
