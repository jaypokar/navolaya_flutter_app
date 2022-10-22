part of 'chat_messages_bloc.dart';

abstract class ChatMessagesEvent extends Equatable {
  const ChatMessagesEvent();
}

class SendMessageEvent extends ChatMessagesEvent {
  final String chatID;
  final String chatUserID;
  final String message;

  const SendMessageEvent({required this.chatID, required this.chatUserID, required this.message});

  @override
  List<Object?> get props => [chatID, chatUserID, message];
}

class GetMessagesEvent extends ChatMessagesEvent {
  final String chatID;

  const GetMessagesEvent({required this.chatID});

  @override
  List<Object?> get props => [chatID];
}

class HandleMessagesEvent extends ChatMessagesEvent {
  final List<ChatMessages> messages;

  const HandleMessagesEvent({required this.messages});

  @override
  List<Object?> get props => [messages];
}

class HandleReceivedMessagesEvent extends ChatMessagesEvent {
  final ChatMessages message;

  const HandleReceivedMessagesEvent({required this.message});

  @override
  List<Object?> get props => [message];
}

class HandleMessagesErrorEvent extends ChatMessagesEvent {
  final String message;

  const HandleMessagesErrorEvent({required this.message});

  @override
  List<Object?> get props => [message];
}
