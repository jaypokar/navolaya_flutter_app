import 'dart:convert';

/// message : "SUCCESS"
/// data : {"jnvRegions":[{"id":"Bhopal","title":"Bhopal"},{"id":"Chandigarh","title":"Chandigarh"},{"id":"Hyderabad","title":"Hyderabad"},{"id":"Jaipur","title":"Jaipur"},{"id":"Lucknow","title":"Lucknow"},{"id":"Patna","title":"Patna"},{"id":"Pune","title":"Pune"},{"id":"Shillong","title":"Shillong"}],"jnvHouses":[{"id":"Aravali","title":"Aravali"},{"id":"Neelgiri","title":"Neelgiri"},{"id":"Shivalik","title":"Shivalik"},{"id":"Udaigiri","title":"Udaigiri"}],"jnvRelations":[{"id":"Student","title":"Student"},{"id":"Alumni","title":"Alumni"},{"id":"Teacher","title":"Teacher"},{"id":"Other Staff","title":"Other Staff"}],"schools":[{"_id":"62879b983a3e730c64e33d7e","state":"Rajasthan","district":"Barmer","city":"Pachpadra"},{"_id":"62bada72bb8fbb481ba25561","state":"Rajasthan","district":"Jodhpur","city":"Tilvasni"},{"_id":"62badab4bb8fbb481ba25575","state":"Panjab","district":"Mohali","city":"Mohali II"}],"occupationAreas":[{"id":"Private Company","title":"Private Company"},{"id":"Government / Public Sector","title":"Government / Public Sector"},{"id":"Defense / Civil Services","title":"Defense / Civil Services"},{"id":"Business / Self Employed","title":"Business / Self Employed"},{"id":"Not Working","title":"Not Working"}]}

MastersModel mastersModelFromJson(String str) => MastersModel.fromJson(json.decode(str));

String mastersModelToJson(MastersModel data) => json.encode(data.toJson());

class MastersModel {
  MastersModel({
    this.message,
    this.data,
  });

  MastersModel.fromJson(dynamic json) {
    message = json['message'];

    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  String? message;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

/// jnvRegions : [{"id":"Bhopal","title":"Bhopal"},{"id":"Chandigarh","title":"Chandigarh"},{"id":"Hyderabad","title":"Hyderabad"},{"id":"Jaipur","title":"Jaipur"},{"id":"Lucknow","title":"Lucknow"},{"id":"Patna","title":"Patna"},{"id":"Pune","title":"Pune"},{"id":"Shillong","title":"Shillong"}]
/// jnvHouses : [{"id":"Aravali","title":"Aravali"},{"id":"Neelgiri","title":"Neelgiri"},{"id":"Shivalik","title":"Shivalik"},{"id":"Udaigiri","title":"Udaigiri"}]
/// jnvRelations : [{"id":"Student","title":"Student"},{"id":"Alumni","title":"Alumni"},{"id":"Teacher","title":"Teacher"},{"id":"Other Staff","title":"Other Staff"}]
/// schools : [{"_id":"62879b983a3e730c64e33d7e","state":"Rajasthan","district":"Barmer","city":"Pachpadra"},{"_id":"62bada72bb8fbb481ba25561","state":"Rajasthan","district":"Jodhpur","city":"Tilvasni"},{"_id":"62badab4bb8fbb481ba25575","state":"Panjab","district":"Mohali","city":"Mohali II"}]
/// occupationAreas : [{"id":"Private Company","title":"Private Company"},{"id":"Government / Public Sector","title":"Government / Public Sector"},{"id":"Defense / Civil Services","title":"Defense / Civil Services"},{"id":"Business / Self Employed","title":"Business / Self Employed"},{"id":"Not Working","title":"Not Working"}]

Data dataFromJson(String str) => Data.fromJson(json.decode(str));

String dataToJson(Data data) => json.encode(data.toJson());

class Data {
  List<JnvRegions>? jnvRegions;
  List<JnvHouses>? jnvHouses;
  List<JnvRelations>? jnvRelations;
  List<Schools>? schools;
  List<OccupationAreas>? occupationAreas;
  List<Occupations>? occupations;
  List<Qualifications>? qualifications;
  List<StateCities>? stateCities;

  Data({
    this.jnvRegions,
    this.jnvHouses,
    this.jnvRelations,
    this.schools,
    this.occupationAreas,
    this.occupations,
    this.qualifications,
    this.stateCities,
  });

  Data.fromJson(dynamic json) {
    if (json['jnvRegions'] != null) {
      jnvRegions = [];
      json['jnvRegions'].forEach((v) {
        jnvRegions?.add(JnvRegions.fromJson(v));
      });
    }

    if (json['jnvHouses'] != null) {
      jnvHouses = [];
      jnvHouses?.add(JnvHouses(id: '', title: 'House (Optional)'));
      json['jnvHouses'].forEach((v) {
        jnvHouses?.add(JnvHouses.fromJson(v));
      });
    }

    if (json['jnvRelations'] != null) {
      jnvRelations = [];
      jnvRelations?.add(JnvRelations(id: '', title: 'Relation with JNV'));
      json['jnvRelations'].forEach((v) {
        jnvRelations?.add(JnvRelations.fromJson(v));
      });
    }

    if (json['schools'] != null) {
      schools = [];
      json['schools'].forEach((v) {
        Map<String, dynamic> keyValues = v as Map<String, dynamic>;
        final key1 = keyValues.keys.toList()[0];
        final key2 = keyValues.keys.toList()[1];
        /* schools?.add(Schools(
            id: '',
            city: keyValues[key1],
            district: keyValues[key1],
            state: keyValues[key1],
            isSeparator: true));*/
        keyValues[key2].forEach((element) {
          schools?.add(Schools.fromJson(element, false));
        });
      });
      /*schools?.add(Schools(
          id: '',
          city: "School",
          district: "School",
          state: "School",
          isSeparator: false));
      json['schools'].forEach((v) {
        Map<String, dynamic> keyValues = v as Map<String, dynamic>;
        final key1 = keyValues.keys.toList()[0];
        final key2 = keyValues.keys.toList()[1];
        schools?.add(Schools(
            id: '',
            city: keyValues[key1],
            district: keyValues[key1],
            state: keyValues[key1],
            isSeparator: true));
        keyValues[key2].forEach((element) {
          schools?.add(Schools.fromJson(element, false));
        });
      });*/
    }

    if (json['occupationAreas'] != null) {
      occupationAreas = [];
      occupationAreas?.add(OccupationAreas(id: '', title: 'Occupation Area'));
      json['occupationAreas'].forEach((v) {
        occupationAreas?.add(OccupationAreas.fromJson(v));
      });
    }

    if (json['occupations'] != null) {
      occupations = [];

      json['occupations'].forEach((v) {
        Map<String, dynamic> keyValues = v as Map<String, dynamic>;
        final key1 = keyValues.keys.toList()[0];
        final key2 = keyValues.keys.toList()[1];
        /*occupations?.add(Occupations(
            isSeparator: true, id: keyValues[key1], title: keyValues[key1], type: keyValues[key1]));*/
        keyValues[key2].forEach((element) {
          occupations?.add(Occupations.fromJson(element, false));
        });
      }); /*occupations?.add(Occupations(
          id: '', type: 'Occupation', title: 'Occupation', isSeparator: false));
      json['occupations'].forEach((v) {
        Map<String, dynamic> keyValues = v as Map<String, dynamic>;
        final key1 = keyValues.keys.toList()[0];
        final key2 = keyValues.keys.toList()[1];
        occupations?.add(Occupations(
            isSeparator: true, id: keyValues[key1], title: keyValues[key1], type: keyValues[key1]));
        keyValues[key2].forEach((element) {
          occupations?.add(Occupations.fromJson(element, false));
        });
      });*/
    }

    if (json['qualifications'] != null) {
      qualifications = [];
      json['qualifications'].forEach((v) {
        Map<String, dynamic> keyValues = v as Map<String, dynamic>;
        final key1 = keyValues.keys.toList()[0];
        final key2 = keyValues.keys.toList()[1];
        keyValues[key2].forEach((element) {
          qualifications?.add(Qualifications.fromJson(element, false));
        });
      });
      /* qualifications?.add(Qualifications(
          id: '',
          area: 'Qualification',
          title: 'Qualification',
          isSeparator: false,
          shortName: 'Qualification'));
      json['qualifications'].forEach((v) {
        Map<String, dynamic> keyValues = v as Map<String, dynamic>;
        final key1 = keyValues.keys.toList()[0];
        final key2 = keyValues.keys.toList()[1];
        qualifications?.add(Qualifications(
            isSeparator: true,
            area: keyValues[key1],
            id: keyValues[key1],
            shortName: keyValues[key1],
            title: keyValues[key1]));
        keyValues[key2].forEach((element) {
          qualifications?.add(Qualifications.fromJson(element, false));
        });
      });*/
    }

    if (json['stateCities'] != null) {
      stateCities = [];
      Map<String, dynamic> mainData = json['stateCities'] as Map<String, dynamic>;
      final listOfData = mainData.values.toList();
      final listOfKeys = mainData.keys.toList();
      for (int i = 0; i < listOfData.length; i++) {
        Map<String, dynamic> values = listOfData[i] as Map<String, dynamic>;
        String mainKey = listOfKeys[i];
        final val =
            StateCities(stateCode: mainKey, name: values['name'], capital: values['capital']);
        val.toString();
        stateCities?.add(val);
      }
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (jnvRegions != null) {
      map['jnvRegions'] = jnvRegions?.map((v) => v.toJson()).toList();
    }
    if (jnvHouses != null) {
      map['jnvHouses'] = jnvHouses?.map((v) => v.toJson()).toList();
    }
    if (jnvRelations != null) {
      map['jnvRelations'] = jnvRelations?.map((v) => v.toJson()).toList();
    }
    if (schools != null) {
      map['schools'] = schools?.map((v) => v.toJson()).toList();
    }
    if (occupationAreas != null) {
      map['occupationAreas'] = occupationAreas?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : "Private Company"
/// title : "Private Company"

OccupationAreas occupationAreasFromJson(String str) => OccupationAreas.fromJson(json.decode(str));

String occupationAreasToJson(OccupationAreas data) => json.encode(data.toJson());

class OccupationAreas {
  OccupationAreas({
    this.id,
    this.title,
  });

  OccupationAreas.fromJson(dynamic json) {
    id = json['_id'];
    title = json['title'];
  }

  String? id;
  String? title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    return map;
  }
}

/// _id : "62879b983a3e730c64e33d7e"
/// state : "Rajasthan"
/// district : "Barmer"
/// city : "Pachpadra"

//Schools schoolsFromJson(String str) => Schools.fromJson(json.decode(str));

String schoolsToJson(Schools data) => json.encode(data.toJson());

class Schools {
  Schools({
    this.id,
    this.state,
    this.district,
    this.city,
    this.isSeparator,
  });

  Schools.fromJson(dynamic json, this.isSeparator) {
    id = json['_id'];
    state = json['state'];
    district = json['district'];
    city = json['city'];
  }

  bool? isSeparator;
  String? id;
  String? state;
  String? district;
  String? city;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['state'] = state;
    map['district'] = district;
    map['city'] = city;
    return map;
  }
}

/// id : "Student"
/// title : "Student"

JnvRelations jnvRelationsFromJson(String str) => JnvRelations.fromJson(json.decode(str));

String jnvRelationsToJson(JnvRelations data) => json.encode(data.toJson());

class JnvRelations {
  JnvRelations({
    this.id,
    this.title,
  });

  JnvRelations.fromJson(dynamic json) {
    id = json['_id'];
    title = json['title'];
  }

  String? id;
  String? title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['title'] = title;
    return map;
  }
}

/// id : "Aravali"
/// title : "Aravali"

JnvHouses jnvHousesFromJson(String str) => JnvHouses.fromJson(json.decode(str));

String jnvHousesToJson(JnvHouses data) => json.encode(data.toJson());

class JnvHouses {
  JnvHouses({
    this.id,
    this.title,
  });

  JnvHouses.fromJson(dynamic json) {
    id = json['_id'];
    title = json['title'];
  }

  String? id;
  String? title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['title'] = title;
    return map;
  }
}

/// id : "Bhopal"
/// title : "Bhopal"

JnvRegions jnvRegionsFromJson(String str) => JnvRegions.fromJson(json.decode(str));

String jnvRegionsToJson(JnvRegions data) => json.encode(data.toJson());

class JnvRegions {
  JnvRegions({
    this.id,
    this.title,
  });

  JnvRegions.fromJson(dynamic json) {
    id = json['_id'];
    title = json['title'];
  }

  String? id;
  String? title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['_id'] = id;
    map['title'] = title;
    return map;
  }
}

///   "Accounting, Banking & Finance": [ { "id": "Banking Professional", "title": "Banking Professional" },]

class Occupations {
  bool? isSeparator;
  String? id;
  String? title;
  String? type;

  Occupations({this.isSeparator, this.id, this.title, this.type});

  Occupations.fromJson(dynamic json, this.isSeparator) {
    id = json['_id'];
    title = json['title'];
    type = json['type'];
  }

  @override
  String toString() {
    return 'Occupations(isSeparator : $isSeparator , id : $id , title : $title)';
  }
}

///   "Engineering": [ { "id": "B.E / B.Tech", "shortname": "B.E / B.Tech", "title":"Bachelor of Engineering / Bachelor of Technology" },]
class Qualifications {
  bool? isSeparator;
  String? id;
  String? area;
  String? shortName;
  String? title;

  Qualifications({this.isSeparator, this.area, this.id, this.shortName, this.title});

  Qualifications.fromJson(dynamic json, this.isSeparator) {
    id = json['_id'];
    title = json['title'];
    shortName = json['shortname'];
    area = json['area'];
  }

  @override
  String toString() {
    return 'Qualifications(isSeparator : $isSeparator , id : $id , shortName : $shortName ,title : $title)';
  }
}

class StateCities {
  String? stateCode;
  String? name;
  String? capital;

  StateCities({this.stateCode, this.name, this.capital});

  @override
  String toString() {
    return 'StateCities(stateCode : $stateCode , name : $name , capital : $capital)';
  }
}
