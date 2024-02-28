import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';






class FinancialsEmptyState extends StatelessWidget {
  const FinancialsEmptyState({super.key, required this.titleText, required this.subtitleText,});
  final String titleText;
  final String subtitleText;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.bgColor,
      alignment: Alignment.center,
      //height: 800.h,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 100.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20.h,),
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
          SizedBox(height: 15.h,),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Click on the ',
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                      color: AppColor.darkGreyColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500
                    )
                  )
                ),
                TextSpan(
                  text: '"Plus icon"',
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                      color: AppColor.blackColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500
                    )
                  )
                ),
                TextSpan(
                  text: 'to create\n                   $subtitleText.',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      color: AppColor.darkGreyColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500
                    )
                  )
                ),
              ]
            ),
          ),
          SizedBox(height: 20.h,), //60.h
        ],
      ),
    );
  }
}