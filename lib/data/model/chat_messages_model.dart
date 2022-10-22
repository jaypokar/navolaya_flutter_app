/// message : "SUCCESS"
/// data : {"docs":[{"_id":"62b70d5b4459283690919d2f","message_text":"Hi there!","message_time":"2022-06-25T13:27:55.286Z","direction":"right"}],"totalDocs":2,"limit":50,"page":1,"totalPages":1,"pagingCounter":1,"hasPrevPage":false,"hasNextPage":false,"prevPage":null,"nextPage":null}

class ChatMessagesModel {
  ChatMessagesModel({
    String? message,
    Data? data,
  }) {
    _message = message;
    _data = data;
  }

  ChatMessagesModel.fromJson(dynamic json) {
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

/// docs : [{"_id":"62b70d5b4459283690919d2f","message_text":"Hi there!","message_time":"2022-06-25T13:27:55.286Z","direction":"right"}]
/// totalDocs : 2
/// limit : 50
/// page : 1
/// totalPages : 1
/// pagingCounter : 1
/// hasPrevPage : false
/// hasNextPage : false
/// prevPage : null
/// nextPage : null

class Data {
  Data({
    List<ChatMessages>? docs,
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
    _chatMessages = docs;
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
      _chatMessages = [];
      json['docs'].forEach((v) {
        _chatMessages?.add(ChatMessages.fromJson(v));
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

  List<ChatMessages>? _chatMessages;
  int? _totalDocs;
  int? _limit;
  int? _page;
  int? _totalPages;
  int? _pagingCounter;
  bool? _hasPrevPage;
  bool? _hasNextPage;
  dynamic _prevPage;
  dynamic _nextPage;

  List<ChatMessages>? get docs => _chatMessages;

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
    if (_chatMessages != null) {
      map['docs'] = _chatMessages?.map((v) => v.toJson()).toList();
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

/// _id : "62b70d5b4459283690919d2f"
/// message_text : "Hi there!"
/// message_time : "2022-06-25T13:27:55.286Z"
/// direction : "right"

class ChatMessages {
  ChatMessages({
    String? id,
    String? messageText,
    String? messageTime,
    String? direction,
  }) {
    _id = id;
    _messageText = messageText;
    _messageTime = messageTime;
    _direction = direction;
  }

  ChatMessages.fromJson(dynamic json) {
    _id = '';
    if (json['_id'] != null) {
      _id = json['_id'];
    }
    _messageText = json['message_text'];
    _messageTime = json['message_time'];
    _direction = json['direction'];
  }

  String? _id;
  String? _messageText;
  String? _messageTime;
  String? _direction;

  String? get id => _id;

  String? get messageText => _messageText;

  String? get messageTime => _messageTime;

  String? get direction => _direction;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['message_text'] = _messageText;
    map['message_time'] = _messageTime;
    map['direction'] = _direction;
    return map;
  }
}
