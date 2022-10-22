part of 'users_verifications_cubit.dart';

abstract class UsersVerificationsState extends Equatable {
  const UsersVerificationsState();
}

class UsersVerificationsInitial extends UsersVerificationsState {
  @override
  List<Object> get props => [];

  const UsersVerificationsInitial();
}

class LoadingUsersVerificationsState extends UsersVerificationsState {
  final List<UserDataModel> oldUsers;
  final bool isFirstFetch;
  final bool isFinalData;

  const LoadingUsersVerificationsState(this.oldUsers,
      {this.isFirstFetch = false, this.isFinalData = false});

  @override
  List<Object> get props => [oldUsers, isFirstFetch];
}

class LoadUsersVerificationsState extends UsersVerificationsState {
  final List<UserDataModel> usersData;

  const LoadUsersVerificationsState({required this.usersData});

  @override
  List<Object> get props => [usersData];
}

class UpdateVerificationLoadingState extends UsersVerificationsState {
  const UpdateVerificationLoadingState();

  @override
  List<Object> get props => [];
}

class ErrorLoadingUsersVerificationsState extends UsersVerificationsState {
  final String message;

  const ErrorLoadingUsersVerificationsState({required this.message});

  @override
  List<Object> get props => [message];
}
