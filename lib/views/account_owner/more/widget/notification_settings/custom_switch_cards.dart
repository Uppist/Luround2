import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';






class CustomSwitchCard extends StatelessWidget {
  const CustomSwitchCard({super.key, required this.title, required this.switchButton});
  final Widget switchButton;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75.h,
      width: double.infinity,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: AppColor.bgColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w500,
              fontSize: 16.sp,
              color: AppColor.darkGreyColor
            ),
          ),
          switchButton
        ],
      )
    );
  }
}