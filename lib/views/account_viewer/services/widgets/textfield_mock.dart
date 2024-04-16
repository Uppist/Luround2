import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';







class MockTextfield extends StatelessWidget {

  const MockTextfield({super.key, required this.text,});
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                text,
                style: GoogleFonts.inter(
                  color: AppColor.blackColor, //darkGreyColor
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400
                ),
              ),
            ],
          ),
          SizedBox(height: 5.h,),
          Divider(thickness: 0.8, color: AppColor.blackColor,)
        ],
      ),
    );
  }
}


