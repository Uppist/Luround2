

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
  final String serviceLink;
  final List<PricingInfo> pricing;
  final String serviceType;
  final String serviceRecurrence;
  final int maxNumberOfParticipants;
  final String startDate;
  final String endDate;
  final String startTime;
  final String endTime;
  final String eventType;
  final String oneoffType;
  final String price;
  final String virtualMeetingLink;
  final String physicalLocationAddress;
  final List<AvailabilityScheduleInfo> availabilitySchedule;
  final List<EventScheduleInfo> eventSchedule;
  final List<dynamic> coreFeatures;
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
    required this.endTime,
    required this.eventType,
    required this.oneoffType,
    required this.price,
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
      serviceChargeInPerson: json['in_person_event_fee'] ?? 'non',
      serviceChargeVirtual: json['virtual_event_fee'] ?? 'non',
      duration: json['duration'] ?? 'duration',
      time: json['time'] ?? 'time',
      serviceProviderDetails: ServiceProviderInfo.fromJson(json['service_provider_details'] ?? {}),
      date: json['date'] ?? 'date',
      serviceLink: json['service_link'] ?? "service_link",
      serviceType: json['service_type'] ?? 'service_type',
      serviceRecurrence: json['service_recurrence'] ?? 'service_recurrence',
      maxNumberOfParticipants: json['max_number_of_participants'] ?? 0,
      startDate: json['start_date'] ?? 'start_date',
      endDate: json['end_date'] ?? 'end_date',
      startTime: json['start_time'] ?? 'start_time',
      endTime: json['end_time'] ?? 'end_time',
      eventType: json['event_type'] ?? 'event_type',
      oneoffType: json['oneoff_type'] ?? 'oneoff_type',
      price: json['price'] ?? 'price',
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
    return {
      'service_id': serviceId,
      'email': email,
      'service_name': serviceName,
      'description': description,
      'links': links,
      'in_person_event_fee': serviceChargeInPerson,
      'virtual_event_fee': serviceChargeVirtual,
      'duration': duration,
      'time': time,
      'service_provider_details': serviceProviderDetails.toJson(),
      'date': date,
      'service_link': serviceLink,
      'pricing': pricing.map((e) => e.toJson()).toList(),
      'service_type': serviceType,
      'service_recurrence': serviceRecurrence,
      'max_number_of_participants': maxNumberOfParticipants,
      'start_date': startDate,
      'end_date': endDate,
      'start_time': startTime,
      'end_time': endTime,
      'event_type': eventType,
      'oneoff_type': oneoffType,
      'price': price,
      'virtual_meeting_link': virtualMeetingLink,
      'physical_location': physicalLocationAddress,
      'availability_schedule': availabilitySchedule.map((e) => e.toJson()).toList(),
      'event_schedule': eventSchedule.map((e) => e.toJson()).toList(),
      'program_fee': programFee,
      'service_status': serviceStatus,
      'core_features': coreFeatures,
      'discount': '0.0',
      'appointment_type': 'Virtual',
      'meeting_type': 'Virtual',
      'message': 'no message',
      'location': 'no location',
      'displayName': 'client name',
      'phone_number': '',
      'due_date': '',
      'vat': '0',
      'rate': '0',
      'total': '0',
    };
  }
}

class EventScheduleInfo {
  final String date;
  final String time;
  final String endTime;

  EventScheduleInfo({
    required this.date,
    required this.time,
    required this.endTime,
  });

  factory EventScheduleInfo.fromJson(Map<String, dynamic> json) {
    return EventScheduleInfo(
      date: json['date'] ?? '',
      time: json['time'] ?? '',
      endTime: json['end_time'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'time': time,
      'end_time': endTime,
    };
  }
}

class AvailabilityScheduleInfo {
  final String availabilityDay;
  final String fromTime;
  final String toTime;

  AvailabilityScheduleInfo({
    required this.availabilityDay,
    required this.fromTime,
    required this.toTime,
  });

  factory AvailabilityScheduleInfo.fromJson(Map<String, dynamic> json) {
    return AvailabilityScheduleInfo(
      availabilityDay: json['availability_day'] ?? '',
      fromTime: json['from_time'] ?? '',
      toTime: json['to_time'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'availability_day': availabilityDay,
      'from_time': fromTime,
      'to_time': toTime,
    };
  }
}

class PricingInfo {
  String timeAllocation;
  String virtualPricing;
  String inPersonPricing;

  PricingInfo({
    required this.timeAllocation,
    required this.virtualPricing,
    required this.inPersonPricing,
  });

  factory PricingInfo.fromJson(Map<String, dynamic> json) {
    return PricingInfo(
      timeAllocation: json['time_allocation'] ?? '',
      virtualPricing: json['virtual_pricing'] ?? '',
      inPersonPricing: json['in_person_pricing'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'time_allocation': timeAllocation,
      'virtual_pricing': virtualPricing,
      'in_person_pricing': inPersonPricing,
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

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'email': email,
      'display_name': displayName,
    };
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

  Map<String, dynamic> toJson() {
    return {
      'longURL': longURL,
      'shortURL': shortURL,
    };
  }
}

