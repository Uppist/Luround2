import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';





class FilterBookingButton extends StatelessWidget {
  const FilterBookingButton({super.key, required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 55.h,
        width: 200.w, //150.w
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          decoration: BoxDecoration(
          color: AppColor.bgColor,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: AppColor.textGreyColor.withOpacity(0.1) //greyColor,
          )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Tap to filter',
              style: GoogleFonts.inter(
                color: AppColor.textGreyColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            Icon(
              size: 24.r,
              color: AppColor.textGreyColor,
              CupertinoIcons.chevron_down
            )
          ],
        ),
      ),
    );
  }
}