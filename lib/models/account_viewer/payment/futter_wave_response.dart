

class FlutterWaveResponse {
  FlutterWaveResponse({
    required this.payment_link,
  });
  late final String payment_link;
  
  FlutterWaveResponse.fromJson(Map<String, dynamic> json,){
    payment_link = json['payment_link'] ?? "payment_link";
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['payment_link'] = payment_link;
    return _data;
  }
}