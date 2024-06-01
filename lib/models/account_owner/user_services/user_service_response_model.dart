


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
  final ServiceProviderInfo serviceProviderDetails;
  final String date;
  final ServiceLinkDetails serviceLink;
  final List<PricingInfo> pricing;
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
  final List<AvailabilityScheduleInfo> availabilitySchedule;
  final List<EventScheduleInfo> eventSchedule;
  final List<String> coreFeatures;
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
    required this.coreFeatures,
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
      serviceProviderDetails: ServiceProviderInfo.fromJson(json['service_provider_info'] ?? {}),
      date: json['date'] ?? 'date-null',
      serviceLink: ServiceLinkDetails.fromJson(json['service_link'] ?? {}),
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
      pricing: (json['pricing'] as List<dynamic>?)?.map((detailsJson) => PricingInfo.fromJson(detailsJson)).toList() ?? [],
      availabilitySchedule: (json['availability_schedule'] as List<dynamic>?)?.map((detailsJson) => AvailabilityScheduleInfo.fromJson(detailsJson)).toList() ?? [],
      eventSchedule: (json['event_schedule'] as List<dynamic>?)?.map((detailsJson) => EventScheduleInfo.fromJson(detailsJson)).toList() ?? [],
      programFee: json['program_fee'] ?? {},
      coreFeatures: json['core_features'] ?? [],
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
    _data['in_person_event_fee'] = serviceChargeInPerson;
    _data['virtual_event_fee'] = serviceChargeVirtual;
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
    _data['physical_location'] = physicalLocationAddress;
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




class EventScheduleInfo {
  final String date;
  final String time;
  final String end_time;
  EventScheduleInfo({
    required this.date,
    required this.time,
    required this.end_time,
  });

  factory EventScheduleInfo.fromJson(Map<String, dynamic> json) {
    return EventScheduleInfo(
      date: json['date'] ?? '',
      time: json['time'] ?? '',
      end_time: json['end_time'] ?? '',
    );
  }
}


class AvailabilityScheduleInfo {
  final String availability_day;
  final String from_time;
  final String to_time;
  AvailabilityScheduleInfo({
    required this.availability_day,
    required this.from_time,
    required this.to_time,
  });

  factory AvailabilityScheduleInfo.fromJson(Map<String, dynamic> json) {
    return AvailabilityScheduleInfo(
      availability_day: json['availability_day'] ?? '',
      from_time: json['from_time'] ?? '',
      to_time: json['to_time'] ?? '',
    );
  }
}

class PricingInfo {
  String time_allocation;
  String virtual_pricing;
  String in_person_pricing;
  PricingInfo({
    required this.time_allocation,
    required this.virtual_pricing,
    required this.in_person_pricing,
  });

  factory PricingInfo.fromJson(Map<String, dynamic> json) {
    return PricingInfo(
      time_allocation: json['time_allocation'] ?? '',
      virtual_pricing: json['virtual_pricing'] ?? '',
      in_person_pricing: json['in_person_pricing'] ?? '',
    );
  }
  // Convert a DaySelectionModel object to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'time_allocation': time_allocation,
      'virtual_pricing': virtual_pricing,
      'in_person_pricing': in_person_pricing,
    };
  }
}


class ServiceProviderInfo {
  final String userId;
  final String email;
  final String displayName;
  ServiceProviderInfo({
    required this.userId,
    required this.email,
    required this.displayName,
  });

  factory ServiceProviderInfo.fromJson(Map<String, dynamic> json) {
    return ServiceProviderInfo(
      userId: json['userId'] ?? '',
      email: json['email'] ?? '',
      displayName: json['displayName'] ?? '',
    );
  }
}

class ServiceLinkDetails {
  final String longURL;
  final String shortURL;
  //"longURL", "shortURL" 
  ServiceLinkDetails({
    required this.longURL,
    required this.shortURL,
  });

  factory ServiceLinkDetails.fromJson(Map<String, dynamic> json) {
    return ServiceLinkDetails(
      longURL: json['longURL'] ?? '',
      shortURL: json['shortURL'] ?? '',
    );
  }
}