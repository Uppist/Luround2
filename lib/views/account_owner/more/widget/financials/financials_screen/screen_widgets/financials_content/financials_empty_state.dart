import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';






class FinancialsEmptyState extends StatelessWidget {
  const FinancialsEmptyState({super.key,});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.bgColor,
      alignment: Alignment.center,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 100.h,),
          SvgPicture.asset('assets/financials/no_financials.svg'),
          SizedBox(height: 30.h,),
          Text(
            'No Financial documents yet',
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                color: AppColor.blackColor,
                fontSize: 17.sp,
                fontWeight: FontWeight.bold
              )
            )
          ),
          SizedBox(height: 10.h,),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Click on the ',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      color: AppColor.darkGreyColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500
                    )
                  )
                ),
                TextSpan(
                  text: '"Plus icon"',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      color: AppColor.blackColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold
                    )
                  )
                ),
                TextSpan(
                  text: 'to create\n          a financial document.',
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
          SizedBox(height: 60.h,),
        ],
      ),
    );
  }
}