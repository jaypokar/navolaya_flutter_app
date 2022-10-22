/// message : "Your profile image has changed successfully"
/// data : {"allow_notifications":1,"user_image":{"filepath":"dev/user-images/abc.jpg","fileurl":"https://navolaya.s3.ap-south-1.amazonaws.com/local/user-images/abc.jpg","thumbpath":"dev/user-images/thumbabc.jpg","thumburl":"https://navolaya.s3.ap-south-1.amazonaws.com/local/user-images/thumbabc.jpg"}}

class ProfileImageOrAllowNotificationModel {
  ProfileImageOrAllowNotificationModel({
    String? message,
    Data? data,
  }) {
    _message = message;
    _data = data;
  }

  ProfileImageOrAllowNotificationModel.fromJson(dynamic json) {
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

/// allow_notifications : 1
/// user_image : {"filepath":"dev/user-images/abc.jpg","fileurl":"https://navolaya.s3.ap-south-1.amazonaws.com/local/user-images/abc.jpg","thumbpath":"dev/user-images/thumbabc.jpg","thumburl":"https://navolaya.s3.ap-south-1.amazonaws.com/local/user-images/thumbabc.jpg"}

class Data {
  Data({int? allowNotifications, UserImage? userImage, String? authToken}) {
    _allowNotifications = allowNotifications;
    _userImage = userImage;
    _authToken = authToken;
  }

  Data.fromJson(dynamic json) {
    if (json['allow_notifications'] != null) {
      _allowNotifications = json['allow_notifications'] ?? 1;
    }
    if (json['user_image'] != null) {
      _userImage = UserImage.fromJson(json['user_image']);
    }
    _authToken = json['auth_token'];
  }

  int? _allowNotifications;
  UserImage? _userImage;
  String? _authToken;

  int? get allowNotifications => _allowNotifications;

  UserImage? get userImage => _userImage;

  String? get authToken => _authToken;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['allow_notifications'] = _allowNotifications;
    if (_userImage != null) {
      map['user_image'] = _userImage?.toJson();
    }
    return map;
  }
}

/// filepath : "dev/user-images/abc.jpg"
/// fileurl : "https://navolaya.s3.ap-south-1.amazonaws.com/local/user-images/abc.jpg"
/// thumbpath : "dev/user-images/thumbabc.jpg"
/// thumburl : "https://navolaya.s3.ap-south-1.amazonaws.com/local/user-images/thumbabc.jpg"

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
