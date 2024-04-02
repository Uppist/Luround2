

class BillingHistoryResponse{

  final String date;
  final String plan;
  final int amount;
  
  BillingHistoryResponse({
    required this.date,
    required this.plan, 
    required this.amount, 
  });

  factory BillingHistoryResponse.fromJson(Map<String, dynamic> json) {
    return BillingHistoryResponse( 
      date: json['date'] ?? 'date',
      plan: json['plan'] ?? 'plan',
      amount: json['amount'] ?? 0, //"amount",
    );
  }
}