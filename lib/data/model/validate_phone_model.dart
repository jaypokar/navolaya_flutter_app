/// message : "OTP has sent to your phone number"
/// data : {"country_code":"+91","phone":"9983730875","is_user_account_verified":0}

class ValidatePhoneModel {
  ValidatePhoneModel({
    String? message,
    Data? data,
  }) {
    _message = message;
    _data = data;
  }

  ValidatePhoneModel.fromJson(dynamic json) {
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

/// country_code : "+91"
/// phone : "9983730875"
/// is_user_account_verified : 0

class Data {
  Data({
    String? countryCode,
    String? phone,
    int? isUserAccountVerified,
  }) {
    _countryCode = countryCode;
    _phone = phone;
    _isUserAccountVerified = isUserAccountVerified;
  }

  Data.fromJson(dynamic json) {
    _countryCode = json['country_code'];
    _phone = json['phone'];
    _isUserAccountVerified = json['is_user_account_verified'];
  }

  String? _countryCode;
  String? _phone;
  int? _isUserAccountVerified;

  String? get countryCode => _countryCode;

  String? get phone => _phone;

  int? get isUserAccountVerified => _isUserAccountVerified;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['country_code'] = _countryCode;
    map['phone'] = _phone;
    map['is_user_account_verified'] = _isUserAccountVerified;
    return map;
  }
}
