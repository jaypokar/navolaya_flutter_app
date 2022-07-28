part of 'connection_received_cubit.dart';

abstract class ConnectionReceivedState extends Equatable {
  const ConnectionReceivedState();
}

class ConnectionReceivedInitial extends ConnectionReceivedState {
  const ConnectionReceivedInitial();

  @override
  List<Object> get props => [];
}

class LoadingConnectionReceivedState extends ConnectionReceivedState {
  final List<UserDataModel> oldUsers;
  final bool isFirstFetch;
  final bool isFinalData;

  const LoadingConnectionReceivedState(this.oldUsers,
      {this.isFirstFetch = false, this.isFinalData = false});

  @override
  List<Object> get props => [oldUsers, isFirstFetch, isFinalData];
}

class LoadConnectionReceivedState extends ConnectionReceivedState {
  final List<UserDataModel> usersData;

  const LoadConnectionReceivedState({required this.usersData});

  @override
  List<Object> get props => [usersData];
}

class UpdateConnectionLoadingState extends ConnectionReceivedState {
  const UpdateConnectionLoadingState();

  @override
  List<Object> get props => [];
}

class UpdateReceivedConnectionState extends ConnectionReceivedState {
  final CreateOrUpdateConnectionRequestModel createOrUpdateConnectionRequestResponse;

  const UpdateReceivedConnectionState({required this.createOrUpdateConnectionRequestResponse});

  @override
  List<Object> get props => [createOrUpdateConnectionRequestResponse];
}

class ErrorLoadingConnectionReceivedState extends ConnectionReceivedState {
  final String message;

  const ErrorLoadingConnectionReceivedState({required this.message});

  @override
  List<Object> get props => [message];
}
