
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
  final String booked_status;
  final String proof_of_payment;
  final String payment_reference_id;
  final String booking_generated_from_invoice;
  final String start_time;
  final String end_time;
  final String duration;


  DetailsModel({
    required this.id,
    required this.serviceProviderInfo,
    required this.bookingUserInfo,
    required this.serviceDetails,
    required this.booked_status, 
    required this.payment_reference_id,
    required this.proof_of_payment,
    required this.booking_generated_from_invoice,
    required this.start_time,
    required this.end_time,
    required this.duration,
  });

  factory DetailsModel.fromJson(Map<String, dynamic> json) {
    return DetailsModel(
      id: json['_id'] ?? '',
      serviceProviderInfo: ServiceProviderInfo.fromJson(
          json['service_provider_info'] ?? {}),
      bookingUserInfo:
          BookingUserInfo.fromJson(json['booking_user_info'] ?? {}),
      serviceDetails: ServiceDetails.fromJson(json['service_details'] ?? {}),
      booked_status: json["booked_status"] ?? 'non',
      payment_reference_id: json['payment_reference_id'] ?? "non",
      proof_of_payment: json['payment_proof'] ?? "no proof",
      booking_generated_from_invoice: json['booking_generated_from_invoice'] ?? "False",
      duration: json['duration'] ?? 'duration',
      start_time: json['start_time'] ?? 'non',
      end_time: json['end_time'] ?? 'non',
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
      userId: json['userId'] ?? 'non',
      email: json['email'] ?? 'non',
      displayName: json['displayName'] ?? 'non',
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
      userId: json['userId'] ?? 'no id',
      email: json['email'] ?? 'no email',
      displayName: json['displayName'] ?? 'name_null',
      phoneNumber: json['phone_number'] ?? 'phone_number',
    );
  }
}

class ServiceDetails {
  final String serviceId;
  final String serviceName;
  final String serviceFee;
  final String appointmentType;
  final String date;
  final String time;
  //final String start_time;
  //final String end_time;
  //final String duration;
  //final String bookedStatus;
  //final String available_time;
  final String message;
  final dynamic file;
  final String location;
  final int createdAt;
  final String service_type;

  ServiceDetails({
    required this.serviceId,
    required this.serviceName,
    required this.serviceFee,
    required this.appointmentType,
    required this.date,
    required this.time,
    required this.message,
    required this.file,
    required this.location,
    required this.createdAt,
    required this.service_type,
    //required this.available_time,
    //required this.start_time,
    //required this.end_time,
    //required this.bookedStatus,
    //required this.duration,
  });

  factory ServiceDetails.fromJson(Map<String, dynamic> json) {
    return ServiceDetails(
      //available_time: json['available_time'] ?? 'non',
      serviceId: json['service_id'] ?? 'non',
      serviceName: json['service_name'] ?? 'non',
      serviceFee: json['service_fee'] ?? 'service_fee',
      service_type: json['service_type'] ?? 'service_type',
      appointmentType: json['appointment_type'] ?? 'non',
      date: json['date'] ?? 'date',
      time: json['time'] ?? 'time',
      //start_time: json['start_time'] ?? '9:00 AM',
      //end_time: json['end_time'] ?? '10:00 AM',
      //duration: json['duration'] ?? '',
      message: json['message'] ?? '',
      file: json['file'] ?? '',
      location: json['location'] ?? '',
      //bookedStatus: json['booked_status'] ?? '',
      createdAt: json['created_at'] ?? 0,
    );
  }
}
