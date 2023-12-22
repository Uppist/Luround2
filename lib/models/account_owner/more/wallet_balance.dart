class WalletBalance{
  WalletBalance({
    required this.wallet_balance,
  });
  late final int wallet_balance;
  
  WalletBalance.fromJson(Map<String, dynamic> json,){
    wallet_balance = json['wallet_balance'] ?? 0;
  }
}