import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navolaya_flutter/core/either_extension_function.dart';

import '../../../data/model/users_model.dart';
import '../../../domain/users_repository.dart';

part 'users_verifications_state.dart';

class UsersVerificationsCubit extends Cubit<UsersVerificationsState> {
  int _page = 1;
  bool _isListFetchingComplete = false;
  final UsersRepository _repository;

  UsersVerificationsCubit(this._repository) : super(const UsersVerificationsInitial());

  void loadUsers({bool reset = false, bool update = true}) async {
    if (reset || update) {
      _page = 1;
    }
    if (state is LoadingUsersVerificationsState || _isListFetchingComplete && !reset && !update)
      return;

    final currentState = state;

    List<UserDataModel> oldPosts = [];
    if (currentState is LoadUsersVerificationsState && _page != 1) {
      oldPosts = currentState.usersData;
    }

    if (!update) {
      emit(LoadingUsersVerificationsState(oldPosts, isFirstFetch: _page == 1));
    }

    final possibleData = await _repository.fetchUsersVerificationsAPI(page: _page);

    if (possibleData.isLeft()) {
      emit(ErrorLoadingUsersVerificationsState(message: possibleData.getLeft()!.error));
      return;
    }

    if (possibleData.getRight()!.data != null) {
      _isListFetchingComplete = !possibleData.getRight()!.data!.hasNextPage!;
    }

    _page++;
    late final List<UserDataModel> users;
    if (state is LoadingUsersVerificationsState) {
      users = (state as LoadingUsersVerificationsState).oldUsers;
    } else {
      users = [];
    }
    users.addAll(possibleData.getRight()!.data!.docs!);
    emit(LoadUsersVerificationsState(usersData: users));
  }

  void updateUserVerificationRequest(String acceptOrDecline, String userID) async {
    emit(const UpdateVerificationLoadingState());

    final possibleData =
        await _repository.updateUsersVerificationsAPI(action: acceptOrDecline, userID: userID);
    if (possibleData.isLeft()) {
      emit(ErrorLoadingUsersVerificationsState(message: possibleData.getLeft()!.error));
      return;
    }

    loadUsers(update: true);
  }

  bool get isListFetchingComplete => _isListFetchingComplete;
}
