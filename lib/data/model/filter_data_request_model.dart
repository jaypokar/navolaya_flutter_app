enum FilterType { recent, nearBy, popular }

class FilterDataRequestModel {
  int page;
  String keyword;
  String sortBy;
  double distanceRange;
  double longitude;
  double latitude;
  String toYear;
  String fromYear;
  String gender;
  String state;
  String school;

  FilterDataRequestModel(
      {this.page = 1,
      this.keyword = '',
      this.sortBy = '',
      this.distanceRange = 0.0,
      this.longitude = 0.0,
      this.latitude = 0.0,
      this.toYear = '',
      this.fromYear = '',
      this.gender = '',
      this.state = '',
      this.school = ''});

  FilterDataRequestModel.fromJson(dynamic json,
      {this.page = 1,
      this.keyword = '',
      this.sortBy = '',
      this.distanceRange = 0.0,
      this.longitude = 0.0,
      this.latitude = 0.0,
      this.toYear = '',
      this.fromYear = '',
      this.gender = '',
      this.state = '',
      this.school = ''}) {
    page = json['page'];
    keyword = json['keyword'];
    sortBy = json['sort_by'];
    distanceRange = json['distance_range'];
    longitude = json['longitude'];
    latitude = json['latitude'];
    toYear = json['to_year'];
    fromYear = json['from_year'];
    gender = json['gender'];
    state = json['state'];
    school = json['school'];
  }

  Map<String, dynamic> toJson(FilterType filterType) {
    final Map<String, dynamic> json = {};
    json['page'] = page;
    json['keyword'] = keyword;

    if (filterType == FilterType.recent) {
      json['sort_by'] = 'recent';
    } else if (filterType == FilterType.nearBy) {
      json['sort_by'] = 'nearby';
    } else {
      json['sort_by'] = 'popular';
    }

    json['distance_range'] = distanceRange;
    json['longitude'] = longitude;
    json['latitude'] = latitude;
    json['to_year'] = toYear;
    json['from_year'] = fromYear;
    json['gender'] = gender;
    json['state'] = state;
    json['school'] = school;
    return json;
  }
}
