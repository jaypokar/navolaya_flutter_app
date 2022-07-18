import 'login_and_basic_info_model.dart';

/// message : "Profile information updated successfully"
/// data : {"social_profile_links":{"facebook":"https://www.facebook.com/","instagram":"https://www.instagram.com/","linkedin":"","twitter":"","youtube":""}}

class SocialMediaProfilesModel {
  SocialMediaProfilesModel({
    String? message,
    Data? data,
  }) {
    _message = message;
    _data = data;
  }

  SocialMediaProfilesModel.fromJson(dynamic json) {
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  String? _message;
  Data? _data;

  String? get message => _message;

  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

/// social_profile_links : {"facebook":"https://www.facebook.com/","instagram":"https://www.instagram.com/","linkedin":"","twitter":"","youtube":""}

class Data {
  Data({
    SocialProfileLinks? socialProfileLinks,
  }) {
    this.socialProfileLinks = socialProfileLinks;
  }

  Data.fromJson(dynamic json) {
    socialProfileLinks = json['social_profile_links'] != null
        ? SocialProfileLinks.fromJson(json['social_profile_links'])
        : null;
  }

  SocialProfileLinks? socialProfileLinks;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (socialProfileLinks != null) {
      map['social_profile_links'] = socialProfileLinks?.toJson();
    }
    return map;
  }
}

/// facebook : "https://www.facebook.com/"
/// instagram : "https://www.instagram.com/"
/// linkedin : ""
/// twitter : ""
/// youtube : ""

/*
class SocialProfileLinks {
  SocialProfileLinks({
      String? facebook, 
      String? instagram, 
      String? linkedin, 
      String? twitter, 
      String? youtube,}){
    _facebook = facebook;
    _instagram = instagram;
    _linkedin = linkedin;
    _twitter = twitter;
    _youtube = youtube;
}

  SocialProfileLinks.fromJson(dynamic json) {
    _facebook = json['facebook'];
    _instagram = json['instagram'];
    _linkedin = json['linkedin'];
    _twitter = json['twitter'];
    _youtube = json['youtube'];
  }
  String? _facebook;
  String? _instagram;
  String? _linkedin;
  String? _twitter;
  String? _youtube;

  String? get facebook => _facebook;
  String? get instagram => _instagram;
  String? get linkedin => _linkedin;
  String? get twitter => _twitter;
  String? get youtube => _youtube;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['facebook'] = _facebook;
    map['instagram'] = _instagram;
    map['linkedin'] = _linkedin;
    map['twitter'] = _twitter;
    map['youtube'] = _youtube;
    return map;
  }

}*/
