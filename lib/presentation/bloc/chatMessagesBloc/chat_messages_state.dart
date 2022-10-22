part of 'chat_messages_bloc.dart';

abstract class ChatMessagesState extends Equatable {
  const ChatMessagesState();
}

class ChatMessagesInitial extends ChatMessagesState {
  const ChatMessagesInitial();

  @override
  List<Object> get props => [];
}

class ChatMessagesLoadingState extends ChatMessagesState {
  final List<ChatMessages> oldMessages;
  final bool isFirstFetch;

  const ChatMessagesLoadingState({required this.oldMessages, this.isFirstFetch = false});

  @override
  List<Object> get props => [oldMessages, isFirstFetch];
}

class LoadChatMessagesState extends ChatMessagesState {
  final List<ChatMessages> messages;

  const LoadChatMessagesState({required this.messages});

  @override
  List<Object> get props => [messages];
}

class ChatMessagesErrorState extends ChatMessagesState {
  final String message;

  const ChatMessagesErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
