class SocialMediaLinksRequestModel {
  final String instagram;
  final String twitter;
  final String facebook;
  final String linkedIn;
  final String youTube;

  SocialMediaLinksRequestModel(
      {required this.instagram,
      required this.twitter,
      required this.facebook,
      required this.linkedIn,
      required this.youTube});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};
    map['facebook'] = facebook;
    map['instagram'] = instagram;
    map['linkedin'] = linkedIn;
    map['twitter'] = twitter;
    map['youtube'] = youTube;
    return map;
  }
}
