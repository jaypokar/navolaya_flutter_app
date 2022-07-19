/// message : "New email has been updated successfully"
/// data : {"email":"chandan.chhajer@gmail.com"}

class UpdateEmailModel {
  UpdateEmailModel({
    String? message,
    Data? data,
  }) {
    _message = message;
    _data = data;
  }

  UpdateEmailModel.fromJson(dynamic json) {
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

/// email : "chandan.chhajer@gmail.com"

class Data {
  Data({
    String? email,
  }) {
    _email = email;
  }

  Data.fromJson(dynamic json) {
    _email = json['email'];
  }

  String? _email;

  String? get email => _email;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['email'] = _email;
    return map;
  }
}
