import 'package:dartz/dartz.dart';
import 'package:navolaya_flutter/core/failure.dart';
import 'package:navolaya_flutter/data/model/app_contact_details_model.dart';
import 'package:navolaya_flutter/data/model/app_contents_model.dart';

abstract class HelpAndInfoRepository {
  Either<Failure, AppContactDetails> getAppContactDetails();

  Either<Failure, String> getAboutUs();

  Either<Failure, String> getPrivacyPolicy();

  Either<Failure, String> getTermsAndCondition();

  Either<Failure, List<Faqs>> getFaqs();
}
