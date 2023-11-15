
class LoginResponse {
  LoginResponse({
    required this.tokenData
  });
  late final String tokenData;

  
  LoginResponse.fromJson(Map<String, dynamic> json){
    tokenData = json['accessToken'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['accessToken'] = tokenData;
    return _data;
  }
}
