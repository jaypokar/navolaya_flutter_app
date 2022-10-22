import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navolaya_flutter/core/either_extension_function.dart';
import 'package:navolaya_flutter/data/model/chat_and_messag_info_model.dart';

import '../../../data/model/chat_model.dart';
import '../../../domain/chat_repository.dart';

part 'get_chats_state.dart';

class GetChatsCubit extends Cubit<GetChatsState> {
  int _page = 1;
  bool _isListFetchingComplete = false;
  final ChatRepository _repository;

  GetChatsCubit(this._repository) : super(const GetChatsInitial());

  void loadChats({bool reset = false}) async {
    if (reset) {
      _page = 1;
    }
    if (state is GetChatsLoadingState || _isListFetchingComplete && !reset) return;

    final currentState = state;

    List<Chat> oldChats = [];
    if (currentState is LoadChatsState && _page != 1) {
      oldChats = currentState.chats;
    }

    emit(GetChatsLoadingState(oldChats: oldChats, isFirstFetch: _page == 1));

    final possibleData = await _repository.getChatsAPI(page: _page);

    if (possibleData.isLeft()) {
      emit(ChatErrorState(message: possibleData.getLeft()!.error));
      return;
    }

    if (possibleData.getRight()!.data != null) {
      _isListFetchingComplete = !possibleData.getRight()!.data!.hasNextPage!;
    }

    _page++;
    final chats = (state as GetChatsLoadingState).oldChats;
    chats.addAll(possibleData.getRight()!.data!.docs!);
    emit(LoadChatsState(chats: chats));
  }

  void chatMessageReceived(ChatAndMessageInfoModel chatMessages) {
    final chat = chatMessages.chat!;
    if (state is LoadChatsState) {
      final chats = (state as LoadChatsState).chats;
      bool chatExists = chats.any((element) => element.id == chat.id!);
      if (chatExists) {
        for (int i = 0; i < chats.length; i++) {
          if (chat.id == chats[i].id) {
            chats.removeAt(i);
            chats.insert(0, chat);
            break;
          }
        }
      } else {
        chats.insert(0, chat);
      }
      emit(GetChatsLoadingState(oldChats: chats, isFirstFetch: false));
      emit(LoadChatsState(chats: chats));
    }
  }

  void updateChatPosition(Chat chat) {
    final sendChat = chat;
    if (state is LoadChatsState) {
      final chats = (state as LoadChatsState).chats;
      chats.removeWhere((element) => element.id! == chat.id!);
      chats.insert(0, sendChat);
      emit(GetChatsLoadingState(oldChats: chats, isFirstFetch: false));
      emit(LoadChatsState(chats: chats));
    }
  }

  bool get isListFetchingComplete => _isListFetchingComplete;
}
