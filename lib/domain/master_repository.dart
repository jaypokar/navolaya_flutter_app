import 'package:dartz/dartz.dart';

import '../core/failure.dart';

abstract class MasterRepository {
  Future<Either<Failure, Unit>> fetchAllMasterData();

  Future<Either<Failure, Unit>> fetchAllContentsData();
}
