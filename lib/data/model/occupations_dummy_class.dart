/// occupations : [{"Accounting, Banking & Finance":[{"id":"Banking Professional","title":"Banking Professional"},{"id":"Chartered Accountant","title":"Chartered Accountant"},{"id":"Company Secretary","title":"Company Secretary"},{"id":"Finance Professional","title":"Finance Professional"},{"id":"Investment Professional","title":"Investment Professional"},{"id":"Accounting Professional (Others)","title":"Accounting Professional (Others)"}]},{"Administration & HR":[{"id":"Admin Professional","title":"Admin Professional"},{"id":"Human Resources Professional","title":"Human Resources Professional"}]},{"Advertising, Media & Entertainment":[{"id":"Actor","title":"Actor"},{"id":"Advertising Professional","title":"Advertising Professional"},{"id":"Entertainment Professional","title":"Entertainment Professional"},{"id":"Event Manager","title":"Event Manager"},{"id":"Journalist","title":"Journalist"},{"id":"Media Professional","title":"Media Professional"},{"id":"Public Relations Professional","title":"Public Relations Professional"}]},{"Agriculture":[{"id":"Farming","title":"Farming"},{"id":"Horticulturist","title":"Horticulturist"},{"id":"Agricultural Professional (Others)","title":"Agricultural Professional (Others)"}]},{"Airline & Aviation":[{"id":"Air Hostess / Flight Attendant","title":"Air Hostess / Flight Attendant"},{"id":"Pilot / Co-Pilot","title":"Pilot / Co-Pilot"},{"id":"Other Airline Professional","title":"Other Airline Professional"}]},{"Architecture & Design":[{"id":"Architect","title":"Architect"},{"id":"Interior Designer","title":"Interior Designer"},{"id":"Landscape Architect","title":"Landscape Architect"}]},{"Artists, Animators & Web Designers":[{"id":"Animator","title":"Animator"},{"id":"Commercial Artist","title":"Commercial Artist"},{"id":"Web / UX Designers","title":"Web / UX Designers"},{"id":"Artist (Others)","title":"Artist (Others)"}]},{"Beauty, Fashion & Jewellery Designers":[{"id":"Beautician","title":"Beautician"},{"id":"Fashion Designer","title":"Fashion Designer"},{"id":"Hairstylist","title":"Hairstylist"},{"id":"Jewellery Designer","title":"Jewellery Designer"},{"id":"Designer (Others)","title":"Designer (Others)"}]},{"BPO, KPO, & Customer Support":[{"id":"Customer Support / BPO / KPO Professional","title":"Customer Support / BPO / KPO Professional"}]},{"Civil Services / Law Enforcement":[{"id":"IAS / IRS / IES / IFS","title":"IAS / IRS / IES / IFS"},{"id":"Indian Police Services [IPS]","title":"Indian Police Services [IPS]"},{"id":"Law Enforcement Employee (Others)","title":"Law Enforcement Employee (Others)"}]},{"Defense":[{"id":"Airforce","title":"Airforce"},{"id":"Army","title":"Army"},{"id":"Navy","title":"Navy"},{"id":"Defense Services (Others)","title":"Defense Services (Others)"}]},{"Education & Training":[{"id":"Lecturer","title":"Lecturer"},{"id":"Professor","title":"Professor"},{"id":"Research Assistant","title":"Research Assistant"},{"id":"Research Scholar","title":"Research Scholar"},{"id":"Teacher","title":"Teacher"},{"id":"Training Professional (Others)","title":"Training Professional (Others)"}]},{"Engineering":[{"id":"Civil Engineer","title":"Civil Engineer"},{"id":"Electronics / Telecom Engineer","title":"Electronics / Telecom Engineer"},{"id":"Mechanical / Production Engineer","title":"Mechanical / Production Engineer"},{"id":"Non IT Engineer (Others)","title":"Non IT Engineer (Others)"}]},{"Hotel & Hospitality":[{"id":"Chef / Sommelier / Food Critic","title":"Chef / Sommelier / Food Critic"},{"id":"Catering Professional","title":"Catering Professional"},{"id":"Hotel & Hospitality Professional (Others)","title":"Hotel & Hospitality Professional (Others)"}]},{"IT & Software Engineering":[{"id":"Software Developer / Programmer","title":"Software Developer / Programmer"},{"id":"Software Consultant","title":"Software Consultant"},{"id":"Hardware & Networking professional","title":"Hardware & Networking professional"},{"id":"Software Professional (Others)","title":"Software Professional (Others)"}]},{"Legal":[{"id":"Lawyer","title":"Lawyer"},{"id":"Legal Assistant","title":"Legal Assistant"},{"id":"Legal Professional (Others)","title":"Legal Professional (Others)"}]},{"Medical & Healthcare":[{"id":"Dentist","title":"Dentist"},{"id":"Doctor","title":"Doctor"},{"id":"Medical Transcriptionist","title":"Medical Transcriptionist"},{"id":"Nurse","title":"Nurse"},{"id":"Pharmacist","title":"Pharmacist"},{"id":"Physician Assistant","title":"Physician Assistant"},{"id":"Physiotherapist / Occupational Therapist","title":"Physiotherapist / Occupational Therapist"},{"id":"Psychologist","title":"Psychologist"},{"id":"Surgeon","title":"Surgeon"},{"id":"Veterinary Doctor","title":"Veterinary Doctor"},{"id":"Therapist (Others)","title":"Therapist (Others)"},{"id":"Medical / Healthcare Professional (Others)","title":"Medical / Healthcare Professional (Others)"}]},{"Merchant Navy":[{"id":"Merchant Naval Officer","title":"Merchant Naval Officer"},{"id":"Mariner","title":"Mariner"}]},{"Sales & Marketing":[{"id":"Marketing Professional","title":"Marketing Professional"},{"id":"Sales Professional","title":"Sales Professional"}]},{"Science":[{"id":"Biologist / Botanist","title":"Biologist / Botanist"},{"id":"Physicist","title":"Physicist"},{"id":"Science Professional (Others)","title":"Science Professional (Others)"}]},{"Corporate Professionals":[{"id":"CxO / Chairman / Director / President","title":"CxO / Chairman / Director / President"},{"id":"VP / AVP / GM / DGM","title":"VP / AVP / GM / DGM"},{"id":"Sr. Manager / Manager","title":"Sr. Manager / Manager"},{"id":"Consultant / Supervisor / Team Leads","title":"Consultant / Supervisor / Team Leads"},{"id":"Team Member / Staff","title":"Team Member / Staff"}]},{"Others":[{"id":"Agent / Broker / Trader / Contractor","title":"Agent / Broker / Trader / Contractor"},{"id":"Business Owner / Entrepreneur","title":"Business Owner / Entrepreneur"},{"id":"Politician","title":"Politician"},{"id":"Social Worker / Volunteer / NGO","title":"Social Worker / Volunteer / NGO"},{"id":"Sportsman","title":"Sportsman"},{"id":"Travel & Transport Professional","title":"Travel & Transport Professional"},{"id":"Writer","title":"Writer"}]},{"Non Working":[{"id":"Student","title":"Student"},{"id":"Retired","title":"Retired"},{"id":"Not working","title":"Not working"}]}]

class OccupationsDummyClass {
  OccupationsDummyClass({
    List<Occupations>? occupations,
  }) {
    _occupations = occupations;
  }

  OccupationsDummyClass.fromJson(dynamic json) {
    if (json['occupations'] != null) {
      _occupations = [];
      json['occupations'].forEach((v) {
        _occupations?.add(Occupations.fromJson(v));
      });
    }
  }

  List<Occupations>? _occupations;

  List<Occupations>? get occupations => _occupations;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_occupations != null) {
      map['occupations'] = _occupations?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// Accounting, Banking & Finance : [{"id":"Banking Professional","title":"Banking Professional"},{"id":"Chartered Accountant","title":"Chartered Accountant"},{"id":"Company Secretary","title":"Company Secretary"},{"id":"Finance Professional","title":"Finance Professional"},{"id":"Investment Professional","title":"Investment Professional"},{"id":"Accounting Professional (Others)","title":"Accounting Professional (Others)"}]

class Occupations {
  Occupations({
    List<Accountingbankingfinance>? accountingBankingFinance,
  }) {
    _accountingBankingFinance = accountingBankingFinance;
  }

  Occupations.fromJson(dynamic json) {
    if (json['Accounting, Banking & Finance'] != null) {
      _accountingBankingFinance = [];
      json['Accounting, Banking & Finance'].forEach((v) {
        _accountingBankingFinance?.add(Accountingbankingfinance.fromJson(v));
      });
    }
  }

  List<Accountingbankingfinance>? _accountingBankingFinance;

  List<Accountingbankingfinance>? get accountingBankingFinance => _accountingBankingFinance;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_accountingBankingFinance != null) {
      map['Accounting, Banking & Finance'] =
          _accountingBankingFinance?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : "Banking Professional"
/// title : "Banking Professional"

class Accountingbankingfinance {
  Accountingbankingfinance({
    String? id,
    String? title,
  }) {
    _id = id;
    _title = title;
  }

  Accountingbankingfinance.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
  }

  String? _id;
  String? _title;

  String? get id => _id;

  String? get title => _title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    return map;
  }
}
