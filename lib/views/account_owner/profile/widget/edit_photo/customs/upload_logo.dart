import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';






class UploadLogoWidget extends StatelessWidget {
  UploadLogoWidget({super.key, required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      borderType: BorderType.Rect, //RrRct
      radius: Radius.circular(50.r),
      dashPattern: [6, 6],
      color: AppColor.mainColor,
      child: Container(
        color: AppColor.lightMainColor,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                "Drag logo here or click the button below",
                style: GoogleFonts.inter(
                  color: AppColor.textGreyColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: 30.h,),
            Center(
              child: InkWell(
                onTap: onPressed,
                child: Container(
                  alignment: Alignment.center,
                  //padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  height: 50.h,
                  width: 150.w,
                  decoration: BoxDecoration(
                    color: AppColor.mainColor,
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  child: Text(
                    "Upload logo",
                    style: GoogleFonts.inter(
                      color: AppColor.bgColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500
                    ),
                  ),
              
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}