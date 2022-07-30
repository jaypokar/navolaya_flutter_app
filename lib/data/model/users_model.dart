/// message : "SUCCESS"
/// data : {"docs":[{"_id":"62b5f9dfebd6a019bbbf0395","country_code":"+91","phone":"1219341744","full_name":"Test User 1","relation_with_jnv":"Other Staff","school":{"region":"Jaipur","state":"Rajasthan","district":"Barmer","city":"Pachpadra","pincode":"344032","latitude":25.9126614,"longitude":72.2547811},"from_year":2008,"to_year":2007,"qualification":{"_id":"62b5f9dfebd6a019bbbf0396","area":"Engineering","title":"Bachelor of Engineering","shortname":"B.E / B.Tech"},"occupation":{"_id":"62b5f9dfebd6a019bbbf0397","area":"Private Company","type":"Accounting, Banking & Finance","title":"Banking Professional"},"gender":"male","house":"Shivalik","birth_date":"1991-01-01T00:00:00.000Z","about_me":"","current_address":null,"permanent_address":null,"user_image":null,"social_profile_links":{"facebook":"","instagram":"","linkedin":"","twitter":"","youtube":""},"display_settings":{"phone":"my_connections","email":"none","user_image":"all","birth_day_month":"all","birth_year":"none","current_address":"my_connections","permanent_address":"my_connections","social_profile_links":"all","current_location":"all"},"distance":6.7538954761998475,"is_connected":false,"is_request_sent":true,"is_request_received":false}],"totalDocs":1,"limit":10,"page":1,"totalPages":1,"pagingCounter":1,"hasPrevPage":false,"hasNextPage":false,"prevPage":null,"nextPage":null}

class UsersModel {
  UsersModel({
    String? message,
    UsersDocsModel? data,
  }) {
    _message = message;
    _data = data;
  }

  UsersModel.fromJson(dynamic json) {
    _message = json['message'];
    _data = json['data'] != null ? UsersDocsModel.fromJson(json['data']) : null;
  }

  String? _message;
  UsersDocsModel? _data;

  String? get message => _message;

  UsersDocsModel? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }
}

/// docs : [{"_id":"62b5f9dfebd6a019bbbf0395","country_code":"+91","phone":"1219341744","full_name":"Test User 1","relation_with_jnv":"Other Staff","school":{"region":"Jaipur","state":"Rajasthan","district":"Barmer","city":"Pachpadra","pincode":"344032","latitude":25.9126614,"longitude":72.2547811},"from_year":2008,"to_year":2007,"qualification":{"_id":"62b5f9dfebd6a019bbbf0396","area":"Engineering","title":"Bachelor of Engineering","shortname":"B.E / B.Tech"},"occupation":{"_id":"62b5f9dfebd6a019bbbf0397","area":"Private Company","type":"Accounting, Banking & Finance","title":"Banking Professional"},"gender":"male","house":"Shivalik","birth_date":"1991-01-01T00:00:00.000Z","about_me":"","current_address":null,"permanent_address":null,"user_image":null,"social_profile_links":{"facebook":"","instagram":"","linkedin":"","twitter":"","youtube":""},"display_settings":{"phone":"my_connections","email":"none","user_image":"all","birth_day_month":"all","birth_year":"none","current_address":"my_connections","permanent_address":"my_connections","social_profile_links":"all","current_location":"all"},"distance":6.7538954761998475,"is_connected":false,"is_request_sent":true,"is_request_received":false}]
/// totalDocs : 1
/// limit : 10
/// page : 1
/// totalPages : 1
/// pagingCounter : 1
/// hasPrevPage : false
/// hasNextPage : false
/// prevPage : null
/// nextPage : null

class UsersDocsModel {
  UsersDocsModel({
    List<UserDataModel>? docs,
    int? totalDocs,
    int? limit,
    int? page,
    int? totalPages,
    int? pagingCounter,
    bool? hasPrevPage,
    bool? hasNextPage,
    int? prevPage,
    int? nextPage,
  }) {
    _docs = docs;
    _totalDocs = totalDocs;
    _limit = limit;
    _page = page;
    _totalPages = totalPages;
    _pagingCounter = pagingCounter;
    _hasPrevPage = hasPrevPage;
    _hasNextPage = hasNextPage;
    _prevPage = prevPage;
    _nextPage = nextPage;
  }

  UsersDocsModel.fromJson(dynamic json) {
    if (json['docs'] != null) {
      _docs = [];
      json['docs'].forEach((v) {
        _docs?.add(UserDataModel.fromJson(v));
      });
    }
    _totalDocs = json['totalDocs'];
    _limit = json['limit'];
    _page = json['page'];
    _totalPages = json['totalPages'];
    _pagingCounter = json['pagingCounter'];
    _hasPrevPage = json['hasPrevPage'];
    _hasNextPage = json['hasNextPage'];
    _prevPage = json['prevPage'];
    _nextPage = json['nextPage'];
  }

  List<UserDataModel>? _docs;
  int? _totalDocs;
  int? _limit;
  int? _page;
  int? _totalPages;
  int? _pagingCounter;
  bool? _hasPrevPage;
  bool? _hasNextPage;
  int? _prevPage;
  int? _nextPage;

  List<UserDataModel>? get docs => _docs;

  int? get totalDocs => _totalDocs;

  int? get limit => _limit;

  int? get page => _page;

  int? get totalPages => _totalPages;

  int? get pagingCounter => _pagingCounter;

  bool? get hasPrevPage => _hasPrevPage;

  bool? get hasNextPage => _hasNextPage;

  int? get prevPage => _prevPage;

  int? get nextPage => _nextPage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_docs != null) {
      map['docs'] = _docs?.map((v) => v.toJson()).toList();
    }
    map['totalDocs'] = _totalDocs;
    map['limit'] = _limit;
    map['page'] = _page;
    map['totalPages'] = _totalPages;
    map['pagingCounter'] = _pagingCounter;
    map['hasPrevPage'] = _hasPrevPage;
    map['hasNextPage'] = _hasNextPage;
    map['prevPage'] = _prevPage;
    map['nextPage'] = _nextPage;
    return map;
  }
}

/// _id : "62da36b6519f95469cba3262"
/// country_code : "+91"
/// phone : "9713650703"
/// full_name : "Raynard Abbet"
/// relation_with_jnv : "Other Staff"
/// school : {"_id":"62d8532bb64c7195dc16a53a","latitude":null,"longitude":null,"region":"Jaipur","state":"Rajasthan","district":"Jodhpur","city":"Tilwasni","pincode":"342605"}
/// from_year : 1995
/// to_year : 1997
/// qualification : {"_id":"62da36b6519f95469cba3264","area":"Law","id":"ML / LLM","title":"Master of Law","shortname":"ML / LLM"}
/// occupation : {"_id":"62da36b6519f95469cba3265","area":"Defense / Civil Services","type":"Advertising, Media & Entertainment","id":"Media Professional","title":"Media Professional"}
/// gender : "other"
/// house : "Aravali"
/// birth_date : "1975-10-07T00:00:00.000Z"
/// about_me : ""
/// current_address : null
/// permanent_address : null
/// user_image : {"filepath":"https://images.squarespace-cdn.com/content/v1/55f6788be4b04a24f1745947/1578688476398-B8KI7LG6OOSFDTCXCLOO/Barcelona_couple_photoshoot_07.jpg","fileurl":"https://images.squarespace-cdn.com/content/v1/55f6788be4b04a24f1745947/1578688476398-B8KI7LG6OOSFDTCXCLOO/Barcelona_couple_photoshoot_07.jpg","thumbpath":"https://images.squarespace-cdn.com/content/v1/55f6788be4b04a24f1745947/1578688476398-B8KI7LG6OOSFDTCXCLOO/Barcelona_couple_photoshoot_07.jpg","thumburl":"https://images.squarespace-cdn.com/content/v1/55f6788be4b04a24f1745947/1578688476398-B8KI7LG6OOSFDTCXCLOO/Barcelona_couple_photoshoot_07.jpg"}
/// social_profile_links : {"facebook":"http://businesswire.com/at/turpis/a/pede/posuere/nonummy/integer.jsp","instagram":"https://fema.gov/diam/erat/fermentum/justo/nec.js","linkedin":"https://unesco.org/vel/augue/vestibulum/rutrum.jpg","twitter":"","youtube":"https://booking.com/potenti/nullam/porttitor/lacus/at.jpg"}
/// display_settings : {"phone":"all","email":"none","user_image":"all","birth_day_month":"all","birth_year":"none","current_address":"my_connections","permanent_address":"my_connections","social_profile_links":"all"}
/// distance : null
/// is_connected : false
/// is_request_sent : false
/// is_request_received : false

class UserDataModel {
  UserDataModel({
    String? id,
    String? countryCode,
    String? phone,
    String? fullName,
    String? relationWithJnv,
    School? school,
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
    SocialProfileLinks? socialProfileLinks,
    DisplaySettings? displaySettings,
    dynamic distance,
    bool? isConnected,
    bool? isRequestSent,
    bool? isRequestReceived,
  }) {
    _id = id;
    _countryCode = countryCode;
    _phone = phone;
    _fullName = fullName;
    _relationWithJnv = relationWithJnv;
    _school = school;
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
    _socialProfileLinks = socialProfileLinks;
    _displaySettings = displaySettings;
    _distance = distance;
    this.isConnected;
    this.isRequestSent;
    this.isRequestReceived;
  }

  UserDataModel.fromJson(dynamic json) {
    _id = json['_id'];
    _countryCode = json['country_code'];
    _phone = json['phone'];
    _fullName = json['full_name'];
    _relationWithJnv = json['relation_with_jnv'];
    _school = json['school'] != null ? School.fromJson(json['school']) : null;
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
    _userImage = json['user_image'] != null ? UserImage.fromJson(json['user_image']) : null;
    _socialProfileLinks = json['social_profile_links'] != null
        ? SocialProfileLinks.fromJson(json['social_profile_links'])
        : null;
    _displaySettings = json['display_settings'] != null
        ? DisplaySettings.fromJson(json['display_settings'])
        : null;
    _distance = json['distance'];
    isConnected = json['is_connected'];
    isRequestSent = json['is_request_sent'];
    isRequestReceived = json['is_request_received'];
  }

  String? _id;
  String? _countryCode;
  String? _phone;
  String? _fullName;
  String? _relationWithJnv;
  School? _school;
  int? _fromYear;
  int? _toYear;
  Qualification? _qualification;
  Occupation? _occupation;
  String? _gender;
  String? _house;
  String? _birthDate;
  String? _aboutMe;
  dynamic _currentAddress;
  dynamic _permanentAddress;
  UserImage? _userImage;
  SocialProfileLinks? _socialProfileLinks;
  DisplaySettings? _displaySettings;
  dynamic _distance;
  bool? isConnected;
  bool? isRequestSent;
  bool? isRequestReceived;

  String? get id => _id;

  String? get countryCode => _countryCode;

  String? get phone => _phone;

  String? get fullName => _fullName;

  String? get relationWithJnv => _relationWithJnv;

  School? get school => _school;

  int? get fromYear => _fromYear;

  int? get toYear => _toYear;

  Qualification? get qualification => _qualification;

  Occupation? get occupation => _occupation;

  String? get gender => _gender;

  String? get house => _house;

  String? get birthDate => _birthDate;

  String? get aboutMe => _aboutMe;

  dynamic get currentAddress => _currentAddress;

  dynamic get permanentAddress => _permanentAddress;

  UserImage? get userImage => _userImage;

  SocialProfileLinks? get socialProfileLinks => _socialProfileLinks;

  DisplaySettings? get displaySettings => _displaySettings;

  dynamic get distance => _distance;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['country_code'] = _countryCode;
    map['phone'] = _phone;
    map['full_name'] = _fullName;
    map['relation_with_jnv'] = _relationWithJnv;
    if (_school != null) {
      map['school'] = _school?.toJson();
    }
    map['from_year'] = _fromYear;
    map['to_year'] = _toYear;
    if (_qualification != null) {
      map['qualification'] = _qualification?.toJson();
    }

    map['gender'] = _gender;
    map['house'] = _house;
    map['birth_date'] = _birthDate;
    map['about_me'] = _aboutMe;
    map['current_address'] = _currentAddress;
    map['permanent_address'] = _permanentAddress;
    if (_userImage != null) {
      map['user_image'] = _userImage?.toJson();
    }
    if (_socialProfileLinks != null) {
      map['social_profile_links'] = _socialProfileLinks?.toJson();
    }
    if (_displaySettings != null) {
      map['display_settings'] = _displaySettings?.toJson();
    }
    map['distance'] = _distance;
    map['is_connected'] = isConnected;
    map['is_request_sent'] = isRequestSent;
    map['is_request_received'] = isRequestReceived;
    return map;
  }
}

/// phone : "all"
/// email : "none"
/// user_image : "all"
/// birth_day_month : "all"
/// birth_year : "none"
/// current_address : "my_connections"
/// permanent_address : "my_connections"
/// social_profile_links : "all"

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
  }) {
    _phone = phone;
    _email = email;
    _userImage = userImage;
    _birthDayMonth = birthDayMonth;
    _birthYear = birthYear;
    _currentAddress = currentAddress;
    _permanentAddress = permanentAddress;
    _socialProfileLinks = socialProfileLinks;
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
  }

  String? _phone;
  String? _email;
  String? _userImage;
  String? _birthDayMonth;
  String? _birthYear;
  String? _currentAddress;
  String? _permanentAddress;
  String? _socialProfileLinks;

  String? get phone => _phone;

  String? get email => _email;

  String? get userImage => _userImage;

  String? get birthDayMonth => _birthDayMonth;

  String? get birthYear => _birthYear;

  String? get currentAddress => _currentAddress;

  String? get permanentAddress => _permanentAddress;

  String? get socialProfileLinks => _socialProfileLinks;

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
    return map;
  }
}

/// facebook : "http://businesswire.com/at/turpis/a/pede/posuere/nonummy/integer.jsp"
/// instagram : "https://fema.gov/diam/erat/fermentum/justo/nec.js"
/// linkedin : "https://unesco.org/vel/augue/vestibulum/rutrum.jpg"
/// twitter : ""
/// youtube : "https://booking.com/potenti/nullam/porttitor/lacus/at.jpg"

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

/// filepath : "https://images.squarespace-cdn.com/content/v1/55f6788be4b04a24f1745947/1578688476398-B8KI7LG6OOSFDTCXCLOO/Barcelona_couple_photoshoot_07.jpg"
/// fileurl : "https://images.squarespace-cdn.com/content/v1/55f6788be4b04a24f1745947/1578688476398-B8KI7LG6OOSFDTCXCLOO/Barcelona_couple_photoshoot_07.jpg"
/// thumbpath : "https://images.squarespace-cdn.com/content/v1/55f6788be4b04a24f1745947/1578688476398-B8KI7LG6OOSFDTCXCLOO/Barcelona_couple_photoshoot_07.jpg"
/// thumburl : "https://images.squarespace-cdn.com/content/v1/55f6788be4b04a24f1745947/1578688476398-B8KI7LG6OOSFDTCXCLOO/Barcelona_couple_photoshoot_07.jpg"

class UserImage {
  UserImage({
    String? filepath,
    String? fileurl,
    String? thumbpath,
    String? thumburl,
  }) {
    _filepath = filepath;
    _fileurl = fileurl;
    _thumbpath = thumbpath;
    _thumburl = thumburl;
  }

  UserImage.fromJson(dynamic json) {
    _filepath = json['filepath'];
    _fileurl = json['fileurl'];
    _thumbpath = json['thumbpath'];
    _thumburl = json['thumburl'];
  }

  String? _filepath;
  String? _fileurl;
  String? _thumbpath;
  String? _thumburl;

  String? get filepath => _filepath;

  String? get fileurl => _fileurl;

  String? get thumbpath => _thumbpath;

  String? get thumburl => _thumburl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['filepath'] = _filepath;
    map['fileurl'] = _fileurl;
    map['thumbpath'] = _thumbpath;
    map['thumburl'] = _thumburl;
    return map;
  }
}

/// _id : "62da36b6519f95469cba3265"
/// area : "Defense / Civil Services"
/// type : "Advertising, Media & Entertainment"
/// id : "Media Professional"
/// title : "Media Professional"

class Occupation {
  Occupation({
    String? id_,
    String? area,
    String? type,
    String? id,
    String? title,
  }) {
    __id = id_;
    _area = area;
    _type = type;
    _id = id;
    _title = title;
  }

  Occupation.fromJson(dynamic json) {
    __id = json['_id'];
    _area = json['area'];
    _type = json['type'];
    _id = json['id'];
    _title = json['title'];
  }

  String? __id;
  String? _area;
  String? _type;
  String? _id;
  String? _title;

  String? get id_ => __id;

  String? get area => _area;

  String? get type => _type;

  String? get id => _id;

  String? get title => _title;
}

/// _id : "62da36b6519f95469cba3264"
/// area : "Law"
/// id : "ML / LLM"
/// title : "Master of Law"
/// shortname : "ML / LLM"

class Qualification {
  Qualification({
    String? id_,
    String? area,
    String? id,
    String? title,
    String? shortname,
  }) {
    __id = id_;
    _area = area;
    _id = id;
    _title = title;
    _shortname = shortname;
  }

  Qualification.fromJson(dynamic json) {
    __id = json['_id'];
    _area = json['area'];
    _id = json['id'];
    _title = json['title'];
    _shortname = json['shortname'];
  }

  String? __id;
  String? _area;
  String? _id;
  String? _title;
  String? _shortname;

  String? get id_ => __id;

  String? get area => _area;

  String? get id => _id;

  String? get title => _title;

  String? get shortname => _shortname;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['area'] = _area;
    map['id'] = _id;
    map['title'] = _title;
    map['shortname'] = _shortname;
    return map;
  }
}

/// _id : "62d8532bb64c7195dc16a53a"
/// latitude : null
/// longitude : null
/// region : "Jaipur"
/// state : "Rajasthan"
/// district : "Jodhpur"
/// city : "Tilwasni"
/// pincode : "342605"

class School {
  School({
    String? id,
    dynamic latitude,
    dynamic longitude,
    String? region,
    String? state,
    String? district,
    String? city,
    String? pincode,
  }) {
    _id = id;
    _latitude = latitude;
    _longitude = longitude;
    _region = region;
    _state = state;
    _district = district;
    _city = city;
    _pincode = pincode;
  }

  School.fromJson(dynamic json) {
    _id = json['_id'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _region = json['region'];
    _state = json['state'];
    _district = json['district'];
    _city = json['city'];
    _pincode = json['pincode'];
  }

  String? _id;
  dynamic _latitude;
  dynamic _longitude;
  String? _region;
  String? _state;
  String? _district;
  String? _city;
  String? _pincode;

  String? get id => _id;

  dynamic get latitude => _latitude;

  dynamic get longitude => _longitude;

  String? get region => _region;

  String? get state => _state;

  String? get district => _district;

  String? get city => _city;

  String? get pincode => _pincode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    map['region'] = _region;
    map['state'] = _state;
    map['district'] = _district;
    map['city'] = _city;
    map['pincode'] = _pincode;
    return map;
  }
}
