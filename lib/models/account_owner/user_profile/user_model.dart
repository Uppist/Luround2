
class UserModel {
  UserModel({
    required this.id,
    required this.email,
    required this.displayName,
    required this.photoUrl,
    required this.accountCreatedFrom,
    required this.occupation,
    required this.about,
    required this.luround_url,
    required this.certificates,
    required this.media_links,
  });
  late final String id;
  late final String email;
  late final String displayName;
  late final String photoUrl;
  late final String accountCreatedFrom;
  late final String occupation;
  late final String about;
  late final String luround_url;
  late final List<dynamic> certificates;
  late final List<dynamic> media_links;
  
  UserModel.fromJson(Map<String, dynamic> json,){
    id = json['_id'];
    email = json['email'];
    displayName = json['displayName'];
    photoUrl = json['photoUrl'] ?? "photo";
    accountCreatedFrom = json['accountCreatedFrom'];
    occupation = json['occupation'];
    about = json['about'];
    luround_url = json["luround_url"] ?? "url";
    certificates = json['certificates'];
    media_links = json['media_links'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = id;
    _data['email'] = email;
    _data['displayName'] = displayName;
    _data['photoUrl'] = photoUrl;
    _data['accountCreatedFrom'] = accountCreatedFrom;
    _data['occupation'] = occupation;
    _data['about'] = about;
    _data["luround_url"] = luround_url;
    _data['certificates'] = certificates;
    _data['media_links'] = media_links;
    return _data;
  }
}
