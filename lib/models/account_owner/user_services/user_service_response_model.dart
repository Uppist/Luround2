
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

    //NEW UPDATES
    required this.service_model,
    required this.service_type,
    required this.service_recurrence,
    required this.max_number_of_participants,

    required this.timeline_days,
    required this.service_timeline,
    required this.start_date,
    required this.end_date,
    required this.start_time,
    required this.end_time,
    //required this.appointment,
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
  //late final String appointment;  //virtual or in-person

  //NEW ITEMS FOR THE 3 TYPES OF SERVICES
  late final String service_model; //One-Off or Retainer
  late final String service_type;
  late final String service_recurrence;
  late final int max_number_of_participants;

  late final List<dynamic> timeline_days;
  late final String service_timeline;
  late final String start_date;
  late final String end_date;
  late final String start_time;
  late final String end_time;



  //[FOR GET REQUEST]
  UserServiceModel.fromJson(Map<String, dynamic> json,){
    serviceId = json['_id'] ?? "_id";
    email = json['email'] ?? "email";
    service_name = json['service_name'] ?? "service_name";
    description = json['description'] ?? "service_description";
    links = json['links'] ?? [];
    available_time = json['available_time'] ?? ["time"];
    service_charge_in_person = json['service_charge_in_person'] ?? "0";
    service_charge_virtual = json['service_charge_virtual'] ?? "0";
    duration = json['duration'] ?? "duration";
    time = json['time'] ?? "time";
    available_days = json['available_days'] ?? "available_days";
    service_provider_details = json['service_provider_details'] ?? {};
    date = json['date'] ?? "already covered by available days";
    service_link = json['service_link'] ?? "auto_generated_service_link";
    //appointment = json['appointment'] ?? "appointment";

    
    service_model = json['service_model'] ?? "service_model";
    service_type = json['service_type'] ?? "service_type";
    service_recurrence = json['service_recurrence'] ?? "service_recurrence";
    max_number_of_participants = json['max_number_of_participants'] ?? 0;
    
    //what i will show somto
    timeline_days = json['timeline_days'] ?? [];
    service_timeline = json['service_timeline'] ?? "service_timeline";
    start_date = json['start_date'] ?? "start_date";
    end_date = json['service_type'] ?? "end_date";
    start_time = json['start_time'] ?? "start_time";
    end_time = json['end_time'] ?? "end_time";


  }
  
  //to Map
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['service_id'] = serviceId;
    _data['email'] = email;
    _data['service_name'] = service_name;
    _data['description'] = description;
    _data['links'] = links;
    _data['available_time'] = available_time;
    _data["rate"] = service_charge_virtual;
    _data["total"] = service_charge_virtual;
    //_data["appointment"] = appointment;
    _data["duration"] = duration;
    _data['time'] = time;
    _data['available_days'] = available_days;
    _data['service_provider_details'] = service_provider_details;
    _data['service_link'] = service_link;

    //NEW UPDATE
    _data['service_model'] = service_model;
    _data['service_type'] = service_type;
    _data['service_recurrence'] = service_recurrence;
    _data['max_number_of_participants'] = max_number_of_participants;

    //what i will show somto
    _data['timeline_days'] = timeline_days;
    _data['service_timeline'] = service_timeline;
    _data['start_date'] = start_date;
    _data['end_date'] = end_date;
    _data['start_time'] = start_time;
    _data['end_time'] = end_time;

    //CUSTOM ADD BY ME(FOR FINANCIALS)
    _data["discount"] = "0.0";
    _data["appointment_type"] = "Virtual";
    _data["meeting_type"] = "Virtual";
    _data["vat"] = "0";
    _data["message"] = "no message";
    _data["location"] = "no location";
    _data["displayName"] = "client name";
    _data['date'] = date;
    _data['phone_number'] = "";
    return _data;
  }
  
  
}



