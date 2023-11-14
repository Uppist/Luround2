import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../utils/colors/app_theme.dart';




class AddSectionButton extends StatelessWidget {
  AddSectionButton({super.key, required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        //padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        alignment: Alignment.center,
        height: 50.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColor.bgColor,
          borderRadius: BorderRadius.circular(40.r),
          border: Border.all(
            color: AppColor.darkGreyColor
          )
        ),
        child: Text(
          'Add Section',
          style: GoogleFonts.inter(
            textStyle: TextStyle(
              color: AppColor.darkGreyColor,
              fontSize: 17.sp,
              //fontWeight: FontWeight.w500
            )
          )
        ),
      )
    );
  }
}