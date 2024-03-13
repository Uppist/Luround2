import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';




class UpgradeButton extends StatelessWidget {
  const UpgradeButton({super.key, required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        //padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        alignment: Alignment.center,
        height: 50.h,
        width: 150.w,
        decoration: BoxDecoration(
          color: AppColor.mainColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          "Subscribe", //"Change",
          style: GoogleFonts.inter(
            textStyle: TextStyle(
              color: AppColor.bgColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500
            )
          )
        ),
      )
    );
  }
}