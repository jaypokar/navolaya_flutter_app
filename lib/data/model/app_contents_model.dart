import 'dart:convert';

/// message : "SUCCESS"
/// data : {"contents":{"about_us":"Sample about us text","privacy_policy":"Sample privacy policy text","terms_conditions":"Sample terms conditions text"},"settings":{"social_media_links":{"facebook":"","instagram":"","youtube":"","linkedin":""},"live_app_links":{"android":"","ios":""},"_id":"62ab8b237bad7f22a9cc8396","official_phone":"test phone","official_email":"test email","official_address":"test address","max_connection_limit":500},"faqs":[{"_id":"62ab8b5a1cf4b92310439080","question":"What is agenda?","answer":"Agenda is this."}]}

AppContentsModel appContentsModelFromJson(String str) =>
    AppContentsModel.fromJson(json.decode(str));

String appContentsModelToJson(AppContentsModel data) => json.encode(data.toJson());

class AppContentsModel {
  AppContentsModel({
    String? message,
    Data? data,
  }) {
    _message = message;
    _data = data;
  }

  AppContentsModel.fromJson(dynamic json) {
    _message = json['message'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  String? _message;
  Data? _data;

  AppContentsModel copyWith({
    String? message,
    Data? data,
  }) =>
      AppContentsModel(
        message: message ?? _message,
        data: data ?? _data,
      );

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

/// contents : {"about_us":"Sample about us text","privacy_policy":"Sample privacy policy text","terms_conditions":"Sample terms conditions text"}
/// settings : {"social_media_links":{"facebook":"","instagram":"","youtube":"","linkedin":""},"live_app_links":{"android":"","ios":""},"_id":"62ab8b237bad7f22a9cc8396","official_phone":"test phone","official_email":"test email","official_address":"test address","max_connection_limit":500}
/// faqs : [{"_id":"62ab8b5a1cf4b92310439080","question":"What is agenda?","answer":"Agenda is this."}]

Data dataFromJson(String str) => Data.fromJson(json.decode(str));

String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  Data({
    Contents? contents,
    Settings? settings,
    List<Faqs>? faqs,
  }) {
    _contents = contents;
    _settings = settings;
    _faqs = faqs;
  }

  Data.fromJson(dynamic json) {
    _contents = json['contents'] != null ? Contents.fromJson(json['contents']) : null;
    _settings = json['settings'] != null ? Settings.fromJson(json['settings']) : null;
    if (json['faqs'] != null) {
      _faqs = [];
      json['faqs'].forEach((v) {
        _faqs?.add(Faqs.fromJson(v));
      });
    }
  }

  Contents? _contents;
  Settings? _settings;
  List<Faqs>? _faqs;

  Data copyWith({
    Contents? contents,
    Settings? settings,
    List<Faqs>? faqs,
  }) =>
      Data(
        contents: contents ?? _contents,
        settings: settings ?? _settings,
        faqs: faqs ?? _faqs,
      );

  Contents? get contents => _contents;

  Settings? get settings => _settings;

  List<Faqs>? get faqs => _faqs;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_contents != null) {
      map['contents'] = _contents?.toJson();
    }
    if (_settings != null) {
      map['settings'] = _settings?.toJson();
    }
    if (_faqs != null) {
      map['faqs'] = _faqs?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// _id : "62ab8b5a1cf4b92310439080"
/// question : "What is agenda?"
/// answer : "Agenda is this."

Faqs faqsFromJson(String str) => Faqs.fromJson(json.decode(str));

String faqsToJson(Faqs data) => json.encode(data.toJson());

class Faqs {
  Faqs({
    String? id,
    String? question,
    String? answer,
  }) {
    _id = id;
    _question = question;
    _answer = answer;
  }

  Faqs.fromJson(dynamic json) {
    _id = json['_id'];
    _question = json['question'];
    _answer = json['answer'];
  }

  String? _id;
  String? _question;
  String? _answer;

  Faqs copyWith({
    String? id,
    String? question,
    String? answer,
  }) =>
      Faqs(
        id: id ?? _id,
        question: question ?? _question,
        answer: answer ?? _answer,
      );

  String? get id => _id;

  String? get question => _question;

  String? get answer => _answer;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = _id;
    map['question'] = _question;
    map['answer'] = _answer;
    return map;
  }
}

/// social_media_links : {"facebook":"","instagram":"","youtube":"","linkedin":""}
/// live_app_links : {"android":"","ios":""}
/// _id : "62ab8b237bad7f22a9cc8396"
/// official_phone : "test phone"
/// official_email : "test email"
/// official_address : "test address"
/// max_connection_limit : 500

Settings settingsFromJson(String str) => Settings.fromJson(json.decode(str));

String settingsToJson(Settings data) => json.encode(data.toJson());

class Settings {
  Settings({
    SocialMediaLinks? socialMediaLinks,
    LiveAppLinks? liveAppLinks,
    String? id,
    String? officialPhone,
    String? officialEmail,
    String? officialAddress,
    int? maxConnectionLimit,
  }) {
    _socialMediaLinks = socialMediaLinks;
    _liveAppLinks = liveAppLinks;
    _id = id;
    _officialPhone = officialPhone;
    _officialEmail = officialEmail;
    _officialAddress = officialAddress;
    _maxConnectionLimit = maxConnectionLimit;
  }

  Settings.fromJson(dynamic json) {
    _socialMediaLinks = json['social_media_links'] != null
        ? SocialMediaLinks.fromJson(json['social_media_links'])
        : null;
    _liveAppLinks =
        json['live_app_links'] != null ? LiveAppLinks.fromJson(json['live_app_links']) : null;
    _id = json['_id'];
    _officialPhone = json['official_phone'];
    _officialEmail = json['official_email'];
    _officialAddress = json['official_address'];
    _maxConnectionLimit = json['max_connection_limit'];
  }

  SocialMediaLinks? _socialMediaLinks;
  LiveAppLinks? _liveAppLinks;
  String? _id;
  String? _officialPhone;
  String? _officialEmail;
  String? _officialAddress;
  int? _maxConnectionLimit;

  Settings copyWith({
    SocialMediaLinks? socialMediaLinks,
    LiveAppLinks? liveAppLinks,
    String? id,
    String? officialPhone,
    String? officialEmail,
    String? officialAddress,
    int? maxConnectionLimit,
  }) =>
      Settings(
        socialMediaLinks: socialMediaLinks ?? _socialMediaLinks,
        liveAppLinks: liveAppLinks ?? _liveAppLinks,
        id: id ?? _id,
        officialPhone: officialPhone ?? _officialPhone,
        officialEmail: officialEmail ?? _officialEmail,
        officialAddress: officialAddress ?? _officialAddress,
        maxConnectionLimit: maxConnectionLimit ?? _maxConnectionLimit,
      );

  SocialMediaLinks? get socialMediaLinks => _socialMediaLinks;

  LiveAppLinks? get liveAppLinks => _liveAppLinks;

  String? get id => _id;

  String? get officialPhone => _officialPhone;

  String? get officialEmail => _officialEmail;

  String? get officialAddress => _officialAddress;

  int? get maxConnectionLimit => _maxConnectionLimit;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_socialMediaLinks != null) {
      map['social_media_links'] = _socialMediaLinks?.toJson();
    }
    if (_liveAppLinks != null) {
      map['live_app_links'] = _liveAppLinks?.toJson();
    }
    map['_id'] = _id;
    map['official_phone'] = _officialPhone;
    map['official_email'] = _officialEmail;
    map['official_address'] = _officialAddress;
    map['max_connection_limit'] = _maxConnectionLimit;
    return map;
  }
}

/// android : ""
/// ios : ""

LiveAppLinks liveAppLinksFromJson(String str) => LiveAppLinks.fromJson(json.decode(str));

String liveAppLinksToJson(LiveAppLinks data) => json.encode(data.toJson());

class LiveAppLinks {
  LiveAppLinks({
    String? android,
    String? ios,
  }) {
    _android = android;
    _ios = ios;
  }

  LiveAppLinks.fromJson(dynamic json) {
    _android = json['android'];
    _ios = json['ios'];
  }

  String? _android;
  String? _ios;

  LiveAppLinks copyWith({
    String? android,
    String? ios,
  }) =>
      LiveAppLinks(
        android: android ?? _android,
        ios: ios ?? _ios,
      );

  String? get android => _android;

  String? get ios => _ios;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['android'] = _android;
    map['ios'] = _ios;
    return map;
  }
}

/// facebook : ""
/// instagram : ""
/// youtube : ""
/// linkedin : ""

SocialMediaLinks socialMediaLinksFromJson(String str) =>
    SocialMediaLinks.fromJson(json.decode(str));

String socialMediaLinksToJson(SocialMediaLinks data) => json.encode(data.toJson());

class SocialMediaLinks {
  SocialMediaLinks({
    String? facebook,
    String? instagram,
    String? youtube,
    String? linkedin,
  }) {
    _facebook = facebook;
    _instagram = instagram;
    _youtube = youtube;
    _linkedin = linkedin;
  }

  SocialMediaLinks.fromJson(dynamic json) {
    _facebook = json['facebook'];
    _instagram = json['instagram'];
    _youtube = json['youtube'];
    _linkedin = json['linkedin'];
  }

  String? _facebook;
  String? _instagram;
  String? _youtube;
  String? _linkedin;

  SocialMediaLinks copyWith({
    String? facebook,
    String? instagram,
    String? youtube,
    String? linkedin,
  }) =>
      SocialMediaLinks(
        facebook: facebook ?? _facebook,
        instagram: instagram ?? _instagram,
        youtube: youtube ?? _youtube,
        linkedin: linkedin ?? _linkedin,
      );

  String? get facebook => _facebook;

  String? get instagram => _instagram;

  String? get youtube => _youtube;

  String? get linkedin => _linkedin;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['facebook'] = _facebook;
    map['instagram'] = _instagram;
    map['youtube'] = _youtube;
    map['linkedin'] = _linkedin;
    return map;
  }
}

/// about_us : "Sample about us text"
/// privacy_policy : "Sample privacy policy text"
/// terms_conditions : "Sample terms conditions text"

Contents contentsFromJson(String str) => Contents.fromJson(json.decode(str));

String contentsToJson(Contents data) => json.encode(data.toJson());

class Contents {
  Contents({
    String? aboutUs,
    String? privacyPolicy,
    String? termsConditions,
  }) {
    _aboutUs = aboutUs;
    _privacyPolicy = privacyPolicy;
    _termsConditions = termsConditions;
  }

  Contents.fromJson(dynamic json) {
    _aboutUs = json['about_us'];
    _privacyPolicy = json['privacy_policy'];
    _termsConditions = json['terms_conditions'];
  }

  String? _aboutUs;
  String? _privacyPolicy;
  String? _termsConditions;

  Contents copyWith({
    String? aboutUs,
    String? privacyPolicy,
    String? termsConditions,
  }) =>
      Contents(
        aboutUs: aboutUs ?? _aboutUs,
        privacyPolicy: privacyPolicy ?? _privacyPolicy,
        termsConditions: termsConditions ?? _termsConditions,
      );

  String? get aboutUs => _aboutUs;

  String? get privacyPolicy => _privacyPolicy;

  String? get termsConditions => _termsConditions;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['about_us'] = _aboutUs;
    map['privacy_policy'] = _privacyPolicy;
    map['terms_conditions'] = _termsConditions;
    return map;
  }
}
