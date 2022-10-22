part of 'report_users_cubit.dart';

abstract class ReportUsersState extends Equatable {
  const ReportUsersState();
}

class ReportUsersInitial extends ReportUsersState {
  const ReportUsersInitial();

  @override
  List<Object> get props => [];
}

class LoadingReportedUsersState extends ReportUsersState {
  final List<ReportedUserData> oldUsers;
  final bool isFirstFetch;
  final bool isFinalData;

  const LoadingReportedUsersState(this.oldUsers,
      {this.isFirstFetch = false, this.isFinalData = false});

  @override
  List<Object> get props => [oldUsers, isFirstFetch, isFinalData];
}

class LoadReportedUsersState extends ReportUsersState {
  final List<ReportedUserData> usersData;

  const LoadReportedUsersState({required this.usersData});

  @override
  List<Object> get props => [usersData];
}

class UnReportUserLoadingState extends ReportUsersState {
  const UnReportUserLoadingState();

  @override
  List<Object> get props => [];
}

class ReportUserLoadingState extends ReportUsersState {
  const ReportUserLoadingState();

  @override
  List<Object> get props => [];
}

class ReportUserResponseState extends ReportUsersState {
  final ReportUserModel response;

  const ReportUserResponseState({required this.response});

  @override
  List<Object> get props => [response];
}

class UnReportUserState extends ReportUsersState {
  final ReportUserModel response;

  const UnReportUserState({required this.response});

  @override
  List<Object> get props => [response];
}

class ErrorLoadingReportedUsersState extends ReportUsersState {
  final String message;

  const ErrorLoadingReportedUsersState({required this.message});

  @override
  List<Object> get props => [message];
}
