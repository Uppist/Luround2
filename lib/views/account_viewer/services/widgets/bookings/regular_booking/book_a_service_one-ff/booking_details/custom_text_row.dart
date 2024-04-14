import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';







class CustomTextRow extends StatelessWidget {
  CustomTextRow({super.key, required this.leftText, required this.rightText});
  final String leftText;
  final String rightText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 15.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            leftText,
            style: GoogleFonts.inter(
              color: AppColor.textGreyColor,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500
            ),
          ),
          Text(
            rightText,
            style: GoogleFonts.inter(
              color: AppColor.blackColor,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500
            ),
          ),
        ],
      ),
    );
  }
}