part of 'block_users_cubit.dart';

abstract class BlockUsersState extends Equatable {
  const BlockUsersState();
}

class BlockUsersInitial extends BlockUsersState {
  const BlockUsersInitial();

  @override
  List<Object> get props => [];
}

class LoadingBlockedUsersState extends BlockUsersState {
  final List<UserDataModel> oldUsers;
  final bool isFirstFetch;
  final bool isFinalData;

  const LoadingBlockedUsersState(this.oldUsers,
      {this.isFirstFetch = false, this.isFinalData = false});

  @override
  List<Object> get props => [oldUsers, isFirstFetch, isFinalData];
}

class LoadBlockUsersState extends BlockUsersState {
  final List<UserDataModel> usersData;

  const LoadBlockUsersState({required this.usersData});

  @override
  List<Object> get props => [usersData];
}

class UnBlockUserLoadingState extends BlockUsersState {
  const UnBlockUserLoadingState();

  @override
  List<Object> get props => [];
}

class BlockUserLoadingState extends BlockUsersState {
  const BlockUserLoadingState();

  @override
  List<Object> get props => [];
}

class BlockUserResponseState extends BlockUsersState {
  final BlockUserModel response;

  const BlockUserResponseState({required this.response});

  @override
  List<Object> get props => [response];
}

class UnBlockUserState extends BlockUsersState {
  final BlockUserModel response;

  const UnBlockUserState({required this.response});

  @override
  List<Object> get props => [response];
}

class ErrorLoadingBlockUsersState extends BlockUsersState {
  final String message;

  const ErrorLoadingBlockUsersState({required this.message});

  @override
  List<Object> get props => [message];
}
