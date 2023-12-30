import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/profile/profile_page_controller.dart';
import 'package:luround/services/account_owner/profile_service/user_profile_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/reusable_button.dart';
import 'package:luround/utils/components/title_text.dart';
import 'package:luround/views/account_owner/profile/widget/edit_education/edit_cert_details/cert_textfield.dart';





class EditCertDetails extends StatefulWidget {
  EditCertDetails({super.key, required this.issuingOrganization, required this.certificateName, required this.issueDate, required this.certificateLink});
  final String issuingOrganization;
  final String certificateName;
  final String issueDate;
  final String certificateLink;

  @override
  State<EditCertDetails> createState() => _EditCertDetailsState();
}

class _EditCertDetailsState extends State<EditCertDetails> {

  var controller = Get.put(ProfilePageController());
  var profileService = Get.put(AccOwnerProfileService());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.bgColor,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            CupertinoIcons.xmark,
            color: AppColor.blackColor,
          )
        ),
        title: CustomAppBarTitle(text: 'Edit education and certifications',),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 10.h),
            Container(
              color: AppColor.greyColor,
              width: double.infinity,
              height: 7.h,
            ),
            SizedBox(height: 20.h,),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //SizedBox(height: 10.h,),              
                    Text(
                      "Certification name*",
                      style: GoogleFonts.inter(
                        color: AppColor.blackColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500
                      )
                    ),
                
                    SizedBox(height: 20.h,),
                
                    CertDetailsTextField(
                      onChanged: (val) {
                        setState(() {
                          controller.editcerticateNameController.text = val;
                        });
                      },
                      hintText: "Certification name",
                      initialValue: widget.certificateName,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                    ),
                
                    SizedBox(height: 40.h,),
                
                    Text(
                      "Issuing organization*",
                      style: GoogleFonts.inter(
                        color: AppColor.blackColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500
                      )
                    ),
                
                    SizedBox(height: 20.h,),
                
                    CertDetailsTextField(
                      onChanged: (val) {
                        setState(() {
                          controller.editissuingOrganizationController.text = val;
                        });
                      },
                      hintText: "Issuing organization",
                      initialValue: widget.issuingOrganization,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                    ),
                
                    SizedBox(height: 40.h,),
                
                    Text(
                      "Issue date",
                      style: GoogleFonts.inter(
                        color: AppColor.blackColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500
                      )
                    ),
                
                    SizedBox(height: 20.h,),
                
                    CertDetailsTextField2(
                      onChanged: (val) {
                        setState(() {
                          controller.editissueDateController.text = val;
                        });
                      },
                      hintText: "Issue date",
                      initialValue: widget.issueDate,
                      keyboardType: TextInputType.datetime,
                      textInputAction: TextInputAction.next,
                    ),
                
                    SizedBox(height: 40.h,),
                
                    Text(
                      "Certificate URL",
                      style: GoogleFonts.inter(
                        color: AppColor.blackColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500
                      )
                    ),
                
                    SizedBox(height: 20.h,),
                
                    CertDetailsTextField(
                      onChanged: (val) {
                        setState(() {
                          controller.editcertificateURLController.text = val;
                        });
                      },
                      hintText: "Certificate URL",
                      initialValue: widget.certificateLink,
                      keyboardType: TextInputType.url,
                      textInputAction: TextInputAction.next,
                    ),
                
                    SizedBox(height: 160.h,),
                    
                    //run textcontroller check here
                    ReusableButton(
                      color: AppColor.mainColor,
                      text: 'Save',
                      onPressed: () async{
                        //profileService.editCertificate()
                      },
                    ),
                
                    SizedBox(height: 20.h,),
                    
                  ]
                )
              )
            )
          ]
        )
      )
    );
  
  }
}