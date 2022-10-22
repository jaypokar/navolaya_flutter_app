part of 'create_chat_bloc.dart';

abstract class CreateChatState extends Equatable {
  const CreateChatState();
}

class CreateChatInitial extends CreateChatState {
  @override
  List<Object> get props => [];

  const CreateChatInitial();
}

class CreateChatLoadingState extends CreateChatState {
  @override
  List<Object> get props => [];

  const CreateChatLoadingState();
}

class CreateChatErrorState extends CreateChatState {
  final String message;

  @override
  List<Object> get props => [];

  const CreateChatErrorState({required this.message});
}

class HandleCreateChatState extends CreateChatState {
  final CreateChatModel response;

  @override
  List<Object> get props => [response];

  const HandleCreateChatState({required this.response});
}
