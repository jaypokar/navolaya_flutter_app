import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navolaya_flutter/core/either_extension_function.dart';
import 'package:navolaya_flutter/data/model/app_contact_details_model.dart';
import 'package:navolaya_flutter/data/model/app_contents_model.dart';

import '../../../domain/help_and_info_repository.dart';

part 'help_and_info_state.dart';

class HelpAndInfoCubit extends Cubit<HelpAndInfoState> {
  final HelpAndInfoRepository _repository;

  HelpAndInfoCubit(this._repository) : super(const HelpAndInfoInitial());

  void fetchAppContactDetails() {
    final details = _repository.getAppContactDetails();
    if (details.isLeft()) {
      handleError(details.getLeft()!.error);
    }
    emit(LoadAppContactDetailsState(appContactDetails: details.getRight()!));
  }

  void fetchFaq() {
    final details = _repository.getFaqs();
    if (details.isLeft()) {
      handleError(details.getLeft()!.error);
    }
    emit(LoadFaqState(faqList: details.getRight()!));
  }

  void fetchAboutUs() {
    final details = _repository.getAboutUs();
    if (details.isLeft()) {
      handleError(details.getLeft()!.error);
    }
    emit(LoadAboutUsState(aboutUs: details.getRight()!));
  }

  void fetchPrivacyPolicy() {
    final details = _repository.getPrivacyPolicy();
    if (details.isLeft()) {
      handleError(details.getLeft()!.error);
    }
    emit(LoadPrivacyPolicyState(privacyPolicy: details.getRight()!));
  }

  void fetchTermAndCondition() {
    final details = _repository.getTermsAndCondition();
    if (details.isLeft()) {
      handleError(details.getLeft()!.error);
    }
    emit(LoadTermsAndConditionState(termAndCondition: details.getRight()!));
  }

  void handleError(String error) {
    emit(HelpAndInfoErrorState(error: error));
  }
}
