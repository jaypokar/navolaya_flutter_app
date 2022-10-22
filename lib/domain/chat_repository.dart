import 'package:dartz/dartz.dart';
import 'package:navolaya_flutter/data/model/chat_messages_model.dart';
import 'package:navolaya_flutter/data/model/chat_model.dart';
import 'package:navolaya_flutter/data/model/create_chat_model.dart';

import '../core/failure.dart';

abstract class ChatRepository {
  Future<Either<Failure, CreateChatModel>> createChatAPI({required String userID});

  Future<Either<Failure, ChatModel>> getChatsAPI({int page = 1});

  Future<Either<Failure, ChatMessagesModel>> getChatMessagesAPI(
      {int page = 1, required String chatID});
}
