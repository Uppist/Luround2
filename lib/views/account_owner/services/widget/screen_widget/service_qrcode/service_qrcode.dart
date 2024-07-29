import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:qr_flutter/qr_flutter.dart';





class ServiceQRCodePage extends StatefulWidget {
  const ServiceQRCodePage({super.key, required this.serviceLink});
  final String serviceLink;

  @override
  State<ServiceQRCodePage> createState() => _ServiceQRCodePageState();
}

class _ServiceQRCodePageState extends State<ServiceQRCodePage> {

  @override
  void initState() {
    super.initState();

    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: AppColor.bgColor,
        statusBarColor: AppColor.darkMainColor,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: AppColor.bgColor,
        statusBarColor: AppColor.bgColor,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.darkMainColor,
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
                      Get.back();
                    },
                    icon: Icon(
                      Icons.arrow_back_rounded,
                      color: AppColor.bgColor,
                    )
                  ),
                  SizedBox(width: 3.w,),
                  Text(
                    "Service QR Code",
                    style: GoogleFonts.inter(
                      color: AppColor.bgColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ],
              ),
            ),
            ////////
        
            SizedBox(height: MediaQuery.of(context).size.height * 0.14.h),
        
            /////HERE/////////
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
              ),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 20.w,
                  vertical: 90.h
                ),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColor.bgColor,
                  borderRadius: BorderRadius.circular(20.r)
                ),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Please Scan QR Code to share this service",
                      style: GoogleFonts.inter(
                        color: AppColor.blackColor,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.italic
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20.h,),
                    QrImageView(
                      data: widget.serviceLink.replaceFirst('luround.com/', 'luround.com/service/#/'),
                      version: QrVersions.auto,
                      size: 260.w, //250.w,
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
                  ],
                ),
              ),
            )
          ]
        ),
      )
    );
  }
}