/// message : "OTP has sent to your phone number"
/// data : {"country_code":"+91","phone":"9983730875","is_user_account_verified":0}

class VerifyOtpModel {
  VerifyOtpModel({
    String? message,
    Map? data,
  }) {
    _message = message;
    _data = data;
  }

  VerifyOtpModel.fromJson(dynamic json) {
    _message = json['message'];
    _data = {};
  }

  String? _message;
  Map? _data;

  String? get message => _message;

  Map? get data => _data;
}

/// country_code : "+91"
/// phone : "9983730875"
/// is_user_account_verified : 0

class Data {
  const Data();
}
