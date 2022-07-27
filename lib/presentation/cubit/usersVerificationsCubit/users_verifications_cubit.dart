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

  void loadUsers({bool reset = false}) async {
    if (state is LoadingUsersVerificationsState) return;

    final currentState = state;

    List<UserDataModel> oldPosts = [];
    if (currentState is LoadUsersVerificationsState && !reset) {
      oldPosts = currentState.usersData;
    }

    emit(LoadingUsersVerificationsState(oldPosts, isFirstFetch: _page == 1));

    final possibleData = await _repository.fetchUsersVerificationsAPI(page: _page);

    if (possibleData.isLeft()) {
      emit(ErrorLoadingUsersVerificationsState(message: possibleData.getLeft()!.error));
      return;
    }

    if (possibleData.getRight()!.data != null) {
      _isListFetchingComplete = !possibleData.getRight()!.data!.hasNextPage!;
    }

    _page++;
    final users = (state as LoadingUsersVerificationsState).oldUsers;
    users.addAll(possibleData.getRight()!.data!.docs!);
    emit(LoadUsersVerificationsState(usersData: users));
  }

  void updateUserVerificationRequest(String acceptOrDecline, String userID) async {
    if (acceptOrDecline == 'confirm') {
      emit(const ConfirmLoadingState());
    } else {
      emit(const DeclineLoadingState());
    }

    final possibleData =
        await _repository.updateUsersVerificationsAPI(action: acceptOrDecline, userID: userID);
    if (possibleData.isLeft()) {
      emit(ErrorLoadingUsersVerificationsState(message: possibleData.getLeft()!.error));
    }
    _page = 1;
    loadUsers(reset: true);
  }

  bool get isListFetchingComplete => _isListFetchingComplete;
}
