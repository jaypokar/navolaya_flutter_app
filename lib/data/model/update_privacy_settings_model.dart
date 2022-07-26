/// message : "Privacy settings updated successfully"
/// data : {"display_settings":{"phone":"my_connections","email":"all","user_image":"all","birth_day_month":"all","birth_year":"all","current_address":"all","permanent_address":"all","social_profile_links":"all","find_me_nearby":"all"}}

class UpdatePrivacySettingsModel {
  UpdatePrivacySettingsModel({
    String? message,
    Data? data,
  }) {
    _message = message;
    _data = data;
  }

  UpdatePrivacySettingsModel.fromJson(dynamic json) {
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

/// display_settings : {"phone":"my_connections","email":"all","user_image":"all","birth_day_month":"all","birth_year":"all","current_address":"all","permanent_address":"all","social_profile_links":"all","find_me_nearby":"all"}

class Data {
  Data({
    DisplaySettings? displaySettings,
  }) {
    _displaySettings = displaySettings;
  }

  Data.fromJson(dynamic json) {
    _displaySettings = json['display_settings'] != null
        ? DisplaySettings.fromJson(json['display_settings'])
        : null;
  }

  DisplaySettings? _displaySettings;

  DisplaySettings? get displaySettings => _displaySettings;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_displaySettings != null) {
      map['display_settings'] = _displaySettings?.toJson();
    }
    return map;
  }
}

/// phone : "my_connections"
/// email : "all"
/// user_image : "all"
/// birth_day_month : "all"
/// birth_year : "all"
/// current_address : "all"
/// permanent_address : "all"
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
