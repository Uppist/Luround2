import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';





class ThirdPage extends StatelessWidget {
  const ThirdPage({super.key});

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
            'assets/images/onb_3.png',
            //height: 400,
            //width: 450,
          ),
          SizedBox(height: 60.h,),
          Text(
            'Accept payments in dollars, pounds, euro, naira and more...',
            style: GoogleFonts.inter(
              color: AppColor.darkGreyColor,
              fontSize: 15.sp,
              fontWeight: FontWeight.w500
            ),
          ),        
        ],
      ),
    );
  }
}