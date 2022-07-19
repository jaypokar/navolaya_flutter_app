/// message : "New phone number has been updated successfully"
/// data : {"country_code":"+91","phone":"9983730875"}

class UpdatePhoneModel {
  UpdatePhoneModel({
    String? message,
    Data? data,
  }) {
    _message = message;
    _data = data;
  }

  UpdatePhoneModel.fromJson(dynamic json) {
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

class Data {
  Data({
    String? countryCode,
    String? phone,
  }) {
    _countryCode = countryCode;
    _phone = phone;
  }

  Data.fromJson(dynamic json) {
    _countryCode = json['country_code'];
    _phone = json['phone'];
  }

  String? _countryCode;
  String? _phone;

  String? get countryCode => _countryCode;

  String? get phone => _phone;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['country_code'] = _countryCode;
    map['phone'] = _phone;
    return map;
  }
}
