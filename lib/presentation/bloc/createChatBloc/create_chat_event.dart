part of 'create_chat_bloc.dart';

abstract class CreateChatEvent extends Equatable {
  const CreateChatEvent();
}

class InitiateChatEvent extends CreateChatEvent {
  final String userID;

  const InitiateChatEvent({required this.userID});

  @override
  List<Object> get props => [userID];
}
