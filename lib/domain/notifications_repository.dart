import 'package:dartz/dartz.dart';
import 'package:navolaya_flutter/data/model/notification_model.dart';

import '../core/failure.dart';

abstract class NotificationsRepository {
  Future<Either<Failure, NotificationModel>> fetchNotificationsAPI({int page = 1});

  Future<Either<Failure, String>> removeNotificationsAPI();
}
