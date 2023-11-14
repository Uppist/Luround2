import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';








class NotificationEmptyState extends StatelessWidget {
  const NotificationEmptyState({super.key, required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 150.h,),
          SvgPicture.asset('assets/svg/notification_empty.svg'),
          SizedBox(height: 30.h,),
          Text(
            'No notifications yet',
            style: GoogleFonts.inter(
              textStyle: TextStyle(
                color: AppColor.blackColor,
                fontSize: 21.sp,
                fontWeight: FontWeight.bold
              )
            )
          ),
          SizedBox(height: 15.h,),
          Text(
            "When you get notifications, they'll\n                 show up here",
            style: GoogleFonts.inter(
              textStyle: TextStyle(
                color: AppColor.darkGreyColor,
                fontSize: 16.sp,
                //fontWeight: FontWeight.bold
              )
            )
          ),
          SizedBox(height: 60.h,),
          //Refresh BUTTON
          InkWell(
            onTap: onPressed,
            child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              alignment: Alignment.center,
              height: 50.h,
              width: 350.w,
              decoration: BoxDecoration(
                color: AppColor. mainColor,
                borderRadius: BorderRadius.circular(10.r),
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
                    //fontWeight: FontWeight.w500
                  )
                )
              ),
            )
          )
        ],
      ),
    );
  }
}