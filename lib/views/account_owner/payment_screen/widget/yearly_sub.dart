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
        //yellow stacked container
        Container(
          //padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          alignment: Alignment.center,
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
        
        //normal white container
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColor.bgColor,
            borderRadius: BorderRadius.circular(10.r),
            //border: Border.all(color: AppColor.navyBlue)
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [],
          ),
        ),
      ],
    );
  }
}