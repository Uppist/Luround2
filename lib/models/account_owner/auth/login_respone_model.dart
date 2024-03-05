
class LoginResponse {
  LoginResponse({
    required this.tokenData
  });
  late final String tokenData;
  late final String account_status;

  
  LoginResponse.fromJson(Map<String, dynamic> json){
    tokenData = json['accessToken'];
    account_status = json['account_status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['accessToken'] = tokenData;
    _data['account_status'] = account_status;
    return _data;
  }
}
