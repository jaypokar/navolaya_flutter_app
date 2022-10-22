import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

import 'failure.dart';

typedef ManageAPIResponse<T> = Future<Either<Failure, T>> Function();

typedef PickImageFromCameraOrGallery = Future<XFile?> Function();
