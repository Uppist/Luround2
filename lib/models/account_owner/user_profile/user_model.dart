
class UserModel {
  UserModel({
    required this.id,
    required this.email,
    required this.displayName,
    required this.photoUrl,
    required this.accountCreatedFrom,
    required this.occupation,
    required this.about,
    required this.phone_number,
    required this.luround_url,
    required this.company,
    required this.certificates,
    required this.media_links,
    required this.logo_url
  });
  late final String id;
  late final String email;
  late final String displayName;
  late final String photoUrl;
  late final String accountCreatedFrom;
  late final String occupation;
  late final String about;
  late final String phone_number;
  late final String address;
  late final String luround_url;
  late final String company;
  late final String logo_url;
  late final String account_status;
  late final List<dynamic> certificates;
  late final List<dynamic> media_links;
  late final Map<String, dynamic> payment_details;
  
  UserModel.fromJson(Map<String, dynamic> json,){
    id = json['_id'] ?? "id";
    email = json['email'] ?? "email";
    displayName = json['displayName'] ?? "disp";
    photoUrl = json['photoUrl'] ?? "my_photo";
    accountCreatedFrom = json['accountCreatedFrom'];
    occupation = json['occupation'] ?? "occ";
    about = json['about'] ?? "about";
    phone_number = json['phone_number'] ?? "phone_number";
    address = json['address'] ?? "address";
    luround_url = json["luround_url"] ?? "url";
    logo_url = json["logo_url"] ?? "logo_url";
    account_status = json["account_status"] ?? "account_status";
    company = json["company"] ?? "company";
    certificates = json['certificates'] ?? [];
    media_links = json['media_links'] ?? [];
    payment_details = json['payment_details'] ?? {}; //expiry_date and // start_date
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
    _data['phone_number'] = phone_number;
    _data['address'] = address;
    _data["luround_url"] = luround_url;
    _data["logo_url"] = logo_url;
    _data['account_status'] = account_status;
    _data["company"] = company;
    _data['certificates'] = certificates;
    _data['media_links'] = media_links;
    _data['payment_details'] = payment_details;
    return _data;
  }
}
