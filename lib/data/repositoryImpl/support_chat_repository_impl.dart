import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:navolaya_flutter/core/either_extension_function.dart';
import 'package:navolaya_flutter/core/failure.dart';

import '../../core/app_type_def.dart';
import '../../domain/support_chat_repository.dart';
import '../../resources/config_file.dart';
import '../apiService/base_api_service.dart';
import '../apiService/network_api_service.dart';
import '../apiService/parse_json_data.dart';
import '../apiService/update_ui_mixin.dart';
import '../model/chat_messages_model.dart';
import '../model/create_chat_model.dart';

class SupportChatRepositoryImpl with UpdateUiMixin implements SupportChatRepository {
  final BaseAPIService _baseAPIService;
  String? chatID;

  SupportChatRepositoryImpl(this._baseAPIService);

  @override
  Future<Either<Failure, CreateChatModel>> createSupportChatAPI() {
    //--->
    //--->
    //--->

    return backToUI<CreateChatModel>(() => _baseAPIService.executeAPI(
        url: ConfigFile.supportChatsAPIUrl,
        queryParameters: {},
        isTokenNeeded: true,
        apiType: ApiType.POST));
  }

  @override
  Future<Either<Failure, ChatMessagesModel>> fetchSupportChatMessagesAPI({int page = 1}) {
    //--->
    //--->
    //--->

    return backToUI<ChatMessagesModel>(() => _baseAPIService.executeAPI(
        url: '${ConfigFile.supportChatsAPIUrl}/$chatID/messages',
        queryParameters: {'page': page},
        isTokenNeeded: true,
        apiType: ApiType.GET));
  }

  @override
  Future<Either<Failure, Unit>> sendSupportMessagesAPI({required String message}) {
    //--->
    //--->
    //--->

    return backToUI<Unit>(() => _baseAPIService.executeAPI(
        url: '${ConfigFile.supportChatsAPIUrl}/$chatID/messages',
        queryParameters: {'message_text': message},
        isTokenNeeded: true,
        apiType: ApiType.POST));
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
    if (T == CreateChatModel) {
      data = await compute(computeData, CreateChatModel.fromJson(response));
      if ((data as CreateChatModel).data != null) {
        if (data.data!.id != null) {
          chatID = (data).data!.id!;
        }
      }
    } else if (T == ChatMessagesModel) {
      data = await compute(computeData, ChatMessagesModel.fromJson(response));
    } else if (T == Unit) {
      data = unit as T;
    }
    return right(data);
  }
}
