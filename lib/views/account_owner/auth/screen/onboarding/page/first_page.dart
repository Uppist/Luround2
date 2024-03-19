import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';






class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20.w,
        vertical: 20.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/onb_1.png',
            //height: 400,
            //width: 450,
          ),
          SizedBox(height: 55.h,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Text(
              'Create your profile page, add your\n           services and rate card.',
              style: GoogleFonts.inter(
                color: AppColor.darkGreyColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600
              ),
            ),
          ),        
        ],
      ),
    );
  }
}