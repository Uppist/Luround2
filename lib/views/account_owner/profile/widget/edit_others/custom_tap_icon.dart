import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../utils/colors/app_theme.dart';






class CustomTapIcon extends StatelessWidget {
  const CustomTapIcon({super.key, required this.onTap, required this.svgAssetName, required this.iconTitle,});
  final VoidCallback onTap;
  final String svgAssetName;
  final String iconTitle;
  

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        width: 100.w,
        padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
        child: Column(             
          crossAxisAlignment: CrossAxisAlignment.center,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(svgAssetName),
            SizedBox(height: 20.h,),
            Text(
              iconTitle,
              style: GoogleFonts.inter(
                color: AppColor.textGreyColor,
                fontSize: 15.sp,
                fontWeight: FontWeight.w500
              ),
            ),
          ]
        ),
      ),
    );
  }
}