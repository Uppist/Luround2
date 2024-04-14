import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/views/account_viewer/mainpage/screen/mainpage._acc_viewer.dart';












class TransactionSuccesscreen extends StatefulWidget {
  const TransactionSuccesscreen({super.key, required this.servie_provider_name, required this.service_name,});
  final String servie_provider_name;
  final String service_name;


  @override
  State<TransactionSuccesscreen> createState() => _TransactionSuccesscreenState();
}

class _TransactionSuccesscreenState extends State<TransactionSuccesscreen> {

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            //SizedBox(height: 20.h),
            Container(
              color: AppColor.greyColor,
              width: double.infinity,
              height: 7.h,
            ),
            SizedBox(height: 150.h,),
            Icon(
              CupertinoIcons.check_mark_circled,
              color: AppColor.mainColor,
              size: 150.r,
            ),
            /*SvgPicture.asset(
              "assets/svg/check_ss.svg",
              height: 110.h,
              width: 110.w,
            ),*/
            SizedBox(height: 60.h,),
            Text(
              "Booking Made",
              style: GoogleFonts.inter(
                color: AppColor.darkGreyColor,
                fontSize: 20.sp,
                fontWeight: FontWeight.w600
              ),
            ),
            SizedBox(height: 30.h,),
        
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text:"You'll receive a confirmation email ",
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
                        color: AppColor.darkGreyColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500
                      )
                    )
                  ),
                  TextSpan(
                    text:'when your booking has been ',
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
                        color: AppColor.darkGreyColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500
                      )
                    )
                  ),
                  TextSpan(
                    text:'confirmed by service provider',
                    style: GoogleFonts.inter(
                      textStyle: TextStyle(
                        color: AppColor.darkGreyColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500
                      )
                    )
                  ),
                ]
              )
            ),
        
            //sizedbox_height
            SizedBox(height: MediaQuery.of(context).size.height * 0.05,),

            InkWell(
              onTap: () {
                Get.offAll(() => MainPageAccViewer(), transition: Transition.rightToLeft);
              },
              child: Container(
                //padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                alignment: Alignment.center,
                height: 50.h,
                width: 250.w,
                decoration: BoxDecoration(
                  color: AppColor.mainColor,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(
                    color: AppColor.mainColor
                  )
                ),
                child: Text(
                  "Okay",
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                      color: AppColor.bgColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500
                    )
                  )
                ),
              )
            )
            
          ]
        )
      )
    );
  }
}