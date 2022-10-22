import 'package:dartz/dartz.dart';
import 'package:navolaya_flutter/data/model/report_user_model.dart';
import 'package:navolaya_flutter/data/model/reported_user_model.dart';

import '../core/failure.dart';

abstract class ReportUserRepository {
  Future<Either<Failure, ReportUserModel>> reportUserAPI(
      {required String userID, required String reason});

  Future<Either<Failure, ReportUserModel>> unReportUserAPI({required String userID});

  Future<Either<Failure, ReportedUserModel>> fetchReportedUsersAPI({int page = 1});
}
