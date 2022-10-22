/// message : "SUCCESS"
/// data : {"docs":[{"_id":"634077c504b4beed23b0892f","report_user":"631dc2c90f56f3b397367497","reason":"mis behave","reported_on":"2022-10-07T19:02:29.376Z","action_status":"pending","user":[{"_id":"631dc2c90f56f3b397367497","full_name":"Isiahi Moret","school":{"_id":"631d8bf1d5f4175af07fc488","latitude":null,"longitude":null,"region":"Chandigarh","state":"Chandigarh (UT)","district":"Chandigarh","city":"Chandigarh","pincode":"160014"},"user_image":{"filepath":"","fileurl":"https://images.squarespace-cdn.com/content/v1/55f6788be4b04a24f1745947/1578688476398-B8KI7LG6OOSFDTCXCLOO/Barcelona_couple_photoshoot_07.jpg","thumbpath":"","thumburl":"https://images.squarespace-cdn.com/content/v1/55f6788be4b04a24f1745947/1578688476398-B8KI7LG6OOSFDTCXCLOO/Barcelona_couple_photoshoot_07.jpg"}}]}],"totalDocs":1,"limit":50,"page":1,"totalPages":1,"pagingCounter":1,"hasPrevPage":false,"hasNextPage":false,"prevPage":null,"nextPage":null}

class ReportedUserModel {
  ReportedUserModel({
    String? message,
    Data? data,
  }) {
    _message = message;
    _data = data;
  }

  ReportedUserModel.fromJson(dynamic json) {
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

/// docs : [{"_id":"634077c504b4beed23b0892f","report_user":"631dc2c90f56f3b397367497","reason":"mis behave","reported_on":"2022-10-07T19:02:29.376Z","action_status":"pending","user":[{"_id":"631dc2c90f56f3b397367497","full_name":"Isiahi Moret","school":{"_id":"631d8bf1d5f4175af07fc488","latitude":null,"longitude":null,"region":"Chandigarh","state":"Chandigarh (UT)","district":"Chandigarh","city":"Chandigarh","pincode":"160014"},"user_image":{"filepath":"","fileurl":"https://images.squarespace-cdn.com/content/v1/55f6788be4b04a24f1745947/1578688476398-B8KI7LG6OOSFDTCXCLOO/Barcelona_couple_photoshoot_07.jpg","thumbpath":"","thumburl":"https://images.squarespace-cdn.com/content/v1/55f6788be4b04a24f1745947/1578688476398-B8KI7LG6OOSFDTCXCLOO/Barcelona_couple_photoshoot_07.jpg"}}]}]
/// totalDocs : 1
/// limit : 50
/// page : 1
/// totalPages : 1
/// pagingCounter : 1
/// hasPrevPage : false
/// hasNextPage : false
/// prevPage : null
/// nextPage : null

class Data {
  Data({
    List<ReportedUserData>? docs,
    int? totalDocs,
    int? limit,
    int? page,
    int? totalPages,
    int? pagingCounter,
    bool? hasPrevPage,
    bool? hasNextPage,
    dynamic prevPage,
    dynamic nextPage,
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

  Data.fromJson(dynamic json) {
    if (json['docs'] != null) {
      _docs = [];
      json['docs'].forEach((v) {
        _docs?.add(ReportedUserData.fromJson(v));
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

  List<ReportedUserData>? _docs;
  int? _totalDocs;
  int? _limit;
  int? _page;
  int? _totalPages;
  int? _pagingCounter;
  bool? _hasPrevPage;
  bool? _hasNextPage;
  dynamic _prevPage;
  dynamic _nextPage;

  List<ReportedUserData>? get docs => _docs;

  int? get totalDocs => _totalDocs;

  int? get limit => _limit;

  int? get page => _page;

  int? get totalPages => _totalPages;

  int? get pagingCounter => _pagingCounter;

  bool? get hasPrevPage => _hasPrevPage;

  bool? get hasNextPage => _hasNextPage;

  dynamic get prevPage => _prevPage;

  dynamic get nextPage => _nextPage;

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

/// _id : "634077c504b4beed23b0892f"
/// report_user : "631dc2c90f56f3b397367497"
/// reason : "mis behave"
/// reported_on : "2022-10-07T19:02:29.376Z"
/// action_status : "pending"
/// user : [{"_id":"631dc2c90f56f3b397367497","full_name":"Isiahi Moret","school":{"_id":"631d8bf1d5f4175af07fc488","latitude":null,"longitude":null,"region":"Chandigarh","state":"Chandigarh (UT)","district":"Chandigarh","city":"Chandigarh","pincode":"160014"},"user_image":{"filepath":"","fileurl":"https://images.squarespace-cdn.com/content/v1/55f6788be4b04a24f1745947/1578688476398-B8KI7LG6OOSFDTCXCLOO/Barcelona_couple_photoshoot_07.jpg","thumbpath":"","thumburl":"https://images.squarespace-cdn.com/content/v1/55f6788be4b04a24f1745947/1578688476398-B8KI7LG6OOSFDTCXCLOO/Barcelona_couple_photoshoot_07.jpg"}}]

class ReportedUserData {
  ReportedUserData({
    String? id,
    String? reportUser,
    String? reason,
    String? reportedOn,
    String? actionStatus,
    ReportedUserDetails? user,
  }) {
    _id = id;
    _reportUser = reportUser;
    _reason = reason;
    _reportedOn = reportedOn;
    _actionStatus = actionStatus;
    _user = user;
  }

  ReportedUserData.fromJson(dynamic json) {
    _id = json['_id'];
    _reportUser = json['report_user'];
    _reason = json['reason'];
    _reportedOn = json['reported_on'];
    _actionStatus = json['action_status'];
    if (json['user'] != null) {
      /*_user = [];
      json['user'].forEach((v) {
        _user?.add(ReportedUserDetails.fromJson(v));
      });*/
      _user = ReportedUserDetails.fromJson(json['user']);
    }
  }

  String? _id;
  String? _reportUser;
  String? _reason;
  String? _reportedOn;
  String? _actionStatus;

  //List<ReportedUserDetails>? _user;
  ReportedUserDetails? _user;

  String? get id => _id;

  String? get reportUser => _reportUser;

  String? get reason => _reason;

  String? get reportedOn => _reportedOn;

  String? get actionStatus => _actionStatus;

  ReportedUserDetails? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['report_user'] = _reportUser;
    map['reason'] = _reason;
    map['reported_on'] = _reportedOn;
    map['action_status'] = _actionStatus;
    if (_user != null) {
      map['user'] = _user;
    }
    return map;
  }
}

/// _id : "631dc2c90f56f3b397367497"
/// full_name : "Isiahi Moret"
/// school : {"_id":"631d8bf1d5f4175af07fc488","latitude":null,"longitude":null,"region":"Chandigarh","state":"Chandigarh (UT)","district":"Chandigarh","city":"Chandigarh","pincode":"160014"}
/// user_image : {"filepath":"","fileurl":"https://images.squarespace-cdn.com/content/v1/55f6788be4b04a24f1745947/1578688476398-B8KI7LG6OOSFDTCXCLOO/Barcelona_couple_photoshoot_07.jpg","thumbpath":"","thumburl":"https://images.squarespace-cdn.com/content/v1/55f6788be4b04a24f1745947/1578688476398-B8KI7LG6OOSFDTCXCLOO/Barcelona_couple_photoshoot_07.jpg"}

class ReportedUserDetails {
  ReportedUserDetails({
    String? id,
    String? fullName,
    School? school,
    UserImage? userImage,
  }) {
    _id = id;
    _fullName = fullName;
    _school = school;
    _userImage = userImage;
  }

  ReportedUserDetails.fromJson(dynamic json) {
    _id = json['_id'];
    _fullName = json['full_name'];
    _school = json['school'] != null ? School.fromJson(json['school']) : null;
    _userImage = json['user_image'] != null ? UserImage.fromJson(json['user_image']) : null;
  }

  String? _id;
  String? _fullName;
  School? _school;
  UserImage? _userImage;

  String? get id => _id;

  String? get fullName => _fullName;

  School? get school => _school;

  UserImage? get userImage => _userImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['full_name'] = _fullName;
    if (_school != null) {
      map['school'] = _school?.toJson();
    }
    if (_userImage != null) {
      map['user_image'] = _userImage?.toJson();
    }
    return map;
  }
}

/// filepath : ""
/// fileurl : "https://images.squarespace-cdn.com/content/v1/55f6788be4b04a24f1745947/1578688476398-B8KI7LG6OOSFDTCXCLOO/Barcelona_couple_photoshoot_07.jpg"
/// thumbpath : ""
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

/// _id : "631d8bf1d5f4175af07fc488"
/// latitude : null
/// longitude : null
/// region : "Chandigarh"
/// state : "Chandigarh (UT)"
/// district : "Chandigarh"
/// city : "Chandigarh"
/// pincode : "160014"

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
