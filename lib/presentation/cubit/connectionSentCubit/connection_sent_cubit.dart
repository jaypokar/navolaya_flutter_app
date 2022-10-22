import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navolaya_flutter/core/either_extension_function.dart';

import '../../../data/model/create_or_update_connection_request_model.dart';
import '../../../data/model/users_model.dart';
import '../../../domain/user_connections_repository.dart';

part 'connection_sent_state.dart';

class ConnectionSentCubit extends Cubit<ConnectionSentState> {
  int _page = 1;
  bool _isListFetchingComplete = false;
  final UserConnectionsRepository _repository;

  ConnectionSentCubit(this._repository) : super(const ConnectionSentInitial());

  void loadUsers({bool reset = false, bool update = false}) async {
    if (reset || update) {
      _page = 1;
    }
    if (state is LoadingConnectionSentState || _isListFetchingComplete && !reset && !update) return;

    final currentState = state;

    List<UserDataModel> oldPosts = [];
    if (currentState is LoadConnectionSentState && _page != 1) {
      oldPosts = currentState.usersData;
    }

    if (!update) {
      emit(LoadingConnectionSentState(oldPosts, isFirstFetch: _page == 1));
    }

    final possibleData = await _repository.getConnectionsAPI('sent', page: _page);

    if (possibleData.isLeft()) {
      emit(ErrorLoadingConnectionSentState(message: possibleData.getLeft()!.error));
      return;
    }

    if (possibleData.getRight()!.data != null) {
      _isListFetchingComplete = !possibleData.getRight()!.data!.hasNextPage!;
    }

    _page++;
    late final List<UserDataModel> users;
    if (state is LoadingConnectionSentState) {
      users = (state as LoadingConnectionSentState).oldUsers;
    } else {
      users = [];
    }
    users.addAll(possibleData.getRight()!.data!.docs!);
    emit(LoadConnectionSentState(usersData: users));
  }

  void updateConnection(String userID) async {
    emit(const UpdateConnectionSentLoadingState());

    final possibleData = await _repository.updateConnectionRequestAPI('cancel', userID);
    if (possibleData.isLeft()) {
      emit(ErrorLoadingConnectionSentState(message: possibleData.getLeft()!.error));
      return;
    }
    loadUsers(update: true);
  }

  void updateUsersAfterBlockingOrCancelSenRequest(UserDataModel user) {
    final currentState = state;
    if (currentState is LoadConnectionSentState) {
      final users = currentState.usersData;
      users.remove(user);
      emit(LoadingConnectionSentState(users, isFirstFetch: false));
      emit(LoadConnectionSentState(usersData: users));
    }
  }

  bool get isListFetchingComplete => _isListFetchingComplete;
}
