

class GoogleSigninResponse{
  GoogleSigninResponse({
    required this.accessToken
  });
  late final String accessToken;
  late final String account_status;

  
  GoogleSigninResponse.fromJson(Map<String, dynamic> json){
    accessToken = json['accessToken'];
    account_status = json['account_status'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['accessToken'] = accessToken;
    _data['account_status'] = account_status;
    return _data;
  }
}
