import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';






class CustomCard extends StatelessWidget {
  const CustomCard({super.key, required this.onTap, required this.svgAsset, required this.title});
  final VoidCallback onTap;
  final String svgAsset;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          //height: 100,
          width: 190.w,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          decoration: BoxDecoration(
            color: AppColor.bgColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(svgAsset),
              SizedBox(height: 20.h,),
              Text(
                title,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  fontSize: 15.sp,
                  color: AppColor.blackColor
                ),
              )
            ],
          )
        ),
      ),
    );
  }
}



//for coming soon
class CustomCard2 extends StatelessWidget {
  const CustomCard2({super.key, required this.onTap, required this.svgAsset, required this.title});
  final VoidCallback onTap;
  final String svgAsset;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Container(
          //height: 100,
          width: 190.w,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          decoration: BoxDecoration(
            color: AppColor.bgColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SvgPicture.asset("assets/svg/coming_soon.svg")
                ],
              ),
              SvgPicture.asset(svgAsset),
              SizedBox(height: 20.h,),
              Text(
                title,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  fontSize: 15.sp,
                  color: AppColor.blackColor
                ),
              )
            ],
          )
        ),
      ),
    );
  }
}