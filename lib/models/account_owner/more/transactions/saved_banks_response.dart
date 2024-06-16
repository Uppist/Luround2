

class SavedBanks {
  SavedBanks({
    required this.account_name,
    required this.account_number,
    required this.bank_name,
    required this.bank_code,
    required this.country,
    required this.receipient_code,
    required this.id
  });

  late final String account_name;
  late final String account_number;
  late final String bank_name;
  late final String bank_code;
  late final String receipient_code;
  late final String country;
  late final String id;

  
  SavedBanks .fromJson(Map<String, dynamic> json,){
    id = json['_id'] ?? '_id';
    account_name = json['account_name'] ?? "acc_name";
    account_number = json['account_number'] ?? "acc_number";
    bank_name = json['bank_name'] ?? 'bank_name';
    bank_code = json['bank_code'] ?? 'bank_code';
    country = json['country'] ?? 'country';
    receipient_code = json['receipient_code'] ?? 'no rc';
  }
}