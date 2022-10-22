/// message : "SUCCESS"
/// data : {"is_viewed":1}

class UpdateUserViewedModel {
  UpdateUserViewedModel({
    String? message,
    Data? data,
  }) {
    _message = message;
    _data = data;
  }

  UpdateUserViewedModel.fromJson(dynamic json) {
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

/// is_viewed : 1

class Data {
  Data({
    int? isViewed,
  }) {
    _isViewed = isViewed;
  }

  Data.fromJson(dynamic json) {
    _isViewed = json['is_viewed'];
  }

  int? _isViewed;

  int? get isViewed => _isViewed;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['is_viewed'] = _isViewed;
    return map;
  }
}
