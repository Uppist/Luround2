import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/reusable_button.dart';
import 'package:luround/utils/components/title_text.dart';
import 'package:luround/views/account_owner/profile/widget/edit_education/edit_cert_details/cert_textfield.dart';





class EditCertDetails extends StatelessWidget {
  const EditCertDetails({super.key});

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
                child: Padding(
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
                        onChanged: (p0) {},
                        hintText: "Certification name",
                        initialValue: "Goretzka",
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
                        onChanged: (p0) {},
                        hintText: "Issuing organization",
                        initialValue: "Goretzka",
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
                        onChanged: (p0) {},
                        hintText: "Issue date",
                        initialValue: "Goretzka",
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
                        onChanged: (p0) {},
                        hintText: "Certificate URL",
                        initialValue: "Goretzka",
                        keyboardType: TextInputType.url,
                        textInputAction: TextInputAction.next,
                      ),
                      SizedBox(height: 100.h,),
                      ReusableButton(
                        color: AppColor.mainColor,
                        text: 'Save',
                        onPressed: () async{},
                      ),
                      SizedBox(height: 20.h,),
                    ]
                  )
                )
              )
            )
          ]
        )
      )
    );
  
  }
}