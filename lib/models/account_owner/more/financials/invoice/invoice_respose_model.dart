
class InvoiceResponse{
  final String invoice_id;
  final Map<String, dynamic> service_provider;
  final String send_to_name;
  final String send_to_email;
  final String phone_number;
  final String payment_link;
  final String due_date;
  final String sub_total;
  final String discount;
  final String vat;
  final String charge;
  final String total;
  final String note;
  final String status;
  final List<dynamic> booking_detail;
  final int tracking_id;
  final int created_at;
  //service provider bank details here
  //final Map<String, dynamic> bank_details;
  final String invoice_generated_from_quote;
  
  
  InvoiceResponse({
    required this.service_provider,
    required this.invoice_id,
    required this.send_to_name, 
    required this.send_to_email, 
    required this.phone_number, 
    required this.payment_link,
    required this.due_date,  
    required this.sub_total, 
    required this.discount, 
    required this.vat, 
    required this.charge,
    required this.total,  
    required this.note,  
    required this.status,
    required this.booking_detail,  
    required this.tracking_id, 
    required this.created_at,
    //
    //required this.bank_details,
    required this.invoice_generated_from_quote
  });

  factory InvoiceResponse.fromJson(Map<String, dynamic> json) {
    return InvoiceResponse( 
      invoice_generated_from_quote: json['invoice_generated_from_quote'] ?? "False",
      tracking_id: json['invoice_id'] ?? 0, 
      created_at: json['created_at'] ?? 0,
      service_provider: json['service_provider'] ?? {},
      status: json['payment_status'] ?? "nan",
      invoice_id: json['_id'],
      send_to_name: json['send_to_name'] ?? "what's happening?",
      send_to_email: json['send_to_email'] ?? "nan",
      phone_number: json['phone_number'] ?? "(empty)",
      payment_link: json['payment_link'] ?? "non",
      due_date: json['due_date'] ?? "nan",
      sub_total: json['sub_total'] ?? "",
      discount: json['discount'] ?? "",
      vat: json['vat'] ?? "nan",
      charge: json['charge'] ?? "nan",
      total: json['total'] ?? "",
      note: json['note'] ?? "nan", 
      booking_detail: json['product_detail'] ?? [],
      //
      //bank_details: json['bank_details'] ?? {},
    );
  }
}















