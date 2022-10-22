import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navolaya_flutter/core/either_extension_function.dart';
import 'package:navolaya_flutter/data/model/reported_user_model.dart';
import 'package:navolaya_flutter/domain/report_user_repository.dart';

import '../../../data/model/report_user_model.dart';

part 'report_users_state.dart';

class ReportUsersCubit extends Cubit<ReportUsersState> {
  int _page = 1;
  bool _isListFetchingComplete = false;
  final ReportUserRepository _repository;

  ReportUsersCubit(this._repository) : super(const ReportUsersInitial());

  void loadUsers({bool reset = false, bool update = false}) async {
    if (reset || update) {
      _page = 1;
    }
    if (state is LoadingReportedUsersState || _isListFetchingComplete && !reset && update) return;

    final currentState = state;

    List<ReportedUserData> oldPosts = [];
    if (currentState is LoadReportedUsersState && _page != 1) {
      oldPosts = currentState.usersData;
    }

    if (!update) {
      emit(LoadingReportedUsersState(oldPosts, isFirstFetch: _page == 1));
    }

    final possibleData = await _repository.fetchReportedUsersAPI(page: _page);

    if (possibleData.isLeft()) {
      emit(ErrorLoadingReportedUsersState(message: possibleData.getLeft()!.error));
      return;
    }

    if (possibleData.getRight()!.data != null) {
      _isListFetchingComplete = !possibleData.getRight()!.data!.hasNextPage!;
    }

    _page++;
    late final List<ReportedUserData> users;
    if (state is LoadingReportedUsersState) {
      users = (state as LoadingReportedUsersState).oldUsers;
    } else {
      users = [];
    }
    users.addAll(possibleData.getRight()!.data!.docs!);
    emit(LoadReportedUsersState(usersData: users));
  }

  void reportUser({required String userID, required String reason}) async {
    emit(const ReportUserLoadingState());

    final possibleData = await _repository.reportUserAPI(userID: userID, reason: reason);
    if (possibleData.isLeft()) {
      emit(ErrorLoadingReportedUsersState(message: possibleData.getLeft()!.error));
      return;
    }
    emit(ReportUserResponseState(response: possibleData.getRight()!));
  }

  bool get isListFetchingComplete => _isListFetchingComplete;
}
