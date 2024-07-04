import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';




class SuspendedTag extends StatelessWidget {
  const SuspendedTag({super.key, required this.index});
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.h,
      width: 90.w, //100.w
      alignment: Alignment.center,
      //padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: index.isEven ? AppColor.darkGreen : AppColor.navyBlue,
        borderRadius: BorderRadius.circular(30.r)
      ),
      child: Text(
        'suspended',
        style: GoogleFonts.inter(
          color: AppColor.bgColor,
          fontSize: 12.sp,
          fontWeight: FontWeight.w400
        ),
      ),
    );
  }
}