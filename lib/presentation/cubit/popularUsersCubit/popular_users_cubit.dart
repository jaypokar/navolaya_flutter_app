import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navolaya_flutter/core/either_extension_function.dart';

import '../../../data/model/filter_data_request_model.dart';
import '../../../data/model/users_model.dart';
import '../../../domain/users_repository.dart';

part 'popular_users_state.dart';

class PopularUsersCubit extends Cubit<PopularUsersState> {
  int _page = 1;
  bool _isListFetchingComplete = false;
  final UsersRepository _repository;

  PopularUsersCubit(this._repository) : super(const PopularUsersInitial());

  void loadUsers({bool reset = false}) async {
    if (reset) {
      _page = 1;
    }
    if (state is LoadingPopularUsersState || _isListFetchingComplete && !reset) return;

    final currentState = state;

    List<UserDataModel> oldPosts = [];
    if (currentState is LoadPopularUsersState && _page != 1) {
      oldPosts = currentState.usersData;
    }

    emit(LoadingPopularUsersState(oldPosts, isFirstFetch: _page == 1));

    final possibleData = await _repository.fetchPopularUsersAPI(
        filterDataRequestData: FilterDataRequestModel(page: _page));

    if (possibleData.isLeft()) {
      emit(ErrorLoadingPopularUsersState(message: possibleData.getLeft()!.error));
      return;
    }

    if (possibleData.getRight()!.data != null) {
      _isListFetchingComplete = !possibleData.getRight()!.data!.hasNextPage!;
    }

    _page++;
    List<UserDataModel> users = (state as LoadingPopularUsersState).oldUsers;
    users.addAll(possibleData.getRight()!.data!.docs!);
    emit(LoadPopularUsersState(usersData: users));
  }

  bool get hasDataLoaded => state is PopularUsersInitial;

  bool get isListFetchingComplete => _isListFetchingComplete;

  void filterList({required FilterDataRequestModel filterData}) async {
    clearData();
    emit(LoadingPopularUsersState(const [], isFirstFetch: _page == 1));

    final possibleData = await _repository.fetchPopularUsersAPI(filterDataRequestData: filterData);

    if (possibleData.isLeft()) {
      emit(ErrorLoadingPopularUsersState(message: possibleData.getLeft()!.error));
      return;
    }
    _page++;
    final List<UserDataModel> users = [];
    users.addAll(possibleData.getRight()!.data!.docs!);
    emit(LoadPopularUsersState(usersData: users));
  }

  void updateUsersAfterBlockingUser(UserDataModel user) {
    final currentState = state;
    if (currentState is LoadPopularUsersState) {
      final users = currentState.usersData;
      users.remove(user);
      emit(LoadingPopularUsersState(users, isFirstFetch: false));
      emit(LoadPopularUsersState(usersData: users));
    }
  }

  void clearData() {
    _page = 1;
    _isListFetchingComplete = false;
  }
}
