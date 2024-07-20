
class UserTransactionsModel {
  UserTransactionsModel({
    required this.service_id,
    required this.service_name,
    required this.amount,
    required this.affliate_user,
    required this.transaction_status,
    required this.transaction_ref,
    required this.transaction_date,
    required this.transaction_time
  });
  late String service_id;
  late String service_name;
  late dynamic amount;
  late String affliate_user;
  late String transaction_status;
  late String transaction_ref;
  late int transaction_date;
  late String transaction_time;
  
  
  
  UserTransactionsModel.fromJson(Map<String, dynamic> json,){
    service_id = json['service_id'] ?? "service_id";
    service_name = json['service_name'] ?? "service_name";
    amount = json['amount'].toString();
    affliate_user = json['affliate_user'] ?? "you";
    transaction_status = json['transaction_status'] ?? "transaction_status";
    transaction_ref = json['transaction_ref'] ?? "transaction_ref";
    transaction_date = json['transaction_date'] ?? 0;
    transaction_time = json['transaction_time'] ?? "no time";  
  }
}