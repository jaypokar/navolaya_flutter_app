import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
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

  void loadUsers({bool reset = false}) async {
    if (state is LoadingConnectionSentState) return;

    final currentState = state;

    List<UserDataModel> oldPosts = [];
    if (currentState is LoadConnectionSentState && !reset) {
      oldPosts = currentState.usersData;
    }

    emit(LoadingConnectionSentState(oldPosts, isFirstFetch: _page == 1));

    final possibleData = await _repository.getConnectionsAPI('sent', page: _page);

    if (possibleData.isLeft()) {
      emit(ErrorLoadingConnectionSentState(message: possibleData.getLeft()!.error));
      return;
    }

    if (possibleData.getRight()!.data != null) {
      _isListFetchingComplete = !possibleData.getRight()!.data!.hasNextPage!;
    }

    _page++;
    final List<UserDataModel> users = reset ? [] : (state as LoadingConnectionSentState).oldUsers;
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
    emit(UpdateSentConnectionState(
        createOrUpdateConnectionRequestResponse: possibleData.getRight()!));
    _page = 1;
    loadUsers(reset: true);
  }

  bool get isListFetchingComplete => _isListFetchingComplete;
}
