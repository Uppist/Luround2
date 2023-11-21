
class CertificateResponse{
  CertificateResponse({
    required this.certificates,
  });

  late final List<dynamic> certificates;
  
  CertificateResponse.fromJson(Map<String, dynamic> json,){
    certificates = json['certificates'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['certificates'] = certificates;
    return _data;
  }
}
