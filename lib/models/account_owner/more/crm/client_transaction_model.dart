

class ClientTrxHistoryResponse{

  final int date;
  final String amount;
  final String email;
  final String service_name;
  
  ClientTrxHistoryResponse({
    required this.date,
    required this.amount, 
    required this.email,
    required this.service_name,
  });

  factory ClientTrxHistoryResponse.fromJson(Map<String, dynamic> json) {
    return ClientTrxHistoryResponse( 
      date: json['date'] ?? 0,
      amount: json['amount'] ?? "amount",
      email: json['email'] ?? "email",
      service_name: json['service_name'] ?? "service_name",
    );
  }
}