
class UpdateNameResponse{

  UpdateNameResponse({
    required this.displayName,
  });

  late final String displayName;
  
  UpdateNameResponse.fromJson(Map<String, dynamic> json,){
    displayName = json['displayName'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['displayName'] = displayName;
    return _data;
  }
}
