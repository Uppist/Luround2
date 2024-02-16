

class RequestQuoteResponseModel {
  RequestQuoteResponseModel({
    required this.userId,
    required this.user_nToken,
  });
  late final String userId;
  late final String user_nToken;
  
  RequestQuoteResponseModel.fromJson(Map<String, dynamic> json,){
    userId = json['_id'] ?? "id";
    user_nToken = json['user_nToken'] ?? "id";
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['_id'] = userId;
    _data['user_nToken'] = user_nToken;
    return _data;
  }
}