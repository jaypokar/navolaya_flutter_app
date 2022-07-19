/// message : "OTP has sent to your phone number"
/// data : {}

class UpdateSendOtpModel {
  UpdateSendOtpModel({
    String? message,
    dynamic data,
  }) {
    _message = message;
    _data = data;
  }

  UpdateSendOtpModel.fromJson(dynamic json) {
    _message = json['message'];
    _data = json['data'];
  }

  String? _message;
  dynamic _data;

  String? get message => _message;

  dynamic get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = _message;
    map['data'] = _data;
    return map;
  }
}
