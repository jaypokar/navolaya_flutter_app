import 'package:dartz/dartz.dart';

import '../core/failure.dart';
import '../data/model/masters_model.dart';

abstract class MasterRepository {
  Future<Either<Failure, Unit>> fetchAllMasterData();

  Future<Either<Failure, Unit>> fetchAllContentsData();

  List<OccupationAreas> get occupationAreasList;

  List<JnvRelations> get relationWithJNVList;

  List<JnvHouses> get jnvHousesList;

  List<JnvRegions> get jnvRegionsList;

  List<Occupations> get occupationsList;

  List<Qualifications> get qualificationsList;

  List<Schools> get schoolsList;

  List<StateCities> get stateCitiesList;
}
