part of 'support_chat_bloc.dart';

abstract class SupportChatEvent extends Equatable {
  const SupportChatEvent();
}

class CreateSupportChatEvent extends SupportChatEvent {
  const CreateSupportChatEvent();

  @override
  List<Object?> get props => [];
}

class SendSupportMessageEvent extends SupportChatEvent {
  final String message;

  const SendSupportMessageEvent({required this.message});

  @override
  List<Object?> get props => [message];
}

class GetSupportChatMessagesEvent extends SupportChatEvent {
  const GetSupportChatMessagesEvent();

  @override
  List<Object?> get props => [];
}

class HandleSupportChatMessagesEvent extends SupportChatEvent {
  final List<ChatMessages> messages;

  const HandleSupportChatMessagesEvent({required this.messages});

  @override
  List<Object?> get props => [messages];
}

class HandleSupportMessagesErrorEvent extends SupportChatEvent {
  final String message;

  const HandleSupportMessagesErrorEvent({required this.message});

  @override
  List<Object?> get props => [message];
}
