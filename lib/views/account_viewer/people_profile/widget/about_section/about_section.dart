import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';







class AccViewerAboutSection extends StatelessWidget {
  AccViewerAboutSection({super.key, required this.text,});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About',
          style: GoogleFonts.inter(
            textStyle: TextStyle(
              color: AppColor.blackColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600
            )
          )
        ),
        SizedBox(height: 20.h),
        Text(
          text,
          style: GoogleFonts.inter(
            textStyle: TextStyle(
              color: AppColor.darkGreyColor,
              fontSize: 14.sp,
              fontWeight: FontWeight.w400
            )
          )
        ),
      ]
    );
  }
}