import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navolaya_flutter/core/either_extension_function.dart';

import '../../../data/model/create_or_update_connection_request_model.dart';
import '../../../data/model/users_model.dart';
import '../../../domain/user_connections_repository.dart';

part 'connection_received_state.dart';

class ConnectionReceivedCubit extends Cubit<ConnectionReceivedState> {
  int _page = 1;
  bool _isListFetchingComplete = false;
  final UserConnectionsRepository _repository;

  ConnectionReceivedCubit(this._repository) : super(const ConnectionReceivedInitial());

  void loadUsers({bool reset = false, bool update = false}) async {
    if (reset || update) {
      _page = 1;
    }
    if (state is LoadingConnectionReceivedState || _isListFetchingComplete && !reset && !update)
      return;

    final currentState = state;

    List<UserDataModel> oldPosts = [];
    if (currentState is LoadConnectionReceivedState && _page != 1) {
      oldPosts = currentState.usersData;
    }

    if (!update) {
      emit(LoadingConnectionReceivedState(oldPosts, isFirstFetch: _page == 1));
    }

    final possibleData = await _repository.getConnectionsAPI('received', page: _page);

    if (possibleData.isLeft()) {
      emit(ErrorLoadingConnectionReceivedState(message: possibleData.getLeft()!.error));
      return;
    }

    if (possibleData.getRight()!.data != null) {
      _isListFetchingComplete = !possibleData.getRight()!.data!.hasNextPage!;
    }

    _page++;
    late final List<UserDataModel> users;
    if (state is LoadingConnectionReceivedState) {
      users = (state as LoadingConnectionReceivedState).oldUsers;
    } else {
      users = [];
    }
    users.addAll(possibleData.getRight()!.data!.docs!);
    emit(LoadConnectionReceivedState(usersData: users));
  }

  void updateConnection(String acceptOrCancel, String userID) async {
    emit(const UpdateConnectionLoadingState());

    final possibleData = await _repository.updateConnectionRequestAPI(acceptOrCancel, userID);
    if (possibleData.isLeft()) {
      emit(ErrorLoadingConnectionReceivedState(message: possibleData.getLeft()!.error));
      return;
    }

    loadUsers(update: true);
  }

  bool get isListFetchingComplete => _isListFetchingComplete;
}
