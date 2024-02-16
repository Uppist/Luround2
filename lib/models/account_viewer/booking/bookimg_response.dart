


class BookServiceResponseModel {
  BookServiceResponseModel({
    required this.booking_id,
    required this.userId,
    required this.user_nToken,
  });
  late final String booking_id;
  late final String userId;
  late final String user_nToken;
  
  BookServiceResponseModel.fromJson(Map<String, dynamic> json,){
    booking_id = json['BookingId'] ?? "BookingId";
    userId = json['userId'] ?? "id";
    user_nToken = json['user_nToken'] ?? "id";
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['BookingId'] = booking_id;
    _data['userId'] = userId;
    _data['user_nToken'] = user_nToken;
    return _data;
  }
}