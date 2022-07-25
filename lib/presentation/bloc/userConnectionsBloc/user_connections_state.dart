part of 'user_connections_bloc.dart';

abstract class UserConnectionsState extends Equatable {
  const UserConnectionsState();
}

class UserConnectionsInitial extends UserConnectionsState {
  @override
  List<Object> get props => [];

  const UserConnectionsInitial();
}

class UserConnectionLoadingState extends UserConnectionsState {
  const UserConnectionLoadingState();

  @override
  List<Object> get props => [];
}

class CreateConnectionsState extends UserConnectionsState {
  final CreateOrUpdateConnectionRequestModel createOrUpdateConnectionRequestResponse;

  const CreateConnectionsState({required this.createOrUpdateConnectionRequestResponse});

  @override
  List<Object> get props => [createOrUpdateConnectionRequestResponse];
}

class UpdateConnectionsState extends UserConnectionsState {
  final CreateOrUpdateConnectionRequestModel createOrUpdateConnectionRequestResponse;

  const UpdateConnectionsState({required this.createOrUpdateConnectionRequestResponse});

  @override
  List<Object> get props => [createOrUpdateConnectionRequestResponse];
}

class RemoveConnectionsState extends UserConnectionsState {
  final CreateOrUpdateConnectionRequestModel createOrUpdateConnectionRequestResponse;

  const RemoveConnectionsState({required this.createOrUpdateConnectionRequestResponse});

  @override
  List<Object> get props => [createOrUpdateConnectionRequestResponse];
}

class GetConnectionsState extends UserConnectionsState {
  final UsersModel usersResponse;

  const GetConnectionsState({required this.usersResponse});

  @override
  List<Object> get props => [usersResponse];
}

class UserConnectionErrorState extends UserConnectionsState {
  final String error;

  const UserConnectionErrorState({required this.error});

  @override
  List<Object> get props => [error];
}
