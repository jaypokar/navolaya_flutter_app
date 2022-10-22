import 'dart:async';

// ignore: library_prefixes
import 'package:navolaya_flutter/resources/config_file.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../core/logger.dart';
import '../data/sessionManager/session_manager.dart';

class SocketConnectionManager {
  IO.Socket? _socket;
  final SessionManager _sessionManager;

  SocketConnectionManager(this._sessionManager);

  Future<IO.Socket?> createSocketConnection() async {
    if (_sessionManager.isUserLoggedIn()) {
      if (_socket == null) {
        _socket = _createSocketInstance();

        _socket!.connect();

        _socket!.onConnect((status) {
          logger.d('the socket connection established successfully');
        });

        _socket!.onConnectError((data) {
          logger.d('the socket connection error is : $data');
        });
      }
    }
    return _socket;
  }

  IO.Socket _createSocketInstance() {
    return IO.io(
        ConfigFile.baseURL,
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .setQuery({'authorization': _sessionManager.getToken()})
            .disableAutoConnect()
            .build());
  }

  void updateUserCurrentLocation(double latitude, double longitude) {
    if (_socket == null) return;
    _socket!.emit("saveCurrentLocation", {
      "latitude": latitude,
      "longitude": longitude,
    });
  }

  void sendChatMessage(String chatID, String userID, String message) {
    if (_socket == null) return;
    logger.i(
        'the request parameters for sending chat message is : \nChat ID : $chatID\nChatUserID : $userID\nMessage : $message');
    _socket!.emit('sendChatMessage', {
      'chat_id': chatID,
      'chat_user_id': userID,
      'message_text': message,
    });
  }

  void closeSocketConnection() {
    if (_socket == null) return;
    _socket!.dispose();
    _socket = null;
  }
}
