import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';







class FilterContainer extends StatelessWidget {
  const FilterContainer({super.key, required this.onTaped});
  final VoidCallback onTaped;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTaped,
      child: Container(
        height: 50.h,
        width: 150.w,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: AppColor.greyColor,
          border: Border.all(color: AppColor.textGreyColor.withOpacity(0.1)),
          borderRadius: BorderRadius.circular(12.r)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset("assets/svg/filter_icon.svg"),
                SizedBox(width: 10.w),
                Text(
                  "Filter",
                  style: GoogleFonts.poppins(
                    color: AppColor.textGreyColor,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400
                  ),
                ),
              ],
            ),
            Icon(
              CupertinoIcons.chevron_down,
              color: AppColor.blackColor,
              size: 20,
            )
          ],
        ),
      )
    );
  }
}