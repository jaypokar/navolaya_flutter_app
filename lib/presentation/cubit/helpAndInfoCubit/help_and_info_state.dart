part of 'help_and_info_cubit.dart';

abstract class HelpAndInfoState extends Equatable {
  const HelpAndInfoState();
}

class HelpAndInfoInitial extends HelpAndInfoState {
  @override
  List<Object> get props => [];

  const HelpAndInfoInitial();
}

class LoadAboutUsState extends HelpAndInfoState {
  final String aboutUs;

  const LoadAboutUsState({required this.aboutUs});

  @override
  List<Object> get props => [aboutUs];
}

class LoadPrivacyPolicyState extends HelpAndInfoState {
  final String privacyPolicy;

  const LoadPrivacyPolicyState({required this.privacyPolicy});

  @override
  List<Object> get props => [privacyPolicy];
}

class LoadTermsAndConditionState extends HelpAndInfoState {
  final String termAndCondition;

  const LoadTermsAndConditionState({required this.termAndCondition});

  @override
  List<Object> get props => [termAndCondition];
}

class LoadAppContactDetailsState extends HelpAndInfoState {
  final AppContactDetails appContactDetails;

  const LoadAppContactDetailsState({required this.appContactDetails});

  @override
  List<Object> get props => [appContactDetails];
}

class LoadFaqState extends HelpAndInfoState {
  final List<Faqs> faqList;

  const LoadFaqState({required this.faqList});

  @override
  List<Object> get props => [faqList];
}

class HelpAndInfoErrorState extends HelpAndInfoState {
  final String error;

  const HelpAndInfoErrorState({required this.error});

  @override
  List<Object> get props => [error];
}
