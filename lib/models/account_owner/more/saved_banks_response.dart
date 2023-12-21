

class SavedBanks {
  SavedBanks({
    required this.account_name,
    required this.account_number,
    required this.bank_name,
    required this.country,
  });

  late final String account_name;
  late final String account_number;
  late final String bank_name;
  late final String country;

  
  SavedBanks .fromJson(Map<String, dynamic> json,){
    account_name = json['account_name'] ?? "acc_name";
    account_number = json['account_number'] ?? "acc_number";
    bank_name = json['bank_name'] ?? 'bank_name';
    country = json['country'] ?? 'country';
  }
}