import 'package:get/get.dart';



class CertificateModel{
  CertificateModel({
    required this.issuingOrganization,
    required this.certificateName,
    required this.issueDate,
    required this.certificateLink,
  });

  late final String issuingOrganization;
  late final String certificateName;
  late final String issueDate;
  late final String certificateLink;
  
  CertificateModel.fromJson(Map<String, dynamic> json,){
    issuingOrganization = json['issuingOrganization'];
    certificateName = json['certificateName'];
    issueDate = json['issueDate'];
    certificateLink = json['certificateLink'];
  }

}
