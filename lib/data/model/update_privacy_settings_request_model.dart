import 'dart:core';

class UpdatePrivacySettingRequestModel {
  String phone;
  String email;
  String userImage;

  String birthDayMonth;

  String birthYear;

  String currentAddress;

  String permanentAddress;

  String socialProfileLinks;

  String findMeNearby;

  UpdatePrivacySettingRequestModel(
      {this.phone = 'all',
      this.email = 'all',
      this.userImage = 'all',
      this.birthDayMonth = 'all',
      this.birthYear = 'all',
      this.currentAddress = 'all',
      this.permanentAddress = 'all',
      this.socialProfileLinks = 'all',
      this.findMeNearby = 'all'});

  Map<String, dynamic> toJson() {
    Map<String, String> json = {};
    json['phone'] = phone;
    json['email'] = email;
    json['user_image'] = userImage;
    json['birth_day_month'] = birthDayMonth;
    json['birth_year'] = birthYear;
    json['current_address'] = currentAddress;
    json['permanent_address'] = permanentAddress;
    json['social_profile_links'] = socialProfileLinks;
    json['find_me_nearby'] = findMeNearby;
    return json;
  }
}
