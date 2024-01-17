
class InvoiceResponse{
  final String invoice_id;
  final String service_provider_name;
  final String service_provider_email;
  final String service_provider_userId;
  final String send_to_name;
  final String send_to_email;
  final String phone_number;
  final String due_date;
  final num sub_total;
  final num discount;
  final String vat;
  final num total;
  final String note;
  final String status;
  final List<dynamic> booking_detail;
  
  InvoiceResponse({
    required this.service_provider_name,
    required this.service_provider_email,
    required this.service_provider_userId,
    required this.invoice_id,
    required this.send_to_name, 
    required this.send_to_email, 
    required this.phone_number, 
    required this.due_date,  
    required this.sub_total, 
    required this.discount, 
    required this.vat, 
    required this.total,  
    required this.note,  
    required this.status,
    required this.booking_detail,  
  });

  factory InvoiceResponse.fromJson(Map<String, dynamic> json) {
    return InvoiceResponse( 
      service_provider_name: json['service_provider_name'] ?? "nan",
      service_provider_email: json['service_provider_email'] ?? "nan",
      service_provider_userId: json['service_provider_userId'] ?? "nan",
      status: json['status'] ?? "nan",
      invoice_id: json['_id'],
      send_to_name: json['send_to_name'] ?? "nan",
      send_to_email: json['send_to_email'] ?? "nan",
      phone_number: json['phone_number'] ?? "nan",
      due_date: json['due_date'] ?? "nan",
      sub_total: json['sub_total'] ?? 0,
      discount: json['discount'] ?? 0,
      vat: json['vat'] ?? "nan",
      total: json['total'] ?? 0,
      note: json['note'] ?? "nan", 
      booking_detail: json['booking_detail'] ?? [],
    );
  }
}













