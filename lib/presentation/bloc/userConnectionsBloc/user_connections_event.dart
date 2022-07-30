part of 'user_connections_bloc.dart';

abstract class UserConnectionsEvent extends Equatable {
  const UserConnectionsEvent();
}

class CreateConnectionsEvent extends UserConnectionsEvent {
  final String userID;

  const CreateConnectionsEvent({required this.userID});

  @override
  List<Object?> get props => [userID];
}

class UpdateConnectionRequestEvent extends UserConnectionsEvent {
  final String userID;
  final String acceptOrCancel;
  final bool isRequestAccepted;

  const UpdateConnectionRequestEvent(
      {required this.userID, required this.acceptOrCancel, required this.isRequestAccepted});

  @override
  List<Object?> get props => [userID, acceptOrCancel, isRequestAccepted];
}

class RemoveConnectionEvent extends UserConnectionsEvent {
  final String userID;

  const RemoveConnectionEvent({required this.userID});

  @override
  List<Object?> get props => [userID];
}
