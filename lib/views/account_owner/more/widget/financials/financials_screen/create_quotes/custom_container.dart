import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';







class DateContainer extends StatelessWidget {
  const DateContainer({super.key, required this.onTap, required this.date});
  final VoidCallback onTap;
  final String date;


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 55.h,
        width: double.infinity,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
        decoration: BoxDecoration(
          color: AppColor.bgColor,
          border: Border.all(color: AppColor.textGreyColor, width: 1),
          borderRadius: BorderRadius.circular(5.r)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              date,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w500,
                fontSize: 15.sp,
                color: AppColor.blackColor
              ),
            ),
            SvgPicture.asset("assets/svg/calendar_icon.svg")
          ],
        ),
      ),
    );
  }
}