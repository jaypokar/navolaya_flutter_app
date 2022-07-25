import 'package:dartz/dartz.dart';
import 'package:navolaya_flutter/core/failure.dart';
import 'package:navolaya_flutter/data/model/app_contact_details_model.dart';
import 'package:navolaya_flutter/data/model/app_contents_model.dart';
import 'package:navolaya_flutter/domain/help_and_info_repository.dart';
import 'package:navolaya_flutter/domain/master_repository.dart';
import 'package:navolaya_flutter/resources/string_resources.dart';

class HelpAndInfoRepositoryImpl implements HelpAndInfoRepository {
  final MasterRepository _masterRepository;

  const HelpAndInfoRepositoryImpl(this._masterRepository);

  @override
  Either<Failure, String> getAboutUs() {
    if (_masterRepository.appContents.data != null) {
      if (_masterRepository.appContents.data!.contents!.aboutUs != null) {
        return right(_masterRepository.appContents.data!.contents!.aboutUs!);
      }
      return left(const Failure(StringResources.noDataAvailable));
    } else {
      return left(const Failure(StringResources.noDataAvailable));
    }
  }

  @override
  Either<Failure, AppContactDetails> getAppContactDetails() {
    if (_masterRepository.appContents.data != null) {
      if (_masterRepository.appContents.data!.settings!.socialMediaLinks != null &&
          _masterRepository.appContents.data!.settings!.officialPhone != null) {
        final socialMediaLinks = _masterRepository.appContents.data!.settings!.socialMediaLinks!;
        final officialPhone = _masterRepository.appContents.data!.settings!.officialPhone!;
        final officialEmail = _masterRepository.appContents.data!.settings!.officialEmail!;
        return right(AppContactDetails(
          socialMediaLinks: socialMediaLinks,
          officialPhone: officialPhone,
          officialEmail: officialEmail,
          officialAddress: 'officialAddress',
        ));
      }
      return left(const Failure(StringResources.noDataAvailable));
    } else {
      return left(const Failure(StringResources.noDataAvailable));
    }
  }

  @override
  Either<Failure, List<Faqs>> getFaqs() {
    if (_masterRepository.appContents.data != null) {
      if (_masterRepository.appContents.data!.faqs != null) {
        return right(_masterRepository.appContents.data!.faqs!);
      }
      return left(const Failure(StringResources.noDataAvailable));
    } else {
      return left(const Failure(StringResources.noDataAvailable));
    }
  }

  @override
  Either<Failure, String> getPrivacyPolicy() {
    if (_masterRepository.appContents.data != null) {
      if (_masterRepository.appContents.data!.contents!.privacyPolicy != null) {
        return right(_masterRepository.appContents.data!.contents!.privacyPolicy!);
      }
      return left(const Failure(StringResources.noDataAvailable));
    } else {
      return left(const Failure(StringResources.noDataAvailable));
    }
  }

  @override
  Either<Failure, String> getTermsAndCondition() {
    if (_masterRepository.appContents.data != null) {
      if (_masterRepository.appContents.data!.contents!.termsConditions != null) {
        return right(_masterRepository.appContents.data!.contents!.termsConditions!);
      }
      return left(const Failure(StringResources.noDataAvailable));
    } else {
      return left(const Failure(StringResources.noDataAvailable));
    }
  }
}
