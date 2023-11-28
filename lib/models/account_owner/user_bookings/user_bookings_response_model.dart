
class UserBookingModel {
  UserBookingModel({
    required this.userBooked,
    required this.details,
  });

  late final bool userBooked; //
  late final List<dynamic> details;

  //[FOR GET REQUEST]
  UserBookingModel.fromJson(Map<String, dynamic> json,){
    details = json['details'] ?? [];
    userBooked = json['userBooked'] ?? false;

  }
  
  //[FOR PUT/POST/DELETE REQUEST]//
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data["details"] = details;
    _data["userBooked"] = userBooked;
    return _data;
  }
}



