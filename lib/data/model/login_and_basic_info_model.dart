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
    dynamic qualification,
    dynamic occupation,
    String? gender,
    String? house,
    String? birthDate,
    String? aboutMe,
    dynamic currentAddress,
    dynamic permanentAddress,
    dynamic userImage,
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
    _fullName = fullName;
    _userCode = userCode;
    _email = email;
    _school = school;
    _relationWithJnv = relationWithJnv;
    _fromYear = fromYear;
    _toYear = toYear;
    _qualification = qualification;
    _occupation = occupation;
    _gender = gender;
    this.house = house;
    this.birthDate = birthDate;
    this.aboutMe = aboutMe;
    _currentAddress = currentAddress;
    _permanentAddress = permanentAddress;
    _userImage = userImage;
    _authToken = authToken;
    _lastLoginTime = lastLoginTime;
    _isUserAccountVerified = isUserAccountVerified;
    _isPhoneVerified = isPhoneVerified;
    _isBasicProfileUpdated = isBasicProfileUpdated;
    _jnvVerificationStatus = jnvVerificationStatus;
    _allowNotifications = allowNotifications;
    this.socialProfileLinks = socialProfileLinks;
    _displaySettings = displaySettings;
    _id = id;
    _countryCode = countryCode;
    _phone = phone;
  }

  Data.fromJson(dynamic json) {
    _fullName = json['full_name'];
    _userCode = json['user_code'];
    _email = json['email'];
    _school = json['school'] != null ? School.fromJson(json['school']) : null;
    _relationWithJnv = json['relation_with_jnv'];
    _fromYear = json['from_year'];
    _toYear = json['to_year'];
    _qualification = json['qualification'];
    _occupation = json['occupation'];
    _gender = json['gender'];
    house = json['house'];
    birthDate = json['birth_date'];
    aboutMe = json['about_me'];
    _currentAddress = json['current_address'];
    _permanentAddress = json['permanent_address'];
    _userImage = json['user_image'];
    _authToken = json['auth_token'];
    _lastLoginTime = json['last_login_time'];
    _isUserAccountVerified = json['is_user_account_verified'];
    _isPhoneVerified = json['is_phone_verified'];
    _isBasicProfileUpdated = json['is_basic_profile_updated'];
    _jnvVerificationStatus = json['jnv_verification_status'];
    _allowNotifications = json['allow_notifications'];
    socialProfileLinks = json['social_profile_links'] != null
        ? SocialProfileLinks.fromJson(json['social_profile_links'])
        : null;
    _displaySettings = json['display_settings'] != null
        ? DisplaySettings.fromJson(json['display_settings'])
        : null;
    _id = json['_id'];
    _countryCode = json['country_code'];
    _phone = json['phone'];
  }

  String? _fullName;
  String? _userCode;
  String? _email;
  School? _school;
  String? _relationWithJnv;
  int? _fromYear;
  int? _toYear;
  dynamic _qualification;
  dynamic _occupation;
  String? _gender;
  String? house;
  String? birthDate;
  String? aboutMe;
  dynamic _currentAddress;
  dynamic _permanentAddress;
  dynamic _userImage;
  String? _authToken;
  String? _lastLoginTime;
  int? _isUserAccountVerified;
  int? _isPhoneVerified;
  int? _isBasicProfileUpdated;
  int? _jnvVerificationStatus;
  int? _allowNotifications;
  SocialProfileLinks? socialProfileLinks;
  DisplaySettings? _displaySettings;
  String? _id;
  String? _countryCode;
  String? _phone;

  String? get fullName => _fullName;

  String? get userCode => _userCode;

  String? get email => _email;

  School? get school => _school;

  String? get relationWithJnv => _relationWithJnv;

  int? get fromYear => _fromYear;

  int? get toYear => _toYear;

  dynamic get qualification => _qualification;

  dynamic get occupation => _occupation;

  String? get gender => _gender;

  dynamic get currentAddress => _currentAddress;

  dynamic get permanentAddress => _permanentAddress;

  dynamic get userImage => _userImage;

  String? get authToken => _authToken;

  String? get lastLoginTime => _lastLoginTime;

  int? get isUserAccountVerified => _isUserAccountVerified;
  int? get isPhoneVerified => _isPhoneVerified;
  int? get isBasicProfileUpdated => _isBasicProfileUpdated;
  int? get jnvVerificationStatus => _jnvVerificationStatus;
  int? get allowNotifications => _allowNotifications;
  DisplaySettings? get displaySettings => _displaySettings;
  String? get id => _id;
  String? get countryCode => _countryCode;
  String? get phone => _phone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['full_name'] = _fullName;
    map['user_code'] = _userCode;
    map['email'] = _email;
    if (_school != null) {
      map['school'] = _school?.toJson();
    }
    map['relation_with_jnv'] = _relationWithJnv;
    map['from_year'] = _fromYear;
    map['to_year'] = _toYear;
    map['qualification'] = _qualification;
    map['occupation'] = _occupation;
    map['gender'] = _gender;
    map['house'] = house;
    map['birth_date'] = birthDate;
    map['about_me'] = aboutMe;
    map['current_address'] = _currentAddress;
    map['permanent_address'] = _permanentAddress;
    map['user_image'] = _userImage;
    map['auth_token'] = _authToken;
    map['last_login_time'] = _lastLoginTime;
    map['is_user_account_verified'] = _isUserAccountVerified;
    map['is_phone_verified'] = _isPhoneVerified;
    map['is_basic_profile_updated'] = _isBasicProfileUpdated;
    map['jnv_verification_status'] = _jnvVerificationStatus;
    map['allow_notifications'] = _allowNotifications;
    if (socialProfileLinks != null) {
      map['social_profile_links'] = socialProfileLinks?.toJson();
    }
    if (_displaySettings != null) {
      map['display_settings'] = _displaySettings?.toJson();
    }
    map['_id'] = _id;
    map['country_code'] = _countryCode;
    map['phone'] = _phone;
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
  DisplaySettings({
    String? phone,
    String? email,
    String? userImage,
    String? birthDayMonth,
    String? birthYear,
    String? currentAddress,
    String? permanentAddress,
    String? socialProfileLinks,
    String? findMeNearby,
  }) {
    _phone = phone;
    _email = email;
    _userImage = userImage;
    _birthDayMonth = birthDayMonth;
    _birthYear = birthYear;
    _currentAddress = currentAddress;
    _permanentAddress = permanentAddress;
    _socialProfileLinks = socialProfileLinks;
    _findMeNearby = findMeNearby;
  }

  DisplaySettings.fromJson(dynamic json) {
    _phone = json['phone'];
    _email = json['email'];
    _userImage = json['user_image'];
    _birthDayMonth = json['birth_day_month'];
    _birthYear = json['birth_year'];
    _currentAddress = json['current_address'];
    _permanentAddress = json['permanent_address'];
    _socialProfileLinks = json['social_profile_links'];
    _findMeNearby = json['find_me_nearby'];
  }

  String? _phone;
  String? _email;
  String? _userImage;
  String? _birthDayMonth;
  String? _birthYear;
  String? _currentAddress;
  String? _permanentAddress;
  String? _socialProfileLinks;
  String? _findMeNearby;

  String? get phone => _phone;

  String? get email => _email;

  String? get userImage => _userImage;

  String? get birthDayMonth => _birthDayMonth;

  String? get birthYear => _birthYear;

  String? get currentAddress => _currentAddress;

  String? get permanentAddress => _permanentAddress;

  String? get socialProfileLinks => _socialProfileLinks;

  String? get findMeNearby => _findMeNearby;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['phone'] = _phone;
    map['email'] = _email;
    map['user_image'] = _userImage;
    map['birth_day_month'] = _birthDayMonth;
    map['birth_year'] = _birthYear;
    map['current_address'] = _currentAddress;
    map['permanent_address'] = _permanentAddress;
    map['social_profile_links'] = _socialProfileLinks;
    map['find_me_nearby'] = _findMeNearby;
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