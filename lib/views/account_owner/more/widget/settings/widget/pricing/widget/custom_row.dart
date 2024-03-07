import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';




class PaymentRowText extends StatelessWidget {
  const PaymentRowText({super.key, required this.text});
  final String text;


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Icon(
          Icons.check_circle_rounded,
          size: 24.r,
          color: AppColor.mainColor,
        ),
        SizedBox(width: 10.w,),
        Expanded(
          child: Text(
            text,
            style: GoogleFonts.inter(
              color: AppColor.darkGreyColor,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        )
      ],
    );
  }
}