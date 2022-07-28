part of 'connection_sent_cubit.dart';

abstract class ConnectionSentState extends Equatable {
  const ConnectionSentState();
}

class ConnectionSentInitial extends ConnectionSentState {
  const ConnectionSentInitial();

  @override
  List<Object> get props => [];
}

class LoadingConnectionSentState extends ConnectionSentState {
  final List<UserDataModel> oldUsers;
  final bool isFirstFetch;
  final bool isFinalData;

  const LoadingConnectionSentState(this.oldUsers,
      {this.isFirstFetch = false, this.isFinalData = false});

  @override
  List<Object> get props => [oldUsers, isFirstFetch, isFinalData];
}

class LoadConnectionSentState extends ConnectionSentState {
  final List<UserDataModel> usersData;

  const LoadConnectionSentState({required this.usersData});

  @override
  List<Object> get props => [usersData];
}

class UpdateConnectionSentLoadingState extends ConnectionSentState {
  const UpdateConnectionSentLoadingState();

  @override
  List<Object> get props => [];
}

class UpdateSentConnectionState extends ConnectionSentState {
  final CreateOrUpdateConnectionRequestModel createOrUpdateConnectionRequestResponse;

  const UpdateSentConnectionState({required this.createOrUpdateConnectionRequestResponse});

  @override
  List<Object> get props => [createOrUpdateConnectionRequestResponse];
}

class ErrorLoadingConnectionSentState extends ConnectionSentState {
  final String message;

  const ErrorLoadingConnectionSentState({required this.message});

  @override
  List<Object> get props => [message];
}
