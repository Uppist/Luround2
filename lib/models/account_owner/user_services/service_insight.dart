
class UserServiceInsightModel {
  UserServiceInsightModel({
    required this.booking_count,
    required this.booking_clicks,
    required this.bookings_list,
  });
  late final int booking_count;
  late final int booking_clicks;
  late final List<dynamic> bookings_list;


  //[FOR GET REQUEST]
  factory UserServiceInsightModel.fromJson(Map<String, dynamic> json,){
    return UserServiceInsightModel(
      booking_clicks: json['booking_clicks'] ?? 0,
      booking_count: json['booking_count'] ?? 0,
      bookings_list: json['bookings'] ?? [],
    );
  }
  
  //To Map
  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['booking_clicks'] = booking_clicks;
    _data['booking_count'] = booking_count;
    _data['bookings'] = bookings_list;
    return _data;
  }
  
  
}



