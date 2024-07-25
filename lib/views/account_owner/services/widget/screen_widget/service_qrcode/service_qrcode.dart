import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:qr_flutter/qr_flutter.dart';





class ServiceQRCodePage extends StatelessWidget {
  const ServiceQRCodePage({super.key, required this.serviceLink});
  final String serviceLink;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[  
            //Header
            /////////////
            SizedBox(height: 20.h,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 7.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(
                      Icons.arrow_back_rounded,
                      color: AppColor.blackColor,
                    )
                  ),
                  SizedBox(width: 3.w,),
                  Text(
                    "Service QR Code",
                    style: GoogleFonts.inter(
                      color: AppColor.blackColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ],
              ),
            ),
            ////////
            
            SizedBox(height: 20.h,),

            Center(
              child: Text(
                "Please Scan QR Code to share this service",
                style: GoogleFonts.inter(
                  color: AppColor.blackColor,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.italic
                ),
                textAlign: TextAlign.center,
              ),
            ),

            SizedBox(height: 20.h,),
        
            /////HERE/////////
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 40.w,
                  vertical: 20.h
                ),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColor.greyColor
                ),
                width: double.infinity,
                child: QrImageView(
                  data: serviceLink.replaceFirst('luround.com/', 'luround.com/service/#/'),
                  version: QrVersions.auto,
                  size: 250.w, //170.w,
                  errorStateBuilder: (context, error) {
                    return Text(
                      "Uh oh! Something went wrong! $error",
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.normal,
                        color: AppColor.darkGreyColor
                      ),
                    );
                  },
                ),
              ),
            )
          ]
        )
      )
    );
  }
}