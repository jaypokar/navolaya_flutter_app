import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navolaya_flutter/data/model/create_chat_model.dart';

import '../../../domain/chat_repository.dart';

part 'create_chat_event.dart';

part 'create_chat_state.dart';

class CreateChatBloc extends Bloc<CreateChatEvent, CreateChatState> {
  final ChatRepository _repository;

  CreateChatBloc(this._repository) : super(const CreateChatInitial()) {
    on<CreateChatEvent>((event, emit) async {
      emit(const CreateChatLoadingState());
      if (event is InitiateChatEvent) {
        final possibleData = await _repository.createChatAPI(userID: event.userID);

        final data = possibleData.fold(
          (l) => CreateChatErrorState(message: l.error),
          (r) => HandleCreateChatState(response: r),
        );
        emit(data);
      }
    });
  }
}
