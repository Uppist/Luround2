


class BankModel {
  BankModel({
    required this.status,
    required this.message,
    required this.data,
  });
  late final bool status;
  late final String message;
  late final List<BankDetails> data;
  
  BankModel.fromJson(Map<String, dynamic> json,){
    status = json['status'] ?? false;
    message = json['message'] ?? "message";
    //data = json['data'] as List<BankDetails>;
    data = (json['data'] as List<dynamic>?)?.map((detailsJson) => BankDetails.fromJson(detailsJson)).toList() ?? [];
  }
}


class BankDetails {
  BankDetails({
    required this.id,
    required this.code,
    required this.name,
  });
  late final int id;
  late final String code;
  late final String name;
  
  BankDetails.fromJson(Map<String, dynamic> json,){
    id = json['id'] ?? 0;
    code = json['code'] ?? "code";
    name = json['name'] ?? 'name';
  }
  
}