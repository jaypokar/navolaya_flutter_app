/// message : "Profile information updated successfully"
/// data : {"house":"Aravali","birth_date":"1993-10-06T00:00:00.000Z","about_me":"It is a long established fact that a reader will be distracted by the readable content","user_image":"https://navolaya-app.s3.amazonaws.com/1656498383628profileuser.jpg"}

class UpdateAdditionalInfoModel {
  UpdateAdditionalInfoModel({
    String? message,
    Data? data,
  }) {
    _message = message;
    _data = data;
  }

  UpdateAdditionalInfoModel.fromJson(dynamic json) {
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

/// house : "Aravali"
/// birth_date : "1993-10-06T00:00:00.000Z"
/// about_me : "It is a long established fact that a reader will be distracted by the readable content"
/// user_image : "https://navolaya-app.s3.amazonaws.com/1656498383628profileuser.jpg"

class Data {
  Data({
    String? house,
    String? birthDate,
    String? aboutMe,
    String? userImage,
  }) {
    _house = house;
    _birthDate = birthDate;
    _aboutMe = aboutMe;
    _userImage = userImage;
  }

  Data.fromJson(dynamic json) {
    _house = json['house'];
    _birthDate = json['birth_date'];
    _aboutMe = json['about_me'];
    _userImage = json['user_image'];
  }

  String? _house;
  String? _birthDate;
  String? _aboutMe;
  String? _userImage;

  String? get house => _house;

  String? get birthDate => _birthDate;

  String? get aboutMe => _aboutMe;

  String? get userImage => _userImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['house'] = _house;
    map['birth_date'] = _birthDate;
    map['about_me'] = _aboutMe;
    map['user_image'] = _userImage;
    return map;
  }
}
