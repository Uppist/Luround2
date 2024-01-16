

class ContactResponse{
  ContactResponse({
    required this.client_email,
    required this.client_name,
    required this.client_phone_number
  });
  late final String client_name;
  late final String client_email;
  late final String client_phone_number;
  
  factory ContactResponse.fromJson(Map<String, dynamic> json){
    return ContactResponse(
      client_name: json['name'],
      client_email: json['email'],
      client_phone_number: json['phone_number']
    );
  }

}