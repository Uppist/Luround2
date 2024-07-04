import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';




class TrxNote extends StatelessWidget {
  const TrxNote({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 200.h,
      width: double.infinity,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
      decoration: BoxDecoration(
        color: AppColor.navyBlue,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Row(
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
              "New payments are only available for withdrawal from wallet after 24 hours",
              style: GoogleFonts.inter(
                color: AppColor.bgColor,
                fontSize: 10.sp,
                fontWeight: FontWeight.w500
              ),
            ),
          ),
        ],
      ),
    );
  }
}