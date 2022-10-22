part of 'socket_connection_cubit.dart';

abstract class SocketConnectionState extends Equatable {
  const SocketConnectionState();
}

class SocketConnectionInitial extends SocketConnectionState {
  const SocketConnectionInitial();

  @override
  List<Object> get props => [];
}

class LoadReceivedMessageState extends SocketConnectionState {
  final ChatAndMessageInfoModel chatAndMessageInfo;

  const LoadReceivedMessageState({required this.chatAndMessageInfo});

  @override
  List<Object> get props => [chatAndMessageInfo];
}
