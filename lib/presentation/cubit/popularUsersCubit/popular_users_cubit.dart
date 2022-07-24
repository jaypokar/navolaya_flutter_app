import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navolaya_flutter/core/either_extension_function.dart';

import '../../../data/model/filter_data_request_model.dart';
import '../../../data/model/users_model.dart';
import '../../../domain/users_repository.dart';

part 'popular_users_state.dart';

class PopularUsersCubit extends Cubit<PopularUsersState> {
  int page = 1;
  final UsersRepository _repository;

  PopularUsersCubit(this._repository) : super(const PopularUsersInitial());

  void loadUsers() async {
    if (state is LoadingPopularUsersState) return;

    final currentState = state;

    List<UserDataModel> oldPosts = [];
    if (currentState is LoadPopularUsersState) {
      oldPosts = currentState.usersData;
    }

    emit(LoadingPopularUsersState(oldPosts, isFirstFetch: page == 1));

    final possibleData = await _repository.fetchPopularUsersAPI(
        filterDataRequestData: FilterDataRequestModel(page: page));

    if (possibleData.isLeft()) {
      emit(ErrorLoadingPopularUsersState(message: possibleData.getLeft()!.error));
      return;
    }
    page++;
    final users = (state as LoadingPopularUsersState).oldUsers;
    users.addAll(possibleData.getRight()!.data!.docs!);
    emit(LoadPopularUsersState(usersData: users));
  }

  void filterList({required FilterDataRequestModel filterData}) async {
    emit(LoadingPopularUsersState(const [], isFirstFetch: page == 1));

    final possibleData = await _repository.fetchPopularUsersAPI(filterDataRequestData: filterData);

    if (possibleData.isLeft()) {
      emit(ErrorLoadingPopularUsersState(message: possibleData.getLeft()!.error));
      return;
    }
    page++;
    final List<UserDataModel> users = [];
    users.addAll(possibleData.getRight()!.data!.docs!);
    emit(LoadPopularUsersState(usersData: users));
  }
}
