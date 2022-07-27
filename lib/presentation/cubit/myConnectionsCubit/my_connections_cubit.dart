import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navolaya_flutter/core/either_extension_function.dart';
import 'package:navolaya_flutter/domain/user_connections_repository.dart';

import '../../../data/model/create_or_update_connection_request_model.dart';
import '../../../data/model/users_model.dart';

part 'my_connections_state.dart';

class MyConnectionsCubit extends Cubit<MyConnectionsState> {
  int _page = 1;
  bool _isListFetchingComplete = false;
  final UserConnectionsRepository _repository;

  MyConnectionsCubit(this._repository) : super(const MyConnectionsInitial());

  void loadUsers({bool reset = false}) async {
    if (state is LoadingMyConnectionsState) return;

    final currentState = state;

    List<UserDataModel> oldPosts = [];
    if (currentState is LoadMyConnectionsState && !reset) {
      oldPosts = currentState.usersData;
    }

    emit(LoadingMyConnectionsState(oldPosts, isFirstFetch: _page == 1));

    final possibleData = await _repository.fetchMyConnectionsAPI(page: _page);

    if (possibleData.isLeft()) {
      emit(ErrorLoadingMyConnectionsState(message: possibleData.getLeft()!.error));
      return;
    }

    if (possibleData.getRight()!.data != null) {
      _isListFetchingComplete = !possibleData.getRight()!.data!.hasNextPage!;
    }

    _page++;
    final users = (state as LoadingMyConnectionsState).oldUsers;
    users.addAll(possibleData.getRight()!.data!.docs!);
    emit(LoadMyConnectionsState(usersData: users));
  }

  void removeMyConnection(String userID) async {
    emit(const RemoveLoadingState());
    final possibleData = await _repository.removeConnectionAPI(userID);
    if (possibleData.isLeft()) {
      emit(ErrorLoadingMyConnectionsState(message: possibleData.getLeft()!.error));
    }
    emit(
        RemoveMyConnectionState(createOrUpdateConnectionRequestResponse: possibleData.getRight()!));
    _page = 1;
    loadUsers(reset: true);
  }

  bool get isListFetchingComplete => _isListFetchingComplete;
}
