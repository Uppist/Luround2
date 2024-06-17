



class CreateBankResponse {
  final dynamic bank_details;  
  final String recipient_code;
  CreateBankResponse({
    required this.bank_details,
    required this.recipient_code,
  });

  factory CreateBankResponse.fromJson(Map<String, dynamic> json) {
    return CreateBankResponse(
      bank_details: json["bank_details"] ?? {},
      recipient_code: json["recipient_code"] ?? "recipient_code"
    );
  }
}


/*{
  "authorization_code":null,
  "account_number":"7040571471",
  "account_name":"JAPHET CHUKWUELOKA EBELECHUKWU",
  "bank_code":"999992",
  "bank_name":"OPay Digital Services Limited (OPay)"
},
"recipient_code":"RCP_uaauyubaej5zcxk"*/

