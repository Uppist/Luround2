
class ReceiptResponse{
  final String receipt_id;
  final String service_provider_name;
  final String service_provider_email;
  final String service_provider_userId;
  final String service_provider_phone_number;
  final String service_provider_address;
  final String send_to_name;
  final String send_to_email;
  final String phone_number;
  final String payment_status;
  final String mode_of_payment;
  final String receipt_date;
  final String sub_total;
  final String discount;
  final String vat;
  final String total;
  final String note;
  final List<dynamic> service_detail;
  final int tracking_id;
  final int created_at;
  
  ReceiptResponse({
    required this.receipt_id,
    required this.send_to_name, 
    required this.send_to_email, 
    required this.phone_number, 
    required this.sub_total, 
    required this.discount, 
    required this.vat, 
    required this.total,  
    required this.note,   
    required this.service_provider_name, 
    required this.service_provider_email, 
    required this.service_provider_userId, 
    required this.payment_status, 
    required this.mode_of_payment, 
    required this.receipt_date, 
    required this.service_detail,
    required this.service_provider_phone_number, 
    required this.service_provider_address,
    required this.tracking_id, 
    required this.created_at, 
  });

  factory ReceiptResponse.fromJson(Map<String, dynamic> json) {
    return ReceiptResponse( 
      tracking_id: json['receipt_id'] ?? "nan", 
      created_at: json['created_at'] ?? 0,
      service_provider_userId: json['service_provider_userId'] ?? "nan",
      service_provider_name: json['service_provider_name'] ?? "nan",
      service_provider_email: json['service_provider_email'] ?? "nan",
      service_provider_phone_number: json['service_provider_phone_number'] ?? "nan",
      service_provider_address: json['service_provider_address'] ?? "nan",
      receipt_id: json['_id'] ?? "nan",
      receipt_date: json['receipt_date'] ?? "nan",
      send_to_name: json['send_to_name'] ?? "nan",
      send_to_email: json['send_to_email'] ?? "nan",
      phone_number: json['phone_number'] ?? "nan",
      sub_total: json['sub_total'] ?? "nan",
      discount: json['discount'] ?? "nan",
      vat: json['vat'] ?? "nan",
      total: json['total'] ?? "nan",
      mode_of_payment: json['mode_of_payment'] ?? "nan",
      payment_status: json["payment_status"] ?? 'nan',
      note: json['note'] ?? "nan", 
      service_detail: json['product_detail'] ?? [],
    );
  }
}













