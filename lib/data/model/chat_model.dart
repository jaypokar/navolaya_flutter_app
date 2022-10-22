import 'create_chat_model.dart';

/// message : "SUCCESS"
/// data : {"docs":[{"_id":"62b7051f042d40230c6c6dd8","last_message":"Hi there!","last_message_time":"2022-06-25T13:27:55.305Z","chat_status":0,"user":{"_id":"62b5f9dfebd6a019bbbf039b","full_name":"Test User 3","user_image":"https://randomuser.me/api/portraits/men/15.jpg"}}],"totalDocs":1,"limit":50,"page":1,"totalPages":1,"pagingCounter":1,"hasPrevPage":false,"hasNextPage":false,"prevPage":null,"nextPage":null}

class ChatModel {
  ChatModel({
    String? message,
    Data? data,
  }) {
    _message = message;
    _data = data;
  }

  ChatModel.fromJson(dynamic json) {
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

/// docs : [{"_id":"62b7051f042d40230c6c6dd8","last_message":"Hi there!","last_message_time":"2022-06-25T13:27:55.305Z","chat_status":0,"user":{"_id":"62b5f9dfebd6a019bbbf039b","full_name":"Test User 3","user_image":"https://randomuser.me/api/portraits/men/15.jpg"}}]
/// totalDocs : 1
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
    List<Chat>? docs,
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
        _docs?.add(Chat.fromJson(v));
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

  List<Chat>? _docs;
  int? _totalDocs;
  int? _limit;
  int? _page;
  int? _totalPages;
  int? _pagingCounter;
  bool? _hasPrevPage;
  bool? _hasNextPage;
  dynamic _prevPage;
  dynamic _nextPage;

  List<Chat>? get docs => _docs;

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
      //map['docs'] = _docs?.map((v) => v.toJson()).toList();
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

/// _id : "62b7051f042d40230c6c6dd8"
/// last_message : "Hi there!"
/// last_message_time : "2022-06-25T13:27:55.305Z"
/// chat_status : 0
/// user : {"_id":"62b5f9dfebd6a019bbbf039b","full_name":"Test User 3","user_image":"https://randomuser.me/api/portraits/men/15.jpg"}

class Chat {
  Chat({
    String? id,
    String? lastMessage,
    String? lastMessageTime,
    int? chatStatus,
    User? user,
  }) {
    id = id ?? '';
    lastMessage = lastMessage ?? '';
    lastMessageTime = lastMessageTime ?? '';
    chatStatus = chatStatus ?? 0;
    user = user;
  }

  Chat.fromJson(dynamic json) {
    id = json['_id'];
    lastMessage = json['last_message'];
    lastMessageTime = json['last_message_time'];
    chatStatus = json['chat_status'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  String? id;
  String? lastMessage;
  String? lastMessageTime;
  int? chatStatus;
  User? user;
}

/*
/// _id : "62b5f9dfebd6a019bbbf039b"
/// full_name : "Test User 3"
/// user_image : "https://randomuser.me/api/portraits/men/15.jpg"

class User {
  User({
      String? id, 
      String? fullName, 
      String? userImage,}){
    _id = id;
    _fullName = fullName;
    _userImage = userImage;
}

  User.fromJson(dynamic json) {
    _id = json['_id'];
    _fullName = json['full_name'];
    _userImage = json['user_image'];
  }
  String? _id;
  String? _fullName;
  String? _userImage;

  String? get id => _id;
  String? get fullName => _fullName;
  String? get userImage => _userImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['full_name'] = _fullName;
    map['user_image'] = _userImage;
    return map;
  }

}*/
