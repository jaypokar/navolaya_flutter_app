import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navolaya_flutter/core/either_extension_function.dart';
import 'package:navolaya_flutter/data/model/filter_data_request_model.dart';
import 'package:navolaya_flutter/data/model/users_model.dart';
import 'package:navolaya_flutter/domain/users_repository.dart';

part 'recent_users_state.dart';

class RecentUsersCubit extends Cubit<RecentUsersState> {
  int page = 1;
  final UsersRepository _repository;

  RecentUsersCubit(this._repository) : super(UsersInitial());

  void loadUsers() async {
    if (state is LoadingUsersState) return;

    final currentState = state;

    List<UserDataModel> oldPosts = [];
    if (currentState is LoadUsersState) {
      oldPosts = currentState.usersData;
    }

    emit(LoadingUsersState(oldPosts, isFirstFetch: page == 1));

    final possibleData = await _repository.fetchRecentUsersAPI(
        filterDataRequestData: FilterDataRequestModel(page: page));

    if (possibleData.isLeft()) {
      emit(ErrorLoadingUsersState(message: possibleData.getLeft()!.error));
      return;
    }
    page++;
    final users = (state as LoadingUsersState).oldUsers;
    users.addAll(possibleData.getRight()!.data!.docs!);
    emit(LoadUsersState(usersData: users));
  }

  void filterList({required FilterDataRequestModel filterData}) async {
    emit(LoadingUsersState(const [], isFirstFetch: page == 1));

    final possibleData = await _repository.fetchRecentUsersAPI(filterDataRequestData: filterData);

    if (possibleData.isLeft()) {
      emit(ErrorLoadingUsersState(message: possibleData.getLeft()!.error));
      return;
    }
    page++;
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
