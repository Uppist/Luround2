class UserServiceModel {
  final String serviceId;
  final String email;
  final String serviceName;
  final String description;
  final List<dynamic> links;
  final String serviceChargeInPerson;
  final String serviceChargeVirtual;
  final String duration;
  final String time;
  final Map<String, dynamic> serviceProviderDetails;
  final String date;
  final Map<String, dynamic> serviceLink;
  final List<dynamic> pricing;
  final String serviceType;
  final String serviceRecurrence;
  final int maxNumberOfParticipants;
  final String startDate;
  final String endDate;
  final String startTime;
  final String eventType;
  final String endTime;
  final String virtualMeetingLink;
  final String physicalLocationAddress;
  final List<dynamic> availabilitySchedule;
  final List<dynamic> eventSchedule;
  final Map<String, dynamic> programFee;
  final String serviceStatus;

  UserServiceModel({
    required this.serviceId,
    required this.email,
    required this.serviceName,
    required this.description,
    required this.links,
    required this.serviceChargeInPerson,
    required this.serviceChargeVirtual,
    required this.duration,
    required this.time,
    required this.serviceProviderDetails,
    required this.date,
    required this.serviceLink,
    required this.pricing,
    required this.serviceType,
    required this.serviceRecurrence,
    required this.maxNumberOfParticipants,
    required this.startDate,
    required this.endDate,
    required this.startTime,
    required this.eventType,
    required this.endTime,
    required this.virtualMeetingLink,
    required this.physicalLocationAddress,
    required this.availabilitySchedule,
    required this.eventSchedule,
    required this.programFee,
    required this.serviceStatus,
  });

  factory UserServiceModel.fromJson(Map<String, dynamic> json) {
    return UserServiceModel(
      serviceId: json['_id'] ?? '_id',
      email: json['email'] ?? 'email',
      serviceName: json['service_name'] ?? 'service_name',
      description: json['description'] ?? 'service_description',
      links: json['links'] ?? [],
      serviceChargeInPerson: json['virtual_event_fee'] ?? 'non',
      serviceChargeVirtual: json['in_person_event_fee'] ?? 'non',
      duration: json['duration'] ?? 'duration',
      time: json['time'] ?? '',
      serviceProviderDetails: json['service_provider_details'] ?? {}, //"userId", "email", "displayName",
      date: json['date'] ?? 'date-null',
      serviceLink: json['service_link'] ?? {}, //"longURL", "shortURL" 
      pricing: json['pricing'] ?? [], //"time_allocation", "virtual_pricing", "in_person_pricing",
      serviceType: json['service_type'] ?? 'service_type',
      serviceRecurrence: json['service_recurrence'] ?? 'service_recurrence',
      maxNumberOfParticipants: json['max_number_of_participants'] ?? 0,
      startDate: json['start_date'] ?? 'start_date',
      endDate: json['end_date'] ?? 'end_date',
      startTime: json['start_time'] ?? 'start_time',
      endTime: json['end_time'] ?? 'end_time',
      eventType: json['event_type'] ?? 'event_type',
      virtualMeetingLink: json['virtual_meeting_link'] ?? '',
      physicalLocationAddress: json['physical_location'] ?? '',
      availabilitySchedule: json['availability_schedule'] ?? [],  //"availability_day", "from_time", "to_time"
      eventSchedule: json['event_schedule'] ?? [], //"date", "time", "end_time",
      programFee: json['program_fee'] ?? {},
      serviceStatus: json['service_status'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['service_id'] = serviceId;
    _data['email'] = email;
    _data['service_name'] = serviceName;
    _data['description'] = description;
    _data['links'] = links;
    _data['service_charge_in_person'] = serviceChargeInPerson;
    _data['service_charge_virtual'] = serviceChargeVirtual;
    _data['duration'] = duration;
    _data['time'] = time;
    _data['service_provider_details'] = serviceProviderDetails;
    _data['date'] = date;
    _data['service_link'] = serviceLink;
    _data['pricing'] = pricing;
    _data['service_type'] = serviceType;
    _data['service_recurrence'] = serviceRecurrence;
    _data['max_number_of_participants'] = maxNumberOfParticipants;
    _data['start_date'] = startDate;
    _data['end_date'] = endDate;
    _data['start_time'] = startTime;
    _data['end_time'] = endTime;
    _data['event_type'] = eventType;
    _data['virtual_meeting_link'] = virtualMeetingLink;
    _data['physical_location_address'] = physicalLocationAddress;
    _data['availability_schedule'] = availabilitySchedule;
    _data['event_schedule'] = eventSchedule;
    _data['program_fee'] = programFee;
    _data['service_status'] = serviceStatus;

    // Additional fields for financials
    _data['discount'] = '0.0';
    _data['appointment_type'] = 'Virtual';
    _data['meeting_type'] = 'Virtual';
    _data['vat'] = '0';
    _data['message'] = 'no message';
    _data['location'] = 'no location';
    _data['displayName'] = 'client name';
    _data['phone_number'] = '';

    return _data;
  }
}
