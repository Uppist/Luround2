
//change this model to suit what's inside the details list. 






class UserBookingModel {
  final bool userBooked;
  final List<DetailsModel> details;

  UserBookingModel({required this.userBooked, required this.details});

  factory UserBookingModel.fromJson(Map<String, dynamic> json) {
    return UserBookingModel(
      userBooked: json['userBooked'] ?? false,
      details: (json['details'] as List<dynamic>?)
          ?.map((detailsJson) => DetailsModel.fromJson(detailsJson))
          .toList() ?? [],
    );
  }
}

class DetailsModel {
  final String id;  //this is the booking id
  final ServiceProviderInfo serviceProviderInfo;
  final BookingUserInfo bookingUserInfo;
  final ServiceDetails serviceDetails;

  DetailsModel({
    required this.id,
    required this.serviceProviderInfo,
    required this.bookingUserInfo,
    required this.serviceDetails,
  });

  factory DetailsModel.fromJson(Map<String, dynamic> json) {
    return DetailsModel(
      id: json['_id'] ?? '',
      serviceProviderInfo: ServiceProviderInfo.fromJson(
          json['service_provider_info'] ?? {}),
      bookingUserInfo:
          BookingUserInfo.fromJson(json['booking_user_info'] ?? {}),
      serviceDetails: ServiceDetails.fromJson(json['service_details'] ?? {}),
    );
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

class BookingUserInfo {
  final String userId;
  final String email;
  final String displayName;
  final String phoneNumber;

  BookingUserInfo({
    required this.userId,
    required this.email,
    required this.displayName,
    required this.phoneNumber,
  });

  factory BookingUserInfo.fromJson(Map<String, dynamic> json) {
    return BookingUserInfo(
      userId: json['userId'] ?? '',
      email: json['email'] ?? '',
      displayName: json['displayName'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
    );
  }
}

class ServiceDetails {
  final String serviceId;
  final String serviceName;
  final dynamic serviceFee;
  final String appointmentType;
  final String date;
  final String time;
  final String duration;
  final String message;
  final dynamic file;
  final String location;
  final String bookedStatus;
  final int createdAt;

  ServiceDetails({
    required this.serviceId,
    required this.serviceName,
    required this.serviceFee,
    required this.appointmentType,
    required this.date,
    required this.time,
    required this.duration,
    required this.message,
    required this.file,
    required this.location,
    required this.bookedStatus,
    required this.createdAt,
  });

  factory ServiceDetails.fromJson(Map<String, dynamic> json) {
    return ServiceDetails(
      serviceId: json['service_id'] ?? '',
      serviceName: json['service_name'] ?? '',
      serviceFee: json['service_fee'] ?? '',
      appointmentType: json['appointment_type'] ?? '',
      date: json['date'] ?? '',
      time: json['time'] ?? '',
      duration: json['duration'] ?? '',
      message: json['message'] ?? '',
      file: json['file'] ?? '',
      location: json['location'] ?? '',
      bookedStatus: json['booked_status'] ?? '',
      createdAt: json['created_at'] ?? 0,
    );
  }
}
