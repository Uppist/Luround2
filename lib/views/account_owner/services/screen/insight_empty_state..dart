import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';









class InsightEmptyState extends StatelessWidget {
  const InsightEmptyState({super.key, required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 50.h),  //20.h
      child: Container(
        color: AppColor.bgColor,
        alignment: Alignment.center,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 80.h,), //20.h
            SvgPicture.asset('assets/svg/no_bookings.svg'),
            SizedBox(height: 30.h,),
            Text(
              'No service insight yet',
              style: GoogleFonts.inter(
                textStyle: TextStyle(
                  color: AppColor.blackColor,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w600
                )
              )
            ),
            SizedBox(height: 15.h,),
            Text(
              "When you get bookings, they'll\n              show up here.",
              style: GoogleFonts.inter(
                textStyle: TextStyle(
                  color: AppColor.darkGreyColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500
                )
              )
            ),
            SizedBox(height: 60.h,),
            //Refresh BUTTON
            InkWell(
              onTap: onPressed,
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
      ),
    );
  }
}