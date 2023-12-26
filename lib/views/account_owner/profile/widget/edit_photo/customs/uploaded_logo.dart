import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';






class UploadedLogoWidget extends StatelessWidget {
  UploadedLogoWidget({super.key, required this.onDelete, required this.file});
  final VoidCallback onDelete;
  final File file;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.center,
          height: 60.h,
          width: 60.w,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: FileImage(
                /*errorBuilder: (context, url, error) => Icon(
                  Icons.error,
                  color: swapSpaceLightGreenColor,
                ),*/
                file
                //filterQuality: FilterQuality.high
                //fit: BoxFit.cover, //.contain,                                
              ),
              fit: BoxFit.cover
            )
          ),
        ),
        SizedBox(width: 20.w),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Uploaded logo",
                    style: GoogleFonts.inter(
                      color: AppColor.blackColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  SizedBox(height: 5.h,),
                  Text(
                    "img",
                    style: GoogleFonts.inter(
                      color: Colors.grey.withOpacity(0.6),
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400
                    ),
                  ),
                ],
              ),
              
              TextButton(
                onPressed: onDelete, 
                child: Text(
                  "Delete",
                  style: GoogleFonts.inter(
                    color: AppColor.redColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColor.redColor
                  ),
              
                ),
              )
            ]
          ),
        ),
      ],      
    );
  }
}