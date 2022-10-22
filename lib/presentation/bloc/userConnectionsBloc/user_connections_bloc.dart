import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navolaya_flutter/data/model/create_or_update_connection_request_model.dart';
import 'package:navolaya_flutter/data/model/update_user_viewed_model.dart';
import 'package:navolaya_flutter/data/model/users_model.dart';
import 'package:navolaya_flutter/domain/users_repository.dart';

import '../../../core/logger.dart';
import '../../../domain/user_connections_repository.dart';

part 'user_connections_event.dart';
part 'user_connections_state.dart';

class UserConnectionsBloc extends Bloc<UserConnectionsEvent, UserConnectionsState> {
  final UserConnectionsRepository _repository;
  final UsersRepository _userRepository;

  UserConnectionsBloc(this._repository, this._userRepository)
      : super(const UserConnectionsInitial()) {
    on<UserConnectionsEvent>((event, emit) async {
      try {
        if (event is UpdateUserViewedEvent) {
          final possibleData = await _userRepository.updateUsersViewedAPI(userID: event.userID);
          emit(possibleData.fold(
            (l) => UserConnectionErrorState(error: l.error),
            (r) => UpdateUserViewedState(response: r),
          ));
        } else {
          emit(const UserConnectionLoadingState());

          late final UserConnectionsState data;

          if (event is CreateConnectionsEvent) {
            final possibleData = await _repository.createConnectionRequestAPI(event.userID);
            data = possibleData.fold(
              (l) => UserConnectionErrorState(error: l.error),
              (r) => CreateConnectionsState(createOrUpdateConnectionRequestResponse: r),
            );
          } else if (event is UpdateConnectionRequestEvent) {
            await Future.delayed(const Duration(seconds: 5));
            final possibleData =
                await _repository.updateConnectionRequestAPI(event.acceptOrCancel, event.userID);
            data = possibleData.fold(
              (l) => UserConnectionErrorState(error: l.error),
              (r) => UpdateConnectionsState(
                  createOrUpdateConnectionRequestResponse: r,
                  isRequestAccepted: event.isRequestAccepted),
            );
          } else if (event is RemoveConnectionEvent) {
            final possibleData = await _repository.removeConnectionAPI(event.userID);
            data = possibleData.fold(
              (l) => UserConnectionErrorState(error: l.error),
              (r) => RemoveConnectionsState(createOrUpdateConnectionRequestResponse: r),
            );
          }
          emit(data);
        }
      } catch (e) {
        logger.e(e.toString());
        emit(UserConnectionErrorState(error: e.toString()));
      }
    });
  }
}
