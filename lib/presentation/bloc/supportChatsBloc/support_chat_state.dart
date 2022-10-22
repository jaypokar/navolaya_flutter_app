part of 'support_chat_bloc.dart';

abstract class SupportChatState extends Equatable {
  const SupportChatState();
}

class SupportChatInitial extends SupportChatState {
  @override
  List<Object> get props => [];

  const SupportChatInitial();
}

class SupportChatCreateState extends SupportChatState {
  final CreateChatModel response;

  const SupportChatCreateState({required this.response});

  @override
  List<Object> get props => [response];
}

class SupportChatMessagesLoadingState extends SupportChatState {
  final List<ChatMessages> oldMessages;
  final bool isFirstFetch;

  const SupportChatMessagesLoadingState({required this.oldMessages, this.isFirstFetch = false});

  @override
  List<Object> get props => [oldMessages, isFirstFetch];
}

class LoadSupportChatMessagesState extends SupportChatState {
  final List<ChatMessages> messages;

  const LoadSupportChatMessagesState({required this.messages});

  @override
  List<Object> get props => [messages];
}

class SupportChatMessagesErrorState extends SupportChatState {
  final String message;

  const SupportChatMessagesErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
