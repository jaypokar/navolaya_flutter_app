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

  void loadUsers({bool reset = false}) async {
    if (state is LoadingConnectionReceivedState) return;

    final currentState = state;

    List<UserDataModel> oldPosts = [];
    if (currentState is LoadConnectionReceivedState && !reset) {
      oldPosts = currentState.usersData;
    }

    emit(LoadingConnectionReceivedState(oldPosts, isFirstFetch: _page == 1));

    final possibleData = await _repository.getConnectionsAPI('received', page: _page);

    if (possibleData.isLeft()) {
      emit(ErrorLoadingConnectionReceivedState(message: possibleData.getLeft()!.error));
      return;
    }

    if (possibleData.getRight()!.data != null) {
      _isListFetchingComplete = !possibleData.getRight()!.data!.hasNextPage!;
    }

    _page++;
    final List<UserDataModel> users =
        reset ? [] : (state as LoadingConnectionReceivedState).oldUsers;
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
    emit(UpdateReceivedConnectionState(
        createOrUpdateConnectionRequestResponse: possibleData.getRight()!));
    _page = 1;
    loadUsers(reset: true);
  }

  bool get isListFetchingComplete => _isListFetchingComplete;
}
