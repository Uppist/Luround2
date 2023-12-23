


class BookServiceResponseMdel {
  BookServiceResponseMdel({
    required this.payment_link,
  });
  late final String payment_link;
  late final String booking_id;
  
  BookServiceResponseMdel.fromJson(Map<String, dynamic> json,){
    payment_link = json['booking_payment_link'] ?? "booking_payment_link";
    booking_id = json['BookingId'] ?? "BookingId";
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['payment_link'] = payment_link;
    _data['BookingId'] = booking_id;
    return _data;
  }
}