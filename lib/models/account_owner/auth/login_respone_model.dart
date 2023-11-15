
class LoginResponse {
  LoginResponse({
    required this.accessToken
  });
  late final String accessToken;

  
  LoginResponse.fromJson(Map<String, dynamic> json){
    accessToken = json['accessToken'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['accessToken'] = accessToken;
    return _data;
  }
}
