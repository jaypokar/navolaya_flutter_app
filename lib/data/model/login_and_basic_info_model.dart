/// message : "Profile information updated successfully"
/// data : {"full_name":"Chandan Chhajer","user_code":"1656090012CJ","email":"","school":{"region":"Jaipur","state":"Rajasthan","district":"Barmer","city":"Pachpadra","pincode":"344032","latitude":25.9126614,"longitude":72.2547811},"relation_with_jnv":"alumni","from_year":2004,"to_year":2011,"qualification":{"_id":"62b5ed9c3d4fd3fb3adcd7af","area":"Engineering","title":"Bachelor of Engineering","shortname":"B.E / B.Tech"},"occupation":{"_id":"62b5ed9c3d4fd3fb3adcd7b0","area":"Private Company","type":"Accounting, Banking & Finance","title":"Banking Professional"},"gender":"male","house":"","birth_date":null,"about_me":"","current_address":null,"permanent_address":null,"user_image":null,"auth_token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJsb2dpbl91c2VyX2lkIjoiNjJiNWVjOWRkZjJhNzdlZGUzNTkyYzExIiwibG9naW5fdXNlcl9yb2xlIjoidXNlciIsImxvZ2luX3VzZXJfbmFtZSI6IkNoYW5kYW4gQ2hoYWplciIsImlhdCI6MTY1NjA5MDAxMiwiZXhwIjoxNjU2Njk0ODEyfQ.9xKF9kSuwJ7YZWjgfEwdfZmKeTlXZS-RY4TENN7G7Lk","last_login_time":"2022-06-24T17:00:12.522Z","is_user_account_verified":1,"is_phone_verified":1,"is_basic_profile_updated":1,"jnv_verification_status":0,"allow_notifications":1,"social_profile_links":null,"display_settings":{"phone":"my_connections","email":"none","user_image":"all","birth_day_month":"all","birth_year":"none","current_address":"my_connections","permanent_address":"my_connections","social_profile_links":"all","current_location":"all"},"_id":"62b5ec9ddf2a77ede3592c11","country_code":"+91","phone":"9983730875"}

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

/// full_name : "Chandan Chhajer"
/// user_code : "1656090012CJ"
/// email : ""
/// school : {"region":"Jaipur","state":"Rajasthan","district":"Barmer","city":"Pachpadra","pincode":"344032","latitude":25.9126614,"longitude":72.2547811}
/// relation_with_jnv : "alumni"
/// from_year : 2004
/// to_year : 2011
/// qualification : {"_id":"62b5ed9c3d4fd3fb3adcd7af","area":"Engineering","title":"Bachelor of Engineering","shortname":"B.E / B.Tech"}
/// occupation : {"_id":"62b5ed9c3d4fd3fb3adcd7b0","area":"Private Company","type":"Accounting, Banking & Finance","title":"Banking Professional"}
/// gender : "male"
/// house : ""
/// birth_date : null
/// about_me : ""
/// current_address : null
/// permanent_address : null
/// user_image : null
/// auth_token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJsb2dpbl91c2VyX2lkIjoiNjJiNWVjOWRkZjJhNzdlZGUzNTkyYzExIiwibG9naW5fdXNlcl9yb2xlIjoidXNlciIsImxvZ2luX3VzZXJfbmFtZSI6IkNoYW5kYW4gQ2hoYWplciIsImlhdCI6MTY1NjA5MDAxMiwiZXhwIjoxNjU2Njk0ODEyfQ.9xKF9kSuwJ7YZWjgfEwdfZmKeTlXZS-RY4TENN7G7Lk"
/// last_login_time : "2022-06-24T17:00:12.522Z"
/// is_user_account_verified : 1
/// is_phone_verified : 1
/// is_basic_profile_updated : 1
/// jnv_verification_status : 0
/// allow_notifications : 1
/// social_profile_links : null
/// display_settings : {"phone":"my_connections","email":"none","user_image":"all","birth_day_month":"all","birth_year":"none","current_address":"my_connections","permanent_address":"my_connections","social_profile_links":"all","current_location":"all"}
/// _id : "62b5ec9ddf2a77ede3592c11"
/// country_code : "+91"
/// phone : "9983730875"

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
    dynamic birthDate,
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
    dynamic socialProfileLinks,
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
    _house = house;
    _birthDate = birthDate;
    _aboutMe = aboutMe;
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
    _socialProfileLinks = socialProfileLinks;
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
    _qualification =
        json['qualification'] != null ? Qualification.fromJson(json['qualification']) : null;
    _occupation = json['occupation'] != null ? Occupation.fromJson(json['occupation']) : null;
    _gender = json['gender'];
    _house = json['house'];
    _birthDate = json['birth_date'];
    _aboutMe = json['about_me'];
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
    _socialProfileLinks = json['social_profile_links'];
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
  Qualification? _qualification;
  Occupation? _occupation;
  String? _gender;
  String? _house;
  dynamic _birthDate;
  String? _aboutMe;
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
  dynamic _socialProfileLinks;
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

  Qualification? get qualification => _qualification;

  Occupation? get occupation => _occupation;

  String? get gender => _gender;

  String? get house => _house;

  dynamic get birthDate => _birthDate;

  String? get aboutMe => _aboutMe;

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

  dynamic get socialProfileLinks => _socialProfileLinks;

  DisplaySettings? get displaySettings => _displaySettings;

  String? get id => _id;

  String? get countryCode => _countryCode;

  String? get phone => _phone;

  set aboutMe(String? value) {
    _aboutMe = value;
  }

  set birthDate(dynamic value) {
    _birthDate = value;
  }

  set house(String? value) {
    _house = value;
  }

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
    if (_qualification != null) {
      map['qualification'] = _qualification?.toJson();
    }
    if (_occupation != null) {
      map['occupation'] = _occupation?.toJson();
    }
    map['gender'] = _gender;
    map['house'] = _house;
    map['birth_date'] = _birthDate;
    map['about_me'] = _aboutMe;
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
    map['social_profile_links'] = _socialProfileLinks;
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
/// current_location : "all"

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
    String? currentLocation,
  }) {
    _phone = phone;
    _email = email;
    _userImage = userImage;
    _birthDayMonth = birthDayMonth;
    _birthYear = birthYear;
    _currentAddress = currentAddress;
    _permanentAddress = permanentAddress;
    _socialProfileLinks = socialProfileLinks;
    _currentLocation = currentLocation;
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
    _currentLocation = json['current_location'];
  }

  String? _phone;
  String? _email;
  String? _userImage;
  String? _birthDayMonth;
  String? _birthYear;
  String? _currentAddress;
  String? _permanentAddress;
  String? _socialProfileLinks;
  String? _currentLocation;

  String? get phone => _phone;

  String? get email => _email;

  String? get userImage => _userImage;

  String? get birthDayMonth => _birthDayMonth;

  String? get birthYear => _birthYear;

  String? get currentAddress => _currentAddress;

  String? get permanentAddress => _permanentAddress;

  String? get socialProfileLinks => _socialProfileLinks;

  String? get currentLocation => _currentLocation;

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
    map['current_location'] = _currentLocation;
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

/// region : "Jaipur"
/// state : "Rajasthan"
/// district : "Barmer"
/// city : "Pachpadra"
/// pincode : "344032"
/// latitude : 25.9126614
/// longitude : 72.2547811

class School {
  School({
    String? region,
    String? state,
    String? district,
    String? city,
    String? pincode,
    double? latitude,
    double? longitude,
  }) {
    _region = region;
    _state = state;
    _district = district;
    _city = city;
    _pincode = pincode;
    _latitude = latitude;
    _longitude = longitude;
  }

  School.fromJson(dynamic json) {
    _region = json['region'];
    _state = json['state'];
    _district = json['district'];
    _city = json['city'];
    _pincode = json['pincode'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
  }

  String? _region;
  String? _state;
  String? _district;
  String? _city;
  String? _pincode;
  double? _latitude;
  double? _longitude;

  String? get region => _region;

  String? get state => _state;

  String? get district => _district;

  String? get city => _city;

  String? get pincode => _pincode;

  double? get latitude => _latitude;

  double? get longitude => _longitude;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
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
