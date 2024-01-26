



class ReceivedQuotesResponse{
  final String quote_id;
  final String send_to_name;
  final String send_to_email;
  final String phone_number;
  final String due_date;
  final String quote_date;
  final String sub_total;
  final String discount;
  final String vat;
  final String total;
  final String appointment_type;
  final String status;
  final String note;
  final String service_name;
  final String offer;
  final String uploaded_file;
  final Map<String, dynamic> service_provider;
  final List<dynamic> product_details;
  final int tracking_id;
  final int created_at;
  
  ReceivedQuotesResponse({
    required this.send_to_name, 
    required this.send_to_email, 
    required this.phone_number, 
    required this.due_date, 
    required this.quote_date, 
    required this.sub_total, 
    required this.discount, 
    required this.vat, 
    required this.total, 
    required this.appointment_type, 
    required this.status, 
    required this.note, 
    required this.service_provider,  
    required this.product_details,
    required this.quote_id,
    required this.offer,
    required this.service_name,
    required this.uploaded_file,
    required this.tracking_id, 
    required this.created_at, 
    
  });

  factory ReceivedQuotesResponse.fromJson(Map<String, dynamic> json) {
    return ReceivedQuotesResponse(
      tracking_id: json['quote_id'] ?? 0, 
      created_at: json['created_at'] ?? 0,
      quote_id: json['_id'] ?? "nan", 
      send_to_name: json['full_name'] ?? "nan",
      send_to_email: json['user_email'] ?? "nan",
      phone_number: json['phone_number'] ?? "nan",
      due_date: json['due_date'] ?? "nan",
      quote_date: json['quote_date'] ?? "nan",
      sub_total: json['sub_total'] ?? "nan",
      discount: json['discount'] ?? "nan",
      vat: json['vat'] ?? "nan",
      total: json['total'] ?? "nan",
      appointment_type: json['appointment_type'] ?? "nan",
      status: json['status'] ?? "nan",
      note: json['note'] ?? "nan",
      service_provider: json['quote_to'] ?? {},
      product_details: json['product_details'] ?? [],
      service_name: json['service_name'] ?? 'nan',
      offer: json['budget'] ?? 'nan',
      uploaded_file: json['file'] ?? "nan"
    );
  }
}