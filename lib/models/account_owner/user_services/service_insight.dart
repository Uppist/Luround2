
class UserServiceInsightModel {
  UserServiceInsightModel({
    required this.booking_count,
    required this.booking_clicks,
    required this.bookings_list,
  });
  final int booking_count;
  final int booking_clicks;
  final List<InsightInfo> bookings_list;


  //[FOR GET REQUEST]
  factory UserServiceInsightModel.fromJson(Map<String, dynamic> json,){
    return UserServiceInsightModel(
      booking_clicks: json['clicks'] ?? 0,
      booking_count: json['booking_count'] ?? 0,
      bookings_list: (json['bookings'] as List<dynamic>?)
          ?.map((detailsJson) => InsightInfo.fromJson(detailsJson))
          .toList() ?? [],
    );
  }
  
  //To Map
  Map<String, dynamic> toJson() {
    return {
      'clicks': booking_clicks,
      'booking_count': booking_count,
      'bookings': bookings_list
    };
  }
  
}

class InsightInfo {
  final String service_name;
  final String customer_name;
  final String service_amount;
  final String date_booked;

  InsightInfo({
    required this.service_name,
    required this.customer_name,
    required this.service_amount,
    required this.date_booked,
  });

  factory InsightInfo.fromJson(Map<String, dynamic> json) {
    return InsightInfo(
      service_name: json['service_name'] ?? '',
      customer_name: json['customer_name'] ?? '',
      service_amount: json['service_amount'] ?? '',
      date_booked: json['date_booked'] ?? 0,
    );
  }
}



