import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:navolaya_flutter/core/app_type_def.dart';
import 'package:navolaya_flutter/core/either_extension_function.dart';
import 'package:navolaya_flutter/core/failure.dart';
import 'package:navolaya_flutter/data/apiService/base_api_service.dart';
import 'package:navolaya_flutter/data/apiService/update_ui_mixin.dart';
import 'package:navolaya_flutter/data/model/chat_messages_model.dart';
import 'package:navolaya_flutter/data/model/chat_model.dart';
import 'package:navolaya_flutter/data/model/create_chat_model.dart';
import 'package:navolaya_flutter/domain/chat_repository.dart';

import '../../resources/config_file.dart';
import '../apiService/network_api_service.dart';
import '../apiService/parse_json_data.dart';
import '../model/chat_model.dart';

class ChatRepositoryImpl with UpdateUiMixin implements ChatRepository {
  final BaseAPIService _baseAPIService;

  const ChatRepositoryImpl(this._baseAPIService);

  @override
  Future<Either<Failure, CreateChatModel>> createChatAPI({required String userID}) async {
    //--->
    //--->
    //--->

    return backToUI<CreateChatModel>(() => _baseAPIService.executeAPI(
        url: ConfigFile.chatsAPIUrl,
        queryParameters: {'user_id': userID},
        isTokenNeeded: true,
        apiType: ApiType.POST));
  }

  @override
  Future<Either<Failure, ChatMessagesModel>> getChatMessagesAPI(
      {int page = 1, required String chatID}) async {
    //--->
    //--->
    //--->

    return backToUI<ChatMessagesModel>(() => _baseAPIService.executeAPI(
        url: '${ConfigFile.chatsAPIUrl}/$chatID/messages',
        queryParameters: {'page': page},
        isTokenNeeded: true,
        apiType: ApiType.GET));
  }

  @override
  Future<Either<Failure, ChatModel>> getChatsAPI({int page = 1}) async {
    //--->
    //--->
    //--->

    return backToUI<ChatModel>(() => _baseAPIService.executeAPI(
        url: ConfigFile.chatsAPIUrl,
        queryParameters: {'page': page},
        isTokenNeeded: true,
        apiType: ApiType.GET));
  }

  @override
  Future<Either<Failure, T>> backToUI<T>(ManageAPIResponse manageAPIResponse,
      {String flag = ''}) async {
    final possibleData = await manageAPIResponse();

    if (possibleData.isLeft()) {
      return left(Failure(possibleData.getLeft()!.error));
    }
    final response = possibleData.getRight();
    late final T data;
    if (T == ChatModel) {
      data = await compute(computeData, ChatModel.fromJson(response));
    } else if (T == ChatMessagesModel) {
      data = await compute(computeData, ChatMessagesModel.fromJson(response));
    } else if (T == CreateChatModel) {
      data = await compute(computeData, CreateChatModel.fromJson(response));
    }
    return right(data);
  }
}
