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

  const UpdateConnectionRequestEvent({required this.userID, required this.acceptOrCancel});

  @override
  List<Object?> get props => [userID, acceptOrCancel];
}

class RemoveConnectionEvent extends UserConnectionsEvent {
  final String userID;

  const RemoveConnectionEvent({required this.userID});

  @override
  List<Object?> get props => [userID];
}

class GetConnectionsEvent extends UserConnectionsEvent {
  final String requestType;
  final int page;

  const GetConnectionsEvent({required this.requestType, required this.page});

  @override
  List<Object?> get props => [requestType, page];
}
