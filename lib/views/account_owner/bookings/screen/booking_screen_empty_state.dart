import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';







class BookingScreenEmptyState extends StatelessWidget {
  const BookingScreenEmptyState({super.key, required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      child: Container(
        color: AppColor.bgColor,
        alignment: Alignment.center,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20.h,),
            SvgPicture.asset('assets/svg/no_bookings.svg'),
            SizedBox(height: 30.h,),
            Text(
              'No bookings yet',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  color: AppColor.blackColor,
                  fontSize: 21.sp,
                  fontWeight: FontWeight.bold
                )
              )
            ),
            SizedBox(height: 15.h,),
            Text(
              "When you get bookings, they'll\n                 show up here",
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  color: AppColor.darkGreyColor,
                  fontSize: 17.sp,
                  //fontWeight: FontWeight.bold
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
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      color: AppColor.bgColor,
                      fontSize: 17.sp,
                      //fontWeight: FontWeight.w500
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