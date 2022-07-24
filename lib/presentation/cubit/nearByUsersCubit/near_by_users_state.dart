part of 'near_by_users_cubit.dart';

abstract class NearByUsersState extends Equatable {
  const NearByUsersState();
}

class NearByUsersInitial extends NearByUsersState {
  @override
  List<Object> get props => [];
}

class LoadingNearByUsersState extends NearByUsersState {
  final List<UserDataModel> oldUsers;
  final bool isFirstFetch;

  const LoadingNearByUsersState(this.oldUsers, {this.isFirstFetch = false});

  @override
  List<Object> get props => [oldUsers, isFirstFetch];
}

class LoadNearByUsersState extends NearByUsersState {
  final List<UserDataModel> usersData;

  const LoadNearByUsersState({required this.usersData});

  @override
  List<Object> get props => [usersData];
}

class ErrorLoadingNearByUsersState extends NearByUsersState {
  final String title;
  final String message;

  const ErrorLoadingNearByUsersState({required this.title, required this.message});

  @override
  List<Object> get props => [title, message];
}
