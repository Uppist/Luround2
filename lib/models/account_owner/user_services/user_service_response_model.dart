
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
    //required this.service_type,
    required this.date,
  });
  late final String serviceId;
  late final String email;
  late final String service_name;
  late final String description;
  late final List<dynamic> links;
  late final String service_charge_in_person;
  late final String service_charge_virtual;
  late final String duration;
  late final String time;
  late final String available_days;
  //late final String service_type;
  late final String date;

  //[FOR GET REQUEST]
  UserServiceModel.fromJson(Map<String, dynamic> json,){
    serviceId = json['serviceId'] ?? "serviceId";
    email = json['email'] ?? "email";
    service_name = json['service_name'] ?? "service_name";
    description = json['description'] ?? "service_description";
    links = json['links'] ?? ["null value"];
    service_charge_in_person = json['service_charge_in_person'] ?? "service_charge_in_person";
    service_charge_virtual = json['service_charge_virtual'] ?? "service_charge_virtual";
    duration = json['duration'] ?? "duration";
    time = json['time'] ?? "time";
    available_days = json['available_days'] ?? "available_days";
    //service_type = json['service_type'] ?? "Virtual";
    date = json['date'] ?? "from - to";
  }
  
  //[FOR PUT/POST/DELETE REQUEST]//
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['serviceId'] = serviceId;
    _data['email'] = email;
    _data['service_name'] = service_name;
    _data['description'] = description;
    _data['links'] = links;
    _data['service_charge_in_person'] = service_charge_in_person;
    _data['service_charge_virtual'] = service_charge_virtual;
    _data["duration"] = duration;
    _data['time'] = time;
    _data['available_days'] = available_days;
    //_data["service_type"] = service_type;
    _data["date"] = date;
    return _data;
  }
  
}



class ParentServiceModel {
  ParentServiceModel({
    required this.services
  });
  late final List<UserServiceModel> services;

  //[FOR GET REQUEST]
  ParentServiceModel.fromJson(Map<String, dynamic> json,){
    services = json['services'] ?? "services";
  }
}

