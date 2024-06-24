class WalletBalance{
  WalletBalance({
    required this.wallet_balance,
    required this.has_wallet_pin,
  });
  late final num wallet_balance;
  late final bool has_wallet_pin;
  
  WalletBalance.fromJson(Map<String, dynamic> json,){
    wallet_balance = json['wallet_balance'] ?? 0.0;
    has_wallet_pin = json['has_wallet_pin'] ?? false;
  }
}