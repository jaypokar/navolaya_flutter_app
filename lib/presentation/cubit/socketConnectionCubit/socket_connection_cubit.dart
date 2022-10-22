import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navolaya_flutter/data/model/chat_and_messag_info_model.dart';
import 'package:navolaya_flutter/data/sessionManager/session_manager.dart';
import 'package:navolaya_flutter/injection_container.dart';
import 'package:socket_io_client/socket_io_client.dart';

// ignore: library_prefixes
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../../core/logger.dart';
import '../../../features/local_notificaion.dart';
import '../../../features/socket_connection_manager.dart';

part 'socket_connection_state.dart';

class SocketConnectionCubit extends Cubit<SocketConnectionState> {
  final SocketConnectionManager _socketConnectionsManager;
  final LocalNotification _localNotification;

  SocketConnectionCubit(this._socketConnectionsManager, this._localNotification)
      : super(const SocketConnectionInitial());

  void init() async {
    final socket = await _socketConnectionsManager.createSocketConnection();
    if (socket != null) {
      socket.onConnect((data) => initChatReceivingStream(socket));
    }
  }

  void sendChatMessage(String chatID, String userID, String message) =>
      _socketConnectionsManager.sendChatMessage(chatID, userID, message);

  void initChatReceivingStream(IO.Socket socket) {
    socket.on('receiveChatMessage', (data) {
      logger.d('the received chat messages for the user are : $data');
      final chatAndMessageInfo = ChatAndMessageInfoModel.fromJson(data);
      if (!isClosed) {
        emit(LoadReceivedMessageState(chatAndMessageInfo: chatAndMessageInfo));
        if (sl<SessionManager>().getUserDetails()!.data!.allowNotifications == 1) {
          final user = chatAndMessageInfo.chat!.user!;
          final message = chatAndMessageInfo.chatMessages!.messageText!;
          _localNotification.showNotificationOnMessageReceived(
              userID: '', userName: user.fullName!, message: message);
        }
      }
    });
  }

  void closeSocketConnection() => _socketConnectionsManager.closeSocketConnection();

  @override
  Future<void> close() async {
    closeSocketConnection();
    return super.close();
  }
}
