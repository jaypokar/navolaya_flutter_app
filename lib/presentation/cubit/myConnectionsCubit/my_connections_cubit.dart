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

  void loadUsers({bool reset = false, bool update = false}) async {
    if (reset || update) {
      _page = 1;
    }
    if (state is LoadingMyConnectionsState || _isListFetchingComplete && !reset && !update) return;

    final currentState = state;

    List<UserDataModel> oldPosts = [];
    if (currentState is LoadMyConnectionsState && _page != 1) {
      oldPosts = currentState.usersData;
    }

    if (!update) {
      emit(LoadingMyConnectionsState(oldPosts, isFirstFetch: _page == 1));
    }

    final possibleData = await _repository.fetchMyConnectionsAPI(page: _page);

    if (possibleData.isLeft()) {
      emit(ErrorLoadingMyConnectionsState(message: possibleData.getLeft()!.error));
      return;
    }

    if (possibleData.getRight()!.data != null) {
      _isListFetchingComplete = !possibleData.getRight()!.data!.hasNextPage!;
    }

    _page++;
    late final List<UserDataModel> users;
    if (state is LoadingMyConnectionsState) {
      users = (state as LoadingMyConnectionsState).oldUsers;
    } else {
      users = [];
    }
    users.addAll(possibleData.getRight()!.data!.docs!);
    emit(LoadMyConnectionsState(usersData: users));
  }

  void removeMyConnection(String userID) async {
    emit(const RemoveLoadingState());
    final possibleData = await _repository.removeConnectionAPI(userID);
    if (possibleData.isLeft()) {
      emit(ErrorLoadingMyConnectionsState(message: possibleData.getLeft()!.error));
      return;
    }
    loadUsers(update: true);
  }

  bool get isListFetchingComplete => _isListFetchingComplete;
}
