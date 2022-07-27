part of 'my_connections_cubit.dart';

abstract class MyConnectionsState extends Equatable {
  const MyConnectionsState();
}

class MyConnectionsInitial extends MyConnectionsState {
  const MyConnectionsInitial();

  @override
  List<Object> get props => [];
}

class LoadingMyConnectionsState extends MyConnectionsState {
  final List<UserDataModel> oldUsers;
  final bool isFirstFetch;
  final bool isFinalData;

  const LoadingMyConnectionsState(this.oldUsers,
      {this.isFirstFetch = false, this.isFinalData = false});

  @override
  List<Object> get props => [oldUsers, isFirstFetch];
}

class LoadMyConnectionsState extends MyConnectionsState {
  final List<UserDataModel> usersData;

  const LoadMyConnectionsState({required this.usersData});

  @override
  List<Object> get props => [usersData];
}

class RemoveLoadingState extends MyConnectionsState {
  const RemoveLoadingState();

  @override
  List<Object> get props => [];
}

class RemoveMyConnectionState extends MyConnectionsState {
  final CreateOrUpdateConnectionRequestModel createOrUpdateConnectionRequestResponse;

  const RemoveMyConnectionState({required this.createOrUpdateConnectionRequestResponse});

  @override
  List<Object> get props => [createOrUpdateConnectionRequestResponse];
}

class ErrorLoadingMyConnectionsState extends MyConnectionsState {
  final String message;

  const ErrorLoadingMyConnectionsState({required this.message});

  @override
  List<Object> get props => [message];
}
