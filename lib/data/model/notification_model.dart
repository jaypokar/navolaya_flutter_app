/// message : "SUCCESS"
/// data : {"docs":[{"_id":"62dd75eef2cc357ce7e357be","message":"Chandan Chhajer has sent you a connection request.","is_read":0,"createdAt":"2022-07-24T16:40:14.018Z"}],"totalDocs":1,"limit":10,"page":1,"totalPages":1,"pagingCounter":1,"hasPrevPage":false,"hasNextPage":false,"prevPage":null,"nextPage":null}

class NotificationModel {
  NotificationModel({
    String? message,
    Data? data,
  }) {
    _message = message;
    _data = data;
  }

  NotificationModel.fromJson(dynamic json) {
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

/// docs : [{"_id":"62dd75eef2cc357ce7e357be","message":"Chandan Chhajer has sent you a connection request.","is_read":0,"createdAt":"2022-07-24T16:40:14.018Z"}]
/// totalDocs : 1
/// limit : 10
/// page : 1
/// totalPages : 1
/// pagingCounter : 1
/// hasPrevPage : false
/// hasNextPage : false
/// prevPage : null
/// nextPage : null

class Data {
  Data({
    List<NotificationDataModel>? docs,
    int? totalDocs,
    int? limit,
    int? page,
    int? totalPages,
    int? pagingCounter,
    bool? hasPrevPage,
    bool? hasNextPage,
    dynamic prevPage,
    dynamic nextPage,
  }) {
    _docs = docs;
    _totalDocs = totalDocs;
    _limit = limit;
    _page = page;
    _totalPages = totalPages;
    _pagingCounter = pagingCounter;
    _hasPrevPage = hasPrevPage;
    _hasNextPage = hasNextPage;
    _prevPage = prevPage;
    _nextPage = nextPage;
  }

  Data.fromJson(dynamic json) {
    if (json['docs'] != null) {
      _docs = [];
      json['docs'].forEach((v) {
        _docs?.add(NotificationDataModel.fromJson(v));
      });
    }
    _totalDocs = json['totalDocs'];
    _limit = json['limit'];
    _page = json['page'];
    _totalPages = json['totalPages'];
    _pagingCounter = json['pagingCounter'];
    _hasPrevPage = json['hasPrevPage'];
    _hasNextPage = json['hasNextPage'];
    _prevPage = json['prevPage'];
    _nextPage = json['nextPage'];
  }

  List<NotificationDataModel>? _docs;
  int? _totalDocs;
  int? _limit;
  int? _page;
  int? _totalPages;
  int? _pagingCounter;
  bool? _hasPrevPage;
  bool? _hasNextPage;
  dynamic _prevPage;
  dynamic _nextPage;

  List<NotificationDataModel>? get docs => _docs;

  int? get totalDocs => _totalDocs;

  int? get limit => _limit;

  int? get page => _page;

  int? get totalPages => _totalPages;

  int? get pagingCounter => _pagingCounter;

  bool? get hasPrevPage => _hasPrevPage;

  bool? get hasNextPage => _hasNextPage;

  dynamic get prevPage => _prevPage;

  dynamic get nextPage => _nextPage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_docs != null) {
      map['docs'] = _docs?.map((v) => v.toJson()).toList();
    }
    map['totalDocs'] = _totalDocs;
    map['limit'] = _limit;
    map['page'] = _page;
    map['totalPages'] = _totalPages;
    map['pagingCounter'] = _pagingCounter;
    map['hasPrevPage'] = _hasPrevPage;
    map['hasNextPage'] = _hasNextPage;
    map['prevPage'] = _prevPage;
    map['nextPage'] = _nextPage;
    return map;
  }
}

/// _id : "62dd75eef2cc357ce7e357be"
/// message : "Chandan Chhajer has sent you a connection request."
/// is_read : 0
/// createdAt : "2022-07-24T16:40:14.018Z"

class NotificationDataModel {
  NotificationDataModel({
    String? id,
    String? title,
    String? message,
    int? isRead,
    String? createdAt,
  }) {
    _id = id;
    _title = message;
    _message = message;
    _isRead = isRead;
    _createdAt = createdAt;
  }

  NotificationDataModel.fromJson(dynamic json) {
    _id = json['_id'];
    _title = json['title'];
    _message = json['message'];
    _isRead = json['is_read'];
    _createdAt = json['createdAt'];
  }

  String? _id;
  String? _title;
  String? _message;
  int? _isRead;
  String? _createdAt;

  String? get id => _id;

  String? get title => _title;

  String? get message => _message;

  int? get isRead => _isRead;

  String? get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['title'] = _title;
    map['message'] = _message;
    map['is_read'] = _isRead;
    map['createdAt'] = _createdAt;
    return map;
  }
}
