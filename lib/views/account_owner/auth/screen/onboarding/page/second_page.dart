import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';





class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

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
            'assets/images/onb_2.png',
            //height: 400,
            //width: 450,
          ),
          SizedBox(height: 60.h,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Text(
              'Organize your schedule and get\nbooked based on your availability.',
              style: GoogleFonts.inter(
                color: AppColor.darkGreyColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500
              ),
            ),
          ),        
        ],
      ),
    );
  }
}