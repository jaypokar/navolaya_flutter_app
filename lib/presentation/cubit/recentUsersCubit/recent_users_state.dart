part of 'recent_users_cubit.dart';

abstract class RecentUsersState extends Equatable {
  const RecentUsersState();
}

class UsersInitial extends RecentUsersState {
  @override
  List<Object> get props => [];
}

class LoadingUsersState extends RecentUsersState {
  final List<UserDataModel> oldUsers;
  final bool isFirstFetch;

  const LoadingUsersState(this.oldUsers, {this.isFirstFetch = false});

  @override
  List<Object> get props => [oldUsers, isFirstFetch];
}

class LoadUsersState extends RecentUsersState {
  final List<UserDataModel> usersData;

  const LoadUsersState({required this.usersData});

  @override
  List<Object> get props => [usersData];
}

class ErrorLoadingUsersState extends RecentUsersState {
  final String message;

  const ErrorLoadingUsersState({required this.message});

  @override
  List<Object> get props => [message];
}
