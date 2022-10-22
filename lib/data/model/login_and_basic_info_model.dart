import 'package:navolaya_flutter/data/model/profile_image_or_allow_notification_model.dart';

/// message : "You have logged in successfully"
/// data : {"full_name":"Jay Pokar","user_code":"1657916130UF","email":"","school":{"_id":"62879b983a3e730c64e33d7e","region":"Jaipur","state":"Rajasthan","district":"Barmer","city":"Pachpadra","pincode":"344032","latitude":25.9126614,"longitude":72.2547811},"relation_with_jnv":"Alumni","from_year":1970,"to_year":2022,"qualification":null,"occupation":null,"gender":"male","house":"Shivalik","birth_date":"1992-11-03T00:00:00.000Z","about_me":"Many careers—like becoming a doctor, a scientist, a teacher, and more—require a certain level of education and specific skills. If you are looking to pursue similar careers to these, then you almost always need to graduate from college—and often even obtain further education, like a Master’s or Doctoral Degree. Going to college is the only way to become qualified for these types of jobs and prepare you for a career in a certain specialized field.","current_address":null,"permanent_address":null,"user_image":null,"auth_token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJsb2dpbl91c2VyX2lkIjoiNjJkMWJhYTBjYTA4OTZlYWQ3ZGY3NjRlIiwibG9naW5fdXNlcl9yb2xlIjoidXNlciIsImxvZ2luX3VzZXJfbmFtZSI6IkpheSBQb2thciIsImlhdCI6MTY1ODE2Njc1MCwiZXhwIjoxNjU4NzcxNTUwfQ.HZtkeYQS9vkayZ6MD2m_gDW_Prjh63CPHAxts-HVnJ0","last_login_time":"2022-07-18T17:52:30.378Z","is_user_account_verified":1,"is_phone_verified":1,"is_basic_profile_updated":1,"jnv_verification_status":0,"allow_notifications":1,"social_profile_links":{"facebook":"www.facebook.com","instagram":"www.instagram.com","linkedin":"www.linkedIn.com","twitter":"www.twitter.com","youtube":"www.youtube.com"},"display_settings":{"phone":"my_connections","email":"none","user_image":"all","birth_day_month":"all","birth_year":"none","current_address":"my_connections","permanent_address":"my_connections","social_profile_links":"all","find_me_nearby":"all"},"_id":"62d1baa0ca0896ead7df764e","country_code":"+91","phone":"8160231082"}

class LoginAndBasicInfoModel {
  LoginAndBasicInfoModel({
    String? message,
    Data? data,
  }) {
    _message = message;
    _data = data;
  }

  LoginAndBasicInfoModel.fromJson(dynamic json) {
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

/// full_name : "Jay Pokar"
/// user_code : "1657916130UF"
/// email : ""
/// school : {"_id":"62879b983a3e730c64e33d7e","region":"Jaipur","state":"Rajasthan","district":"Barmer","city":"Pachpadra","pincode":"344032","latitude":25.9126614,"longitude":72.2547811}
/// relation_with_jnv : "Alumni"
/// from_year : 1970
/// to_year : 2022
/// qualification : null
/// occupation : null
/// gender : "male"
/// house : "Shivalik"
/// birth_date : "1992-11-03T00:00:00.000Z"
/// about_me : "Many careers—like becoming a doctor, a scientist, a teacher, and more—require a certain level of education and specific skills. If you are looking to pursue similar careers to these, then you almost always need to graduate from college—and often even obtain further education, like a Master’s or Doctoral Degree. Going to college is the only way to become qualified for these types of jobs and prepare you for a career in a certain specialized field."
/// current_address : null
/// permanent_address : null
/// user_image : null
/// auth_token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJsb2dpbl91c2VyX2lkIjoiNjJkMWJhYTBjYTA4OTZlYWQ3ZGY3NjRlIiwibG9naW5fdXNlcl9yb2xlIjoidXNlciIsImxvZ2luX3VzZXJfbmFtZSI6IkpheSBQb2thciIsImlhdCI6MTY1ODE2Njc1MCwiZXhwIjoxNjU4NzcxNTUwfQ.HZtkeYQS9vkayZ6MD2m_gDW_Prjh63CPHAxts-HVnJ0"
/// last_login_time : "2022-07-18T17:52:30.378Z"
/// is_user_account_verified : 1
/// is_phone_verified : 1
/// is_basic_profile_updated : 1
/// jnv_verification_status : 0
/// allow_notifications : 1
/// social_profile_links : {"facebook":"www.facebook.com","instagram":"www.instagram.com","linkedin":"www.linkedIn.com","twitter":"www.twitter.com","youtube":"www.youtube.com"}
/// display_settings : {"phone":"my_connections","email":"none","user_image":"all","birth_day_month":"all","birth_year":"none","current_address":"my_connections","permanent_address":"my_connections","social_profile_links":"all","find_me_nearby":"all"}
/// _id : "62d1baa0ca0896ead7df764e"
/// country_code : "+91"
/// phone : "8160231082"

class Data {
  Data({
    String? fullName,
    String? userCode,
    String? email,
    School? school,
    String? relationWithJnv,
    int? fromYear,
    int? toYear,
    Qualification? qualification,
    Occupation? occupation,
    String? gender,
    String? house,
    String? birthDate,
    String? aboutMe,
    dynamic currentAddress,
    dynamic permanentAddress,
    UserImage? userImage,
    String? authToken,
    String? lastLoginTime,
    int? isUserAccountVerified,
    int? isPhoneVerified,
    int? isBasicProfileUpdated,
    int? jnvVerificationStatus,
    int? allowNotifications,
    SocialProfileLinks? socialProfileLinks,
    DisplaySettings? displaySettings,
    String? id,
    String? countryCode,
    String? phone,
  }) {
    this.fullName;
    _userCode = userCode;
    this.email;
    this.school;
    this.relationWithJnv;
    this.fromYear;
    this.toYear;
    this.qualification;
    this.occupation;
    this.gender;
    this.house;

    this.birthDate;
    this.aboutMe;
    this.currentAddress;
    this.permanentAddress;
    this.userImage;
    this.authToken;
    _lastLoginTime = lastLoginTime;
    _isUserAccountVerified = isUserAccountVerified;
    _isPhoneVerified = isPhoneVerified;
    _isBasicProfileUpdated = isBasicProfileUpdated;
    _jnvVerificationStatus = jnvVerificationStatus;
    this.allowNotifications;
    this.socialProfileLinks;
    _displaySettings = displaySettings;
    _id = id;
    _countryCode = countryCode;
    this.phone;
  }

  Data.fromJson(dynamic json) {
    fullName = json['full_name'];
    _userCode = json['user_code'];
    email = json['email'];
    school = json['school'] != null ? School.fromJson(json['school']) : null;
    relationWithJnv = json['relation_with_jnv'];
    fromYear = json['from_year'];
    toYear = json['to_year'];

    qualification =
        json['qualification'] != null ? Qualification.fromJson(json['qualification']) : null;
    occupation = json['occupation'] != null ? Occupation.fromJson(json['occupation']) : null;

    gender = json['gender'];
    house = json['house'];
    birthDate = json['birth_date'];
    aboutMe = json['about_me'];
    currentAddress = json['current_address'];
    permanentAddress = json['permanent_address'];
    if (json['user_image'] != null) {
      userImage = UserImage.fromJson(json['user_image']);
    }
    authToken = json['auth_token'];
    _lastLoginTime = json['last_login_time'];
    _isUserAccountVerified = json['is_user_account_verified'];
    _isPhoneVerified = json['is_phone_verified'];
    _isBasicProfileUpdated = json['is_basic_profile_updated'];
    _jnvVerificationStatus = json['jnv_verification_status'];
    allowNotifications = json['allow_notifications'];
    socialProfileLinks = json['social_profile_links'] != null
        ? SocialProfileLinks.fromJson(json['social_profile_links'])
        : null;
    _displaySettings = json['display_settings'] != null
        ? DisplaySettings.fromJson(json['display_settings'])
        : null;
    _id = json['_id'];
    _countryCode = json['country_code'];
    phone = json['phone'];
  }

  String? fullName;
  String? _userCode;
  String? email;
  School? school;
  String? relationWithJnv;
  int? fromYear;
  int? toYear;
  Qualification? qualification;
  Occupation? occupation;
  String? gender;
  String? house;
  String? birthDate;
  String? aboutMe;
  dynamic currentAddress;
  dynamic permanentAddress;
  UserImage? userImage;
  String? authToken;
  String? _lastLoginTime;
  int? _isUserAccountVerified;
  int? _isPhoneVerified;
  int? _isBasicProfileUpdated;
  int? _jnvVerificationStatus;
  int? allowNotifications;
  SocialProfileLinks? socialProfileLinks;
  DisplaySettings? _displaySettings;
  String? _id;
  String? _countryCode;
  String? phone;

  String? get userCode => _userCode;

  String? get lastLoginTime => _lastLoginTime;

  int? get isUserAccountVerified => _isUserAccountVerified;

  int? get isPhoneVerified => _isPhoneVerified;

  int? get isBasicProfileUpdated => _isBasicProfileUpdated;

  int? get jnvVerificationStatus => _jnvVerificationStatus;

  DisplaySettings? get displaySettings => _displaySettings;

  String? get id => _id;

  String? get countryCode => _countryCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['full_name'] = fullName;
    map['user_code'] = _userCode;
    map['email'] = email;

    if (school != null) {
      map['school'] = school?.toJson();
    }
    map['relation_with_jnv'] = relationWithJnv;
    map['from_year'] = fromYear;
    map['qualification'] = qualification;
    map['occupation'] = occupation;
    map['to_year'] = toYear;
    map['gender'] = gender;
    map['house'] = house;
    map['birth_date'] = birthDate;
    map['about_me'] = aboutMe;
    map['current_address'] = currentAddress;
    map['permanent_address'] = permanentAddress;
    map['user_image'] = userImage;
    map['auth_token'] = authToken;
    map['last_login_time'] = _lastLoginTime;
    map['is_user_account_verified'] = _isUserAccountVerified;
    map['is_phone_verified'] = _isPhoneVerified;
    map['is_basic_profile_updated'] = _isBasicProfileUpdated;
    map['jnv_verification_status'] = _jnvVerificationStatus;
    map['allow_notifications'] = allowNotifications;
    if (socialProfileLinks != null) {
      map['social_profile_links'] = socialProfileLinks?.toJson();
    }
    if (_displaySettings != null) {
      map['display_settings'] = _displaySettings?.toJson();
    }
    map['_id'] = _id;
    map['country_code'] = _countryCode;
    map['phone'] = phone;
    return map;
  }
}

/// phone : "my_connections"
/// email : "none"
/// user_image : "all"
/// birth_day_month : "all"
/// birth_year : "none"
/// current_address : "my_connections"
/// permanent_address : "my_connections"
/// social_profile_links : "all"
/// find_me_nearby : "all"

class DisplaySettings {
  DisplaySettings(
      {String? phone,
      String? email,
      String? userImage,
      String? birthDayMonth,
      String? birthYear,
      String? currentAddress,
      String? permanentAddress,
      String? socialProfileLinks,
      String? findMeNearby,
      String? sendMessages}) {
    this.phone;
    this.email;
    this.userImage;
    this.birthDayMonth;
    this.birthYear;
    this.currentAddress;
    this.permanentAddress;
    this.socialProfileLinks;
    this.findMeNearby;
    this.sendMessages;
  }

  DisplaySettings.fromJson(dynamic json) {
    phone = json['phone'];
    email = json['email'];
    userImage = json['user_image'];
    birthDayMonth = json['birth_day_month'];
    birthYear = json['birth_year'];
    currentAddress = json['current_address'];
    permanentAddress = json['permanent_address'];
    socialProfileLinks = json['social_profile_links'];
    findMeNearby = json['find_me_nearby'];
    sendMessages = json['send_messages'];
  }

  String? phone;
  String? email;
  String? userImage;
  String? birthDayMonth;
  String? birthYear;
  String? currentAddress;
  String? permanentAddress;
  String? socialProfileLinks;
  String? findMeNearby;
  String? sendMessages;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['phone'] = phone;
    map['email'] = email;
    map['user_image'] = userImage;
    map['birth_day_month'] = birthDayMonth;
    map['birth_year'] = birthYear;
    map['current_address'] = currentAddress;
    map['permanent_address'] = permanentAddress;
    map['social_profile_links'] = socialProfileLinks;
    map['find_me_nearby'] = findMeNearby;
    map['send_messages'] = sendMessages;
    return map;
  }
}

/// _id : "62b5ed9c3d4fd3fb3adcd7b0"
/// area : "Private Company"
/// type : "Accounting, Banking & Finance"
/// title : "Banking Professional"

class Occupation {
  Occupation({
    String? id,
    String? area,
    String? type,
    String? title,
  }) {
    _id = id;
    _area = area;
    _type = type;
    _title = title;
  }

  Occupation.fromJson(dynamic json) {
    _id = json['_id'];
    _area = json['area'];
    _type = json['type'];
    _title = json['title'];
  }

  String? _id;
  String? _area;
  String? _type;
  String? _title;

  String? get id => _id;

  String? get area => _area;

  String? get type => _type;

  String? get title => _title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['area'] = _area;
    map['type'] = _type;
    map['title'] = _title;
    return map;
  }
}

/// _id : "62b5ed9c3d4fd3fb3adcd7af"
/// area : "Engineering"
/// title : "Bachelor of Engineering"
/// shortname : "B.E / B.Tech"

class Qualification {
  Qualification({
    String? id,
    String? area,
    String? title,
    String? shortname,
  }) {
    _id = id;
    _area = area;
    _title = title;
    _shortname = shortname;
  }

  Qualification.fromJson(dynamic json) {
    _id = json['_id'];
    _area = json['area'];
    _title = json['title'];
    _shortname = json['shortname'];
  }

  String? _id;
  String? _area;
  String? _title;
  String? _shortname;

  String? get id => _id;

  String? get area => _area;

  String? get title => _title;

  String? get shortname => _shortname;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['area'] = _area;
    map['title'] = _title;
    map['shortname'] = _shortname;
    return map;
  }
}

/// facebook : "www.facebook.com"
/// instagram : "www.instagram.com"
/// linkedin : "www.linkedIn.com"
/// twitter : "www.twitter.com"
/// youtube : "www.youtube.com"

class SocialProfileLinks {
  SocialProfileLinks({
    String? facebook,
    String? instagram,
    String? linkedin,
    String? twitter,
    String? youtube,
  }) {
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
}

/// _id : "62879b983a3e730c64e33d7e"
/// region : "Jaipur"
/// state : "Rajasthan"
/// district : "Barmer"
/// city : "Pachpadra"
/// pincode : "344032"
/// latitude : 25.9126614
/// longitude : 72.2547811

class School {
  School({
    String? id,
    String? region,
    String? state,
    String? district,
    String? city,
    String? pincode,
    double? latitude,
    double? longitude,
  }) {
    _id = id;
    _region = region;
    _state = state;
    _district = district;
    _city = city;
    _pincode = pincode;
    _latitude = latitude;
    _longitude = longitude;
  }

  School.fromJson(dynamic json) {
    _id = json['_id'];
    _region = json['region'];
    _state = json['state'];
    _district = json['district'];
    _city = json['city'];
    _pincode = json['pincode'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
  }

  String? _id;
  String? _region;
  String? _state;
  String? _district;
  String? _city;
  String? _pincode;
  double? _latitude;
  double? _longitude;

  String? get id => _id;

  String? get region => _region;

  String? get state => _state;

  String? get district => _district;

  String? get city => _city;

  String? get pincode => _pincode;

  double? get latitude => _latitude;

  double? get longitude => _longitude;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['region'] = _region;
    map['state'] = _state;
    map['district'] = _district;
    map['city'] = _city;
    map['pincode'] = _pincode;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    return map;
  }
}
