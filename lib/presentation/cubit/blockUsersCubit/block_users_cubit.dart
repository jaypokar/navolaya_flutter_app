import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:navolaya_flutter/core/either_extension_function.dart';
import 'package:navolaya_flutter/data/model/block_user_model.dart';
import 'package:navolaya_flutter/domain/blocked_users_repository.dart';

import '../../../data/model/users_model.dart';

part 'block_users_state.dart';

class BlockUsersCubit extends Cubit<BlockUsersState> {
  int _page = 1;
  bool _isListFetchingComplete = false;
  final BlockedUserRepository _repository;

  BlockUsersCubit(this._repository) : super(const BlockUsersInitial());

  void loadUsers({bool reset = false}) async {
    if (state is LoadingBlockedUsersState) return;

    final currentState = state;

    List<UserDataModel> oldPosts = [];
    if (currentState is LoadBlockUsersState && !reset) {
      oldPosts = currentState.usersData;
    }

    emit(LoadingBlockedUsersState(oldPosts, isFirstFetch: _page == 1));

    final possibleData = await _repository.fetchBlockedUsersAPI(page: _page);

    if (possibleData.isLeft()) {
      emit(ErrorLoadingBlockUsersState(message: possibleData.getLeft()!.error));
      return;
    }

    if (possibleData.getRight()!.data != null) {
      _isListFetchingComplete = !possibleData.getRight()!.data!.hasNextPage!;
    }

    _page++;
    final List<UserDataModel> users = reset ? [] : (state as LoadingBlockedUsersState).oldUsers;
    users.addAll(possibleData.getRight()!.data!.docs!);
    emit(LoadBlockUsersState(usersData: users));
  }

  void blockUser({required String userID, required String reason}) async {
    emit(const BlockUserLoadingState());

    final possibleData = await _repository.blockUserAPI(userID: userID, reason: reason);
    if (possibleData.isLeft()) {
      emit(ErrorLoadingBlockUsersState(message: possibleData.getLeft()!.error));
      return;
    }
    emit(BlockUserResponseState(response: possibleData.getRight()!));
  }

  void unBlockUser(String userID) async {
    emit(const UnBlockUserLoadingState());

    final possibleData = await _repository.unBlockUserAPI(userID: userID);
    if (possibleData.isLeft()) {
      emit(ErrorLoadingBlockUsersState(message: possibleData.getLeft()!.error));
      return;
    }
    emit(UnBlockUserState(response: possibleData.getRight()!));
    _page = 1;
    loadUsers(reset: true);
  }

  bool get isListFetchingComplete => _isListFetchingComplete;
}
