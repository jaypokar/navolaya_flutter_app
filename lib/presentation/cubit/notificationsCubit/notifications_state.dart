part of 'notifications_cubit.dart';

abstract class NotificationsState extends Equatable {
  const NotificationsState();
}

class NotificationsInitial extends NotificationsState {
  @override
  List<Object> get props => [];

  const NotificationsInitial();
}

class LoadingNotificationsState extends NotificationsState {
  final List<NotificationDataModel> oldNotifications;
  final bool isFirstFetch;
  final bool isFinalData;

  const LoadingNotificationsState(this.oldNotifications,
      {this.isFirstFetch = false, this.isFinalData = false});

  @override
  List<Object> get props => [oldNotifications, isFirstFetch, isFinalData];
}

class LoadNotificationsState extends NotificationsState {
  final List<NotificationDataModel> notificationsData;

  const LoadNotificationsState({required this.notificationsData});

  @override
  List<Object> get props => [notificationsData];
}

class RemoveNotificationsLoadingState extends NotificationsState {
  const RemoveNotificationsLoadingState();

  @override
  List<Object> get props => [];
}

class RemoveNotificationsState extends NotificationsState {
  final String message;

  const RemoveNotificationsState({required this.message});

  @override
  List<Object> get props => [message];
}

class ErrorLoadingNotificationsState extends NotificationsState {
  final String message;

  const ErrorLoadingNotificationsState({required this.message});

  @override
  List<Object> get props => [message];
}
