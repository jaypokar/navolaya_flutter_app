import 'package:dartz/dartz.dart';
import 'package:navolaya_flutter/core/failure.dart';
import 'package:navolaya_flutter/data/model/basic_info_request_model.dart';
import 'package:navolaya_flutter/data/model/login_and_basic_info_model.dart';
import 'package:navolaya_flutter/data/model/social_media_links_request_model.dart';
import 'package:navolaya_flutter/data/model/social_media_profiles_model.dart';

import '../data/model/update_additional_info_model.dart';

abstract class ProfileRepository {
  Future<Either<Failure, UpdateAdditionalInfoModel>> updateAdditionalInfoAPI(
      {required String house, required String aboutMe, required String birthDate});

  Future<Either<Failure, LoginAndBasicInfoModel>> fetchPersonalDetails();

  Future<Either<Failure, LoginAndBasicInfoModel>> updateProfileBasicInfoAPI(
      {required BasicInfoRequestModel basicInfoRequestData});

  Future<Either<Failure, SocialMediaProfilesModel>> updateSocialMediaLinksAPI(
      {required SocialMediaLinksRequestModel socialMediaLinksRequestData});
}
