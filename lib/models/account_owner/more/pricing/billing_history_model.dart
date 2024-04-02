

class BillingHistoryResponse{

  final String date;
  final String plan;
  final String amount;
  
  BillingHistoryResponse({
    required this.date,
    required this.plan, 
    required this.amount, 
  });

  factory BillingHistoryResponse.fromJson(Map<String, dynamic> json) {
    return BillingHistoryResponse( 
      date: json['payment_date'] ?? "iso8601String",
      plan: json['plan'] ?? "plan",
      amount: json['amount'] ?? "amount",
    );
  }
}