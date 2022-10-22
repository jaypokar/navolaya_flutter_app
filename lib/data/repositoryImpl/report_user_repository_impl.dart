import 'package:dartz/dartz.dart';
import 'package:navolaya_flutter/core/app_type_def.dart';
import 'package:navolaya_flutter/core/either_extension_function.dart';
import 'package:navolaya_flutter/core/failure.dart';
import 'package:navolaya_flutter/data/model/report_user_model.dart';
import 'package:navolaya_flutter/domain/report_user_repository.dart';

import '../../resources/config_file.dart';
import '../apiService/base_api_service.dart';
import '../apiService/network_api_service.dart';
import '../apiService/update_ui_mixin.dart';
import '../model/reported_user_model.dart';

class ReportUserRepositoryImpl with UpdateUiMixin implements ReportUserRepository {
  final BaseAPIService _baseAPIService;

  const ReportUserRepositoryImpl(this._baseAPIService);

  @override
  Future<Either<Failure, ReportedUserModel>> fetchReportedUsersAPI({int page = 1}) {
    //--->
    //--->
    //--->

    return backToUI<ReportedUserModel>(() => _baseAPIService.executeAPI(
        url: ConfigFile.reportUsersAPIUrl,
        queryParameters: {'page': page},
        isTokenNeeded: true,
        apiType: ApiType.GET));
  }

  @override
  Future<Either<Failure, ReportUserModel>> reportUserAPI(
      {required String userID, required String reason}) {
    //--->
    //--->
    //--->

    return backToUI<ReportUserModel>(() => _baseAPIService.executeAPI(
        url: ConfigFile.reportUsersAPIUrl,
        queryParameters: {'report_user_id': userID, 'reason': reason},
        isTokenNeeded: true,
        apiType: ApiType.POST));
  }

  @override
  Future<Either<Failure, ReportUserModel>> unReportUserAPI({required String userID}) {
    throw UnimplementedError();
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
    if (T == ReportUserModel) {
      data = ReportUserModel.fromJson(response) as T;
    } else if (T == ReportedUserModel) {
      data = ReportedUserModel.fromJson(response) as T;
    }

    return right(data);
  }
}
