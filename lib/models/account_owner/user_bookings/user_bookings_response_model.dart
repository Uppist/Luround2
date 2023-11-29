
//change this model to suit what's inside the details list. 

class UserBookingModel {
  UserBookingModel({
    required this.userBooked,
    required this.details,
  });

  late final bool userBooked; //
  late final List<dynamic> details;

  //[FOR GET REQUEST]
  /*UserBookingModel.fromJson(Map<String, dynamic> json,){
    details = json['details'] ?? [];
    userBooked = json['userBooked'] ?? false;

  }*/

   // Factory method to create a UserBookingModel from a Map
  factory UserBookingModel.fromJson(Map<String, dynamic> json) {
    return UserBookingModel(
      // Map the existing fields from the json Map
      // Assuming "details" is a List field in your UserBookingModel
      details: List<dynamic>.from(json['details']),
      userBooked: json["userBooked"] ?? false
      // Map other fields as needed
    );
  }

  // Add a field for "details"
  //List<String> details;
  
  //[FOR PUT/POST/DELETE REQUEST]//
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data["details"] = details;
    _data["userBooked"] = userBooked;
    return _data;
  }
}



