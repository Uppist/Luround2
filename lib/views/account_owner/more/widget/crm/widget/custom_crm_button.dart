import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';



class CRMSendButton extends StatelessWidget {
  const CRMSendButton({super.key, required this.text, required this.onPressed});
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onPressed,
        child: Container(
          alignment: Alignment.center,
          height: 40.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
              color: AppColor.textGreyColor
            ),
            color: AppColor.bgColor
          ),
          child: Text(
            text,
            style: GoogleFonts.inter(
              color: AppColor.textGreyColor,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400
            ),
          )
        ),
      ),
    );
  }
}