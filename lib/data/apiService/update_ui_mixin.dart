import 'package:dartz/dartz.dart';

import '../../core/app_type_def.dart';
import '../../core/failure.dart';

mixin UpdateUiMixin {
  Future<Either<Failure, T>> backToUI<T>(ManageAPIResponse manageAPIResponse, {String flag = ''});
}
