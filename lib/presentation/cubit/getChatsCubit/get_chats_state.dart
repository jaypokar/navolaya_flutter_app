part of 'get_chats_cubit.dart';

abstract class GetChatsState extends Equatable {
  const GetChatsState();
}

class GetChatsInitial extends GetChatsState {
  const GetChatsInitial();

  @override
  List<Object> get props => [];
}

class GetChatsLoadingState extends GetChatsState {
  final List<Chat> oldChats;
  final bool isFirstFetch;

  const GetChatsLoadingState({required this.oldChats, this.isFirstFetch = false});

  @override
  List<Object> get props => [oldChats, isFirstFetch];
}

class LoadChatsState extends GetChatsState {
  final List<Chat> chats;

  const LoadChatsState({required this.chats});

  @override
  List<Object> get props => [chats];
}

class ChatErrorState extends GetChatsState {
  final String message;

  const ChatErrorState({required this.message});

  @override
  List<Object> get props => [message];
}
