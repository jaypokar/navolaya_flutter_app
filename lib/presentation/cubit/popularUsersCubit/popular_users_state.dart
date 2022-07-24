part of 'popular_users_cubit.dart';

abstract class PopularUsersState extends Equatable {
  const PopularUsersState();
}

class PopularUsersInitial extends PopularUsersState {
  const PopularUsersInitial();

  @override
  List<Object> get props => [];
}

class LoadingPopularUsersState extends PopularUsersState {
  final List<UserDataModel> oldUsers;
  final bool isFirstFetch;

  const LoadingPopularUsersState(this.oldUsers, {this.isFirstFetch = false});

  @override
  List<Object> get props => [oldUsers, isFirstFetch];
}

class LoadPopularUsersState extends PopularUsersState {
  final List<UserDataModel> usersData;

  const LoadPopularUsersState({required this.usersData});

  @override
  List<Object> get props => [usersData];
}

class ErrorLoadingPopularUsersState extends PopularUsersState {
  final String message;

  const ErrorLoadingPopularUsersState({required this.message});

  @override
  List<Object> get props => [message];
}
