



class UserServiceModel {
  UserServiceModel({
    required this.serviceId,
    required this.email,
    required this.service_name,
    required this.description,
    required this.service_charge_in_person,
    required this.service_charge_virtual,
    required this.duration,
    required this.time,
    required this.service_provider_details,
    required this.date,
    required this.service_link,

    //NEW UPDATES
    required this.service_type,
    required this.service_recurrence,
    required this.max_number_of_participants,

    required this.start_date,
    required this.end_date,
    required this.start_time,
    required this.end_time,
    required this.pricing,
    required this.virtual_meeting_link,
    required this.physical_location_address,
    required this.availability_schedule,
    required this.event_schedule,
    required this.program_fee,
    required this.service_status,
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
  late final Map<String, dynamic> service_provider_details;
  late final String date;
  late final String service_link;  //meant to be 'String' because it's an auto-generated service link from backend
  late final List<dynamic> pricing;

  //NEW ITEMS FOR THE 3 TYPES OF SERVICES
  late final String service_type;
  late final String service_recurrence;
  late final int max_number_of_participants;
  late final String start_date;
  late final String end_date;
  late final String start_time;
  late final String end_time;
  late final String virtual_meeting_link;
  late final String physical_location_address;
  late final List<dynamic> availability_schedule;
  late final List<dynamic> event_schedule;
  late final Map<String, dynamic> program_fee;
  late final String service_status;
  
  //"service_status": "ACTIVE"



  //[FOR GET REQUEST]
  factory UserServiceModel.fromJson(Map<String, dynamic> json,){
    return UserServiceModel(
      serviceId: json['_id'] ?? "_id",
      email: json['email'] ?? "email",
      service_name: json['service_name'] ?? "service_name",
      description: json['description'] ?? "service_description",
      service_charge_in_person: json['service_charge_in_person'] ?? "non",
      service_charge_virtual: json['service_charge_virtual'] ?? "non",
      pricing: json['pricing'] ?? [], //"time_allocation", "virtual", "in_person"
      virtual_meeting_link: json['virtual_meeting_link'],
      physical_location_address: json['physical_location'],
      duration: json['duration'] ?? "duration",
      service_provider_details: json['service_provider_details'] ?? {}, //{userId: 66435818c053661df04b15fe, email: japhetebelechukwu@gmail.com, displayName: Japhet Ebelechukwu},
      date: json['date'] ?? "date-null",
      service_link: json['service_link'] ?? '', //auto-generated
      time: json['time'] ?? '',

    
      service_type: json['service_type'] ?? "service_type",
      service_recurrence: json['service_recurrence'] ?? "service_recurrence",
      max_number_of_participants: json['max_number_of_participants'] ?? 0,
    
      //what i will show somto
      start_date: json['start_date'] ?? "start_date",
      end_date: json['end_date'] ?? "end_date",
      start_time: json['start_time'] ?? "start_time",
      end_time: json['end_time'] ?? "end_time",
      availability_schedule: json['availability_schedule'] ?? [], //"day", "from_time", "to_time"
      program_fee: json['program_fee'] ?? {}, //"virtual", "in_person",
      event_schedule: json['event_schedule'] ?? [], //"date", "start_time", "end_time"
      service_status: json['service_status'] ?? "" //'ACTIVE' 'INACTIVE'

    );
  }
  
  //to Map
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['service_id'] = serviceId;
    _data['email'] = email;
    _data['service_name'] = service_name;
    _data['description'] = description;
    _data["rate"] = service_charge_virtual;
    _data["total"] = service_charge_virtual;
    //_data["appointment"] = appointment;
    _data["duration"] = duration;
    _data['time'] = time;
    _data['service_provider_details'] = service_provider_details;
    _data['service_link'] = service_link;

    //NEW UPDATE
    _data['service_type'] = service_type;
    _data['service_recurrence'] = service_recurrence;
    _data['max_number_of_participants'] = max_number_of_participants;

    //what i will show somto
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



