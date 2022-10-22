import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navolaya_flutter/core/either_extension_function.dart';
import 'package:navolaya_flutter/data/model/chat_messages_model.dart';
import 'package:navolaya_flutter/util/common_functions.dart';

import '../../../domain/chat_repository.dart';
import '../../../injection_container.dart';

part 'chat_messages_event.dart';

part 'chat_messages_state.dart';

class ChatMessagesBloc extends Bloc<ChatMessagesEvent, ChatMessagesState> {
  int _page = 1;
  bool _isListFetchingComplete = false;
  bool _hasChatInitiated = false;
  final ChatRepository _repository;

  ChatMessagesBloc(this._repository) : super(const ChatMessagesInitial()) {
    on<ChatMessagesEvent>((event, emit) async {
      if (event is SendMessageEvent) {
        _hasChatInitiated = true;
        addMessageToUi(emit, event.message, 'right');
      } else if (event is GetMessagesEvent) {
        if (state is ChatMessagesLoadingState || _isListFetchingComplete) return;
        _getChatMessages(event, emit);
      } else if (event is HandleMessagesErrorEvent) {
        emit(ChatMessagesErrorState(message: event.message));
      } else if (event is HandleMessagesEvent) {
        emit(LoadChatMessagesState(messages: event.messages));
      } else if (event is HandleReceivedMessagesEvent) {
        _hasChatInitiated = true;
        addMessageToUi(emit, event.message.messageText!, 'left');
      }
    });
  }

  String getLastMessage() {
    final currentState = state;
    String lastMessage = '';
    if (currentState is ChatMessagesLoadingState) {
      lastMessage = currentState.oldMessages.first.messageText!;
    } else if (currentState is LoadChatMessagesState) {
      lastMessage = currentState.messages.first.messageText!;
    }
    return lastMessage;
  }

  String getLastMessageTime() {
    final currentState = state;
    String lastMessageTime = '';
    if (currentState is ChatMessagesLoadingState) {
      lastMessageTime = currentState.oldMessages.first.messageTime!;
    } else if (currentState is LoadChatMessagesState) {
      lastMessageTime = currentState.messages.first.messageTime!;
    }
    return lastMessageTime;
  }

  Future<void> _getChatMessages(GetMessagesEvent event, Emitter emit) async {
    final currentState = state;

    List<ChatMessages> oldMessages = [];
    if (currentState is LoadChatMessagesState && _page != 1) {
      oldMessages = currentState.messages;
    }

    emit(ChatMessagesLoadingState(oldMessages: oldMessages, isFirstFetch: _page == 1));

    final possibleData = await _repository.getChatMessagesAPI(page: _page, chatID: event.chatID);

    if (possibleData.isLeft()) {
      add(HandleMessagesErrorEvent(message: possibleData.getLeft()!.error));
      return;
    }

    if (possibleData.getRight()!.data != null) {
      _isListFetchingComplete = !possibleData.getRight()!.data!.hasNextPage!;
    }
    _page++;
    final messages = (state as ChatMessagesLoadingState).oldMessages;
    messages.addAll(possibleData.getRight()!.data!.docs!);
    add(HandleMessagesEvent(messages: messages));
  }

  void addMessageToUi(Emitter emit, String message, String direction) {
    final currentState = state;
    if (currentState is ChatMessagesErrorState || currentState is ChatMessagesLoadingState) return;
    List<ChatMessages> oldMessages = [];
    if (currentState is LoadChatMessagesState) {
      oldMessages = currentState.messages;
    }

    final messageTime = sl<CommonFunctions>().formatISOTime(DateTime.now());

    final chatMessage =
        ChatMessages(id: '', messageText: message, messageTime: messageTime, direction: direction);
    oldMessages.insert(0, chatMessage);
    emit(ChatMessagesLoadingState(oldMessages: oldMessages));
    add(HandleMessagesEvent(messages: oldMessages));
  }

  bool get isListFetchingComplete => _isListFetchingComplete;

  bool get hasChatInitiated => _hasChatInitiated;
}
