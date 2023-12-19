


class BankModel {
  BankModel({
    required this.status,
    required this.message,
    required this.data,
  });
  late final String status;
  late final String message;
  late final List<BankDetails> data;
  
  BankModel.fromJson(Map<String, dynamic> json,){
    status = json['status'] ?? "status";
    message = json['message'] ?? "message";
    data = json['data'] as List<BankDetails>;
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