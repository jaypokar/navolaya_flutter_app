import 'package:dartz/dartz.dart';
import 'package:navolaya_flutter/core/config_file.dart';
import 'package:navolaya_flutter/core/either_extension_function.dart';
import 'package:navolaya_flutter/core/failure.dart';
import 'package:navolaya_flutter/data/model/AppContentsModel.dart';
import 'package:navolaya_flutter/data/model/MastersModel.dart';
import 'package:navolaya_flutter/domain/master_repository.dart';

import '../apiService/base_api_service.dart';

class MasterRepositoryImpl implements MasterRepository {
  final BaseAPIService baseAPIService;
  late final AppContentsModel _appContentsData;
  late final MastersModel _mastersData;

  MasterRepositoryImpl({required this.baseAPIService});

  @override
  Future<Either<Failure, Unit>> fetchAllMasterData() async {
    final possibleData = await baseAPIService.getAPI(
      url: ConfigFile.allMastersAPIUrl,
      queryParameters: {},
      isTokenNeeded: false,
    );

    if (possibleData.isLeft()) {
      return left(Failure(possibleData.getLeft()!.error));
    }
    final response = possibleData.getRight();
    _mastersData = MastersModel.fromJson(response);

    return right(unit);
  }

  @override
  Future<Either<Failure, Unit>> fetchAllContentsData() async {
    final possibleData = await baseAPIService.getAPI(
      url: ConfigFile.allContentsAPIUrl,
      queryParameters: {},
      isTokenNeeded: false,
    );

    if (possibleData.isLeft()) {
      return left(Failure(possibleData.getLeft()!.error));
    }

    final response = possibleData.getRight();
    _appContentsData = AppContentsModel.fromJson(response);

    return right(unit);
  }

  AppContentsModel get appContentsModel => _appContentsData;
}
