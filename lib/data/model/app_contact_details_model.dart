import 'app_contents_model.dart';

class AppContactDetails {
  SocialMediaLinks? socialMediaLinks;
  String? officialPhone;
  String? officialEmail;
  String? officialAddress;

  AppContactDetails(
      {required this.socialMediaLinks,
      required this.officialPhone,
      required this.officialEmail,
      required this.officialAddress});
}
