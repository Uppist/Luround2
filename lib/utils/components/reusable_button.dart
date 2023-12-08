import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';



class ReusableButton extends StatelessWidget {
  const ReusableButton({super.key, required this.color, required this.text, required this.onPressed});
  final Color color;
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      alignment: Alignment.center,
      height: 50.h,
      width: double.infinity,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: AppColor.mainColor
          )
        ),
        child: Text(
          text,
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