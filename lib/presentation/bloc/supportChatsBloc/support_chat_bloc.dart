import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navolaya_flutter/core/either_extension_function.dart';
import 'package:navolaya_flutter/data/model/create_chat_model.dart';
import 'package:navolaya_flutter/domain/support_chat_repository.dart';

import '../../../data/model/chat_messages_model.dart';
import '../../../features/local_notificaion.dart';
import '../../../injection_container.dart';
import '../../../util/common_functions.dart';

part 'support_chat_event.dart';

part 'support_chat_state.dart';

class SupportChatBloc extends Bloc<SupportChatEvent, SupportChatState> {
  int _page = 1;
  bool _isListFetchingComplete = false;
  final SupportChatRepository _repository;
  final LocalNotification _localNotification;

  SupportChatBloc(this._repository, this._localNotification) : super(const SupportChatInitial()) {
    onMessageReceived();
    on<SupportChatEvent>((event, emit) async {
      if (event is CreateSupportChatEvent) {
        final data = await _repository.createSupportChatAPI();
        emit(data.fold((l) => SupportChatMessagesErrorState(message: l.error),
            (r) => SupportChatCreateState(response: r)));
      } else if (event is SendSupportMessageEvent) {
        _repository.sendSupportMessagesAPI(message: event.message);
        addMessageToUi(emit, event.message, 'right');
      } else if (event is GetSupportChatMessagesEvent) {
        if (state is SupportChatMessagesLoadingState || _isListFetchingComplete) return;
        _getChatMessages(event, emit);
      } else if (event is HandleSupportMessagesErrorEvent) {
        emit(SupportChatMessagesErrorState(message: event.message));
      } else if (event is HandleSupportChatMessagesEvent) {
        emit(LoadSupportChatMessagesState(messages: event.messages));
      }
    });
  }

  void onMessageReceived() {
    FirebaseMessaging.onMessage.listen((RemoteMessage? message) async {
      if (message != null) {
        if (message.data.containsKey('supportReplied')) {
          _page = 1;
          _isListFetchingComplete = false;
          add(const GetSupportChatMessagesEvent());
        }
      }
    });
  }

  Future<void> _getChatMessages(GetSupportChatMessagesEvent event, Emitter emit) async {
    final currentState = state;

    List<ChatMessages> oldMessages = [];
    if (currentState is LoadSupportChatMessagesState && _page != 1) {
      oldMessages = currentState.messages;
    }

    emit(SupportChatMessagesLoadingState(oldMessages: oldMessages, isFirstFetch: _page == 1));

    final possibleData = await _repository.fetchSupportChatMessagesAPI(page: _page);

    if (possibleData.isLeft()) {
      add(HandleSupportMessagesErrorEvent(message: possibleData.getLeft()!.error));
      return;
    }

    if (possibleData.getRight()!.data != null) {
      _isListFetchingComplete = !possibleData.getRight()!.data!.hasNextPage!;
    }
    _page++;
    final messages = (state as SupportChatMessagesLoadingState).oldMessages;
    messages.addAll(possibleData.getRight()!.data!.docs!);
    add(HandleSupportChatMessagesEvent(messages: messages));
  }

  void addMessageToUi(Emitter emit, String message, String direction) {
    final currentState = state;
    if (currentState is SupportChatMessagesErrorState ||
        currentState is SupportChatMessagesLoadingState) return;
    List<ChatMessages> oldMessages = [];
    if (currentState is LoadSupportChatMessagesState) {
      oldMessages = currentState.messages;
    }

    final messageTime = sl<CommonFunctions>().formatISOTime(DateTime.now());

    final chatMessage =
        ChatMessages(id: '', messageText: message, messageTime: messageTime, direction: direction);
    oldMessages.insert(0, chatMessage);
    emit(SupportChatMessagesLoadingState(oldMessages: oldMessages));
    add(HandleSupportChatMessagesEvent(messages: oldMessages));
  }

  bool get isListFetchingComplete => _isListFetchingComplete;
}
