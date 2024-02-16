


class BookServiceResponseModel {
  BookServiceResponseModel({
    required this.payment_link,
    required this.booking_id,
    required this.userId,
    required this.user_nToken,
  });
  late final String payment_link;
  late final String booking_id;
  late final String userId;
  late final String user_nToken;
  
  BookServiceResponseModel.fromJson(Map<String, dynamic> json,){
    payment_link = json['booking_payment_link'] ?? "booking_payment_link";
    booking_id = json['BookingId'] ?? "BookingId";
    userId = json['_id'] ?? "id";
    user_nToken = json['user_nToken'] ?? "id";
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['payment_link'] = payment_link;
    _data['BookingId'] = booking_id;
    _data['_id'] = userId;
    _data['user_nToken'] = user_nToken;
    return _data;
  }
}