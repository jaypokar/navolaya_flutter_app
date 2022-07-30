import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:navolaya_flutter/core/either_extension_function.dart';
import 'package:navolaya_flutter/data/model/notification_model.dart';
import 'package:navolaya_flutter/domain/notifications_repository.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  int _page = 1;
  bool _isListFetchingComplete = false;
  final NotificationsRepository _repository;

  NotificationsCubit(this._repository) : super(const NotificationsInitial());

  void loadNotifications({bool reset = false}) async {
    if (state is LoadingNotificationsState) return;

    final currentState = state;

    List<NotificationDataModel> oldPosts = [];
    if (currentState is LoadNotificationsState && !reset) {
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
    emit(const RemoveNotificationsLoadingState());

    final possibleData = await _repository.removeNotificationsAPI();
    if (possibleData.isLeft()) {
      emit(ErrorLoadingNotificationsState(message: possibleData.getLeft()!.error));
      return;
    }
    emit(RemoveNotificationsState(message: possibleData.getRight()!));
    _page = 1;
    loadNotifications(reset: true);
  }

  bool get isListFetchingComplete => _isListFetchingComplete;
}
