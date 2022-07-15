class BasicInfoRequestModel {
  String countryCode;
  String phone;
  String fullName;
  String schoolID;
  String relationWithJNV;
  String fromYear;
  String toYear;
  Map<String, dynamic> qualification;
  Map<String, dynamic> occupation;
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
    map['gender'] = gender;
    map['password'] = password;
    return map;
  }
}
