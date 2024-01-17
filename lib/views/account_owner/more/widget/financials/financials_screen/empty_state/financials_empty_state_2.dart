import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';






class FinancialsEmptyState2 extends StatelessWidget {
  const FinancialsEmptyState2({super.key, required this.titleText, required this.subtitleText, required this.onRefresh,});
  final String titleText;
  final String subtitleText;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.bgColor,
      alignment: Alignment.center,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 70.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //SizedBox(height: 20.h,),
          SvgPicture.asset('assets/financials/no_financials.svg'),
          SizedBox(height: 30.h,),
          Text(
            titleText,
            style: GoogleFonts.inter(
              textStyle: TextStyle(
                color: AppColor.blackColor,
                fontSize: 20.sp,
                fontWeight: FontWeight.w600
              )
            )
          ),
          SizedBox(height: 20.h,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Text(
              "When you get $subtitleText, \n            they'll show up here",
              style: GoogleFonts.inter(
                textStyle: TextStyle(
                  color: AppColor.darkGreyColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500
                )
              )
            ),
          ),

          SizedBox(height: 60.h,),
  
          //Refresh BUTTON
          InkWell(
            onTap: onRefresh,
            child: Container(
              //padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              alignment: Alignment.center,
              height: 50.h,
              width: 350.w,
              decoration: BoxDecoration(
                color: AppColor. mainColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: AppColor.mainColor
                )
              ),
              child: Text(
                'Refresh',
                style: GoogleFonts.inter(
                  textStyle: TextStyle(
                    color: AppColor.bgColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500
                  )
                )
              ),
            )
          ),
          SizedBox(height: 10.h,),
        ],
      ),
    );
  }
}