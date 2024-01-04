
class UserServiceModel {
  UserServiceModel({
    required this.serviceId,
    required this.email,
    required this.service_name,
    required this.description,
    required this.links,
    required this.service_charge_in_person,
    required this.service_charge_virtual,
    required this.duration,
    required this.time,
    required this.available_days,
    required this.service_provider_details,
    required this.date,
    required this.service_link,
    required this.available_time,
  });
  late final String serviceId;
  late final String email;
  late final String service_name;
  late final String description;
  late final List<dynamic> links;
  late final List<dynamic> available_time;
  late final String service_charge_in_person;
  late final String service_charge_virtual;
  late final String duration;
  late final String time;
  late final String available_days;
  late final Map<String, dynamic> service_provider_details;
  late final String date;
  late final String service_link;

  //[FOR GET REQUEST]
  UserServiceModel.fromJson(Map<String, dynamic> json,){
    serviceId = json['_id'] ?? "_id";
    email = json['email'] ?? "email";
    service_name = json['service_name'] ?? "service_name";
    description = json['description'] ?? "service_description";
    links = json['links'] ?? ["link1"];
    available_time = json['available_time'] ?? ["time"];
    service_charge_in_person = json['service_charge_in_person'] ?? "service_charge_in_person";
    service_charge_virtual = json['service_charge_virtual'] ?? "service_charge_virtual";
    duration = json['duration'] ?? "duration";
    time = json['time'] ?? "time";
    available_days = json['available_days'] ?? "available_days";
    service_provider_details = json['service_provider_details'] ?? {};
    date = json['date'] ?? "already covered by available days";
    service_link = json['service_link'] ?? "auto_generated_service_link";
  }
  
  
}



