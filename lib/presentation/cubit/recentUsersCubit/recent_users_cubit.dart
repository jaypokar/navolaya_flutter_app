import 'dart:core';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navolaya_flutter/core/either_extension_function.dart';
import 'package:navolaya_flutter/data/model/filter_data_request_model.dart';
import 'package:navolaya_flutter/data/model/users_model.dart';
import 'package:navolaya_flutter/domain/users_repository.dart';

part 'recent_users_state.dart';

class RecentUsersCubit extends Cubit<RecentUsersState> {
  int _page = 1;
  bool _isListFetchingComplete = false;
  final UsersRepository _repository;

  RecentUsersCubit(this._repository) : super(const UsersInitial());

  void loadUsers() async {
    if (state is LoadingUsersState) return;

    final currentState = state;

    List<UserDataModel> oldPosts = [];
    if (currentState is LoadUsersState) {
      oldPosts = currentState.usersData;
    }

    emit(LoadingUsersState(oldPosts, isFirstFetch: _page == 1));

    final possibleData = await _repository.fetchRecentUsersAPI(
        filterDataRequestData: FilterDataRequestModel(page: _page));

    if (possibleData.isLeft()) {
      emit(ErrorLoadingUsersState(message: possibleData.getLeft()!.error));
      return;
    }

    if (possibleData.getRight()!.data != null) {
      _isListFetchingComplete = !possibleData.getRight()!.data!.hasNextPage!;
    }

    _page++;
    final users = (state as LoadingUsersState).oldUsers;
    users.addAll(possibleData.getRight()!.data!.docs!);
    emit(LoadUsersState(usersData: users));
  }

  bool get isListFetchingComplete => _isListFetchingComplete;

  void filterList({required FilterDataRequestModel filterData}) async {
    emit(LoadingUsersState(const [], isFirstFetch: _page == 1));

    final possibleData = await _repository.fetchRecentUsersAPI(filterDataRequestData: filterData);

    if (possibleData.isLeft()) {
      emit(ErrorLoadingUsersState(message: possibleData.getLeft()!.error));
      return;
    }
    _page++;
    final List<UserDataModel> users = [];
    users.addAll(possibleData.getRight()!.data!.docs!);
    emit(LoadUsersState(usersData: users));
  }

  Future<void> clearFilter() async {
    _repository.clearFilter();
    await Future.delayed(const Duration(seconds: 1));
    filterList(filterData: FilterDataRequestModel());
  }
}
