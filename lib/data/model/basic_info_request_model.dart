
class BasicInfoRequestModel {
  String countryCode;
  String phone;
  String fullName;
  String schoolID;
  String relationWithJNV;
  String fromYear;
  String toYear;
  String qualification;
  String occupation;
  String occupationArea;
  String gender;
  String password;

  BasicInfoRequestModel(
      this.countryCode,
      this.phone,
      this.fullName,
      this.schoolID,
      this.relationWithJNV,
      this.fromYear,
      this.toYear,
      this.qualification,
      this.occupation,
      this.occupationArea,
      this.gender,
      this.password);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map['country_code'] = countryCode;
    map['phone'] = phone;
    map['full_name'] = fullName;
    map['school'] = schoolID;
    map['relation_with_jnv'] = relationWithJNV;
    map['from_year'] = fromYear;
    map['to_year'] = toYear;
    map['qualification'] = qualification;
    map['occupation'] = occupation;
    map['occupation_area'] = occupationArea;
    map['gender'] = gender;
    map['password'] = password;
    return map;
  }
}

class QualificationData {
  final String area;
  final String title;
  final String shortName;

  QualificationData(this.area, this.title, this.shortName);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map['area'] = area;
    map['title'] = title;
    map['shortname'] = shortName;
    return map;
  }
}

class OccupationData {
  final String area;
  final String type;
  final String title;

  OccupationData(this.area, this.type, this.title);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map['area'] = area;
    map['type'] = type;
    map['title'] = title;
    return map;
  }
}
