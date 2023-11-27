
class UserBookingModel {
  UserBookingModel({
    required this.createdAt,
    required this.service_type,
    required this.bookingId,  ///
    required this.service_name,
    required this.service_receiver_names,
    required this.service_receiver_email,
    required this.phone_number,
    required this.appointment_type,
    required this.date,
    required this.time,
    required this.duration,
    required this.message,
    required this.location,  //
    required this.userBooked, //
  });

  late final String createdAt;
  late final String service_type;
  late final String bookingId; //
  late final String service_name;
  late final String service_receiver_names;
  late final String service_receiver_email;
  late final String phone_number;
  late final String appointment_type;
  late final String date;
  late final String time;
  late final String duration;
  late final String message;
  late final String location; //
  late final bool userBooked; //

  //[FOR GET REQUEST]
  UserBookingModel.fromJson(Map<String, dynamic> json,){
    createdAt = json['createdAt'] ?? "createdAt";  //convert to iso82340String
    bookingId = json['service_type'] ?? "service_type";
    bookingId = json['bookinId'] ?? "bookingId";
    service_name = json["service_name"] ?? "service_name";
    service_receiver_names = json['service_receiver_names'] ?? "service_receiver_names";
    service_receiver_email = json['service_receiver_email'] ?? "service_receiver_email";
    phone_number = json['phone_number'] ?? "phone_number";
    appointment_type = json['appointment_type'] ?? "appointment_type";
    date = json['date'] ?? "date";
    time = json['time'] ?? "time";
    duration = json['duration'] ?? "duration";
    message = json['message'] ?? "message";
    location = json['location'] ?? "location";
    date = json['userBooked'] ?? false;

  }
  
  //[FOR PUT/POST/DELETE REQUEST]//
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    //_data["createdAt"] = createdAt;
    _data["service_type"] = service_type;
    _data['bookingId'] = bookingId;
    _data["service_name"] = service_name;
    _data['service_receiver_names'] = service_receiver_names;
    _data['service_receiver_email'] = service_receiver_email;
    _data['phone_number'] = phone_number;
    _data['appointment_type'] = appointment_type;
    _data["date"] = date;
    _data['time'] = time;
    _data["duration"] = duration;
    _data['message'] = message;
    _data["location"] = location;
    _data["userBooked"] = userBooked;
    return _data;
  }
}



/*class ParentBookingModel {
  ParentBookingModel({
    required this.bookings
  });
  late final List<UserBookingModel> bookings;

  //[FOR GET REQUEST]
  ParentBookingModel.fromJson(Map<String, dynamic> json,){
    bookings = json['bookings'] ?? [];
  }
}*/