import 'package:dartz/dartz.dart';
import 'package:navolaya_flutter/core/failure.dart';
import 'package:navolaya_flutter/data/model/chat_messages_model.dart';
import 'package:navolaya_flutter/data/model/create_chat_model.dart';

abstract class SupportChatRepository {
  Future<Either<Failure, CreateChatModel>> createSupportChatAPI();

  Future<Either<Failure, ChatMessagesModel>> fetchSupportChatMessagesAPI({int page = 1});

  Future<Either<Failure, Unit>> sendSupportMessagesAPI({required String message});
}
