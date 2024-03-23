import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';






class ServiceTypeContainer extends StatelessWidget {
  const ServiceTypeContainer({super.key, required this.onTap, required this.text});
  final VoidCallback onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 100.h,
        width: double.infinity,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColor.bgColor,
          borderRadius: BorderRadius.circular(10.r),
          //borderRadius: ,
          boxShadow: [
            BoxShadow(
              color: Colors.grey, //.withOpacity(0.4), 
              spreadRadius: 0.2,
              blurRadius: 0.4
            )
          ]
        ),
        child: Text(
          text,
          style: GoogleFonts.inter(
            color: AppColor.blackColor,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500
          ),
        ),
      ),
    );
  }
}