import 'package:dartz/dartz.dart';
import 'package:navolaya_flutter/core/either_extension_function.dart';
import 'package:navolaya_flutter/core/failure.dart';
import 'package:navolaya_flutter/data/apiService/network_api_service.dart';
import 'package:navolaya_flutter/data/model/app_contents_model.dart';
import 'package:navolaya_flutter/data/model/masters_model.dart';
import 'package:navolaya_flutter/domain/master_repository.dart';
import 'package:navolaya_flutter/resources/config_file.dart';

import '../apiService/base_api_service.dart';

class MasterRepositoryImpl implements MasterRepository {
  final BaseAPIService _baseAPIService;
  late final AppContentsModel _appContentsData;
  late final MastersModel _mastersData;

  MasterRepositoryImpl(this._baseAPIService);

  @override
  Future<Either<Failure, Unit>> fetchAllMasterData() async {
    final possibleData = await _baseAPIService.executeAPI(
        url: ConfigFile.allMastersAPIUrl,
        queryParameters: {},
        isTokenNeeded: false,
        apiType: ApiType.get);

    if (possibleData.isLeft()) {
      return left(Failure(possibleData.getLeft()!.error));
    }
    final response = possibleData.getRight();
    _mastersData = MastersModel.fromJson(response);

    return right(unit);
  }

  @override
  Future<Either<Failure, Unit>> fetchAllContentsData() async {
    final possibleData = await _baseAPIService.executeAPI(
        url: ConfigFile.allContentsAPIUrl,
        queryParameters: {},
        isTokenNeeded: false,
        apiType: ApiType.get);

    if (possibleData.isLeft()) {
      return left(Failure(possibleData.getLeft()!.error));
    }

    final response = possibleData.getRight();
    _appContentsData = AppContentsModel.fromJson(response);

    return right(unit);
  }

  AppContentsModel get appContentsModel => _appContentsData;

  @override
  List<OccupationAreas> get occupationAreasList => _mastersData.data!.occupationAreas!;

  @override
  List<Occupations> get occupationsList => _mastersData.data!.occupations!;

  @override
  List<Qualifications> get qualificationsList => _mastersData.data!.qualifications!;

  @override
  List<Schools> get schoolsList => _mastersData.data!.schools!;

  @override
  List<StateCities> get stateCitiesList => _mastersData.data!.stateCities!;

  @override
  List<JnvHouses> get jnvHousesList => _mastersData.data!.jnvHouses!;

  @override
  List<JnvRegions> get jnvRegionsList => _mastersData.data!.jnvRegions!;

  @override
  List<JnvRelations> get relationWithJNVList => _mastersData.data!.jnvRelations!;
}
