
class UserTransactionsModel {
  UserTransactionsModel({
    required this.service_id,
    required this.service_name,
    required this.amount,
    required this.affliate_user,
    required this.transaction_status,
    required this.transaction_ref,
    required this.transaction_date
  });
  late final String service_id;
  late final String service_name;
  late final String amount;
  late final String affliate_user;
  late final String transaction_status;
  late final String transaction_ref;
  late final int transaction_date;

  
  UserTransactionsModel.fromJson(Map<String, dynamic> json,){
    service_id = json['service_id'] ?? "service_id";
    service_name = json['service_name'] ?? "service_name";
    amount = json['amount'] ?? "amount";
    affliate_user = json['affliate_user'] ?? "affliate_user";
    transaction_status = json['transaction_status'] ?? "transaction_status";
    transaction_ref = json['transaction_ref'] ?? "transaction_ref";
    transaction_date = json['transaction_date'] ?? 0;  
  }
}