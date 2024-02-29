import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';




class YearlySubscriptionPage extends StatelessWidget {
  const YearlySubscriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        
        //normal white container
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColor.bgColor,
              borderRadius: BorderRadius.circular(15.r),
              //border: Border.all(color: AppColor.navyBlue)
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h),
                Center(
                  child: Text(
                    "Standard Plan",
                    style: GoogleFonts.inter(
                      color: AppColor.darkGreyColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
    
        //yellow stacked container
        Positioned(
          top: 5.h, // Adjust this value to control how much it protrudes
          left: 130,
          child: Container(
            //padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            alignment: Alignment.center,
            height: 35.h,
            width: 110.w,
            decoration: BoxDecoration(
              color: AppColor.yellowStar,
              borderRadius: BorderRadius.circular(40.r),
            ),
            child: Text(
              'You save 52%',
              style: GoogleFonts.inter(
                color: AppColor.bgColor,
                fontSize: 12.sp,
                fontWeight: FontWeight.w700
              ),
            )
          ),
        ),
      ],
    );
  }
}