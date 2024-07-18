import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';




class PriceGuide extends StatelessWidget {
  const PriceGuide({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 200.h,
      width: double.infinity,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      decoration: BoxDecoration(
        color: AppColor.navyBlue,
        borderRadius: BorderRadius.circular(5.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                size: 24.r,
                color: AppColor.bgColor,
                CupertinoIcons.info_circle,
              ),
              SizedBox(width: 7.w,),
              Expanded(
                child: Text(
                  "Input '0' in the text field for free virtual or in-person service",
                  style: GoogleFonts.inter(
                    color: AppColor.bgColor,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                size: 24.r,
                color: AppColor.bgColor,
                CupertinoIcons.info_circle,
              ),
              SizedBox(width: 7.w,),
              Expanded(
                child: Text(
                  "Leave the other field blank if the service is only virtual or in-person",
                  style: GoogleFonts.inter(
                    color: AppColor.bgColor,
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}