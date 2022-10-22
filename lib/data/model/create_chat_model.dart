import 'users_model.dart';

/// message : "SUCCESS"
/// data : {"_id":"62b6ff0974404e181decee02","user":{"full_name":"Test User 3","user_image":null,"_id":"62b5f9dfebd6a019bbbf039b"}}

class CreateChatModel {
  CreateChatModel({
    String? message,
    ChatDetailsModel? data,
  }) {
    _message = message;
    _data = data;
  }

  CreateChatModel.fromJson(dynamic json) {
    _message = json['message'];
    _data = json['data'] != null ? ChatDetailsModel.fromJson(json['data']) : null;
  }

  String? _message;
  ChatDetailsModel? _data;

  String? get message => _message;

  ChatDetailsModel? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }

    return map;
  }
}

/// _id : "62b6ff0974404e181decee02"
/// user : {"full_name":"Test User 3","user_image":null,"_id":"62b5f9dfebd6a019bbbf039b"}

class ChatDetailsModel {
  ChatDetailsModel({
    String? id,
    User? user,
  }) {
    _id = id;
    _user = user;
  }

  ChatDetailsModel.fromJson(dynamic json) {
    _id = json['_id'];
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  String? _id;
  User? _user;

  String? get id => _id;

  User? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    return map;
  }
}

/// full_name : "Test User 3"
/// user_image : null
/// _id : "62b5f9dfebd6a019bbbf039b"

class User {
  User(
      {String? fullName,
      UserImage? userImage,
      String? id,
      DisplayImageSettings? displayImageSettings,
      bool? isConnected}) {
    _fullName = fullName;
    _userImage = userImage;
    _id = id;
    _displayImageSettings = displayImageSettings;
    _isConnected = isConnected;
  }

  User.fromJson(dynamic json) {
    _fullName = json['full_name'];
    _userImage = null;
    if (json['user_image'] != null) {
      if (json['user_image'] is String) {
        _userImage = null;
      } else {
        _userImage = UserImage.fromJson(json['user_image']);
      }
    }

    if (json['display_settings'] != null) {
      _displayImageSettings = DisplayImageSettings.fromJson(json['display_settings']);
    }

    _id = json['_id'];
    if (json['is_connected'] != null) {
      _isConnected = json['is_connected'];
    }
  }

  String? _fullName;
  UserImage? _userImage;
  String? _id;
  DisplayImageSettings? _displayImageSettings;
  bool? _isConnected;

  String? get fullName => _fullName;

  UserImage? get userImage => _userImage;

  String? get id => _id;

  DisplayImageSettings? get displayImageSettings => _displayImageSettings;

  bool? get isConnected => _isConnected;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['full_name'] = _fullName;

    map['user_image'] = _userImage;
    map['_id'] = _id;
    map['is_connected'] = _isConnected;
    if (_displayImageSettings != null) {
      map['display_settings'] = _displayImageSettings?.toJson();
    }
    return map;
  }
}

class DisplayImageSettings {
  DisplayImageSettings({
    String? showImageTo,
  }) {
    _showImageTo = showImageTo;
  }

  String? _showImageTo;

  DisplayImageSettings.fromJson(dynamic json) {
    _showImageTo = json['user_image'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (map['display_settings']) {
      map['display_settings'] = _showImageTo;
    }
    return map;
  }

  String? get showImageTo => _showImageTo;
}
