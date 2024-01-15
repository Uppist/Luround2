import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';




class UploadReceiptWidget extends StatelessWidget {
  UploadReceiptWidget({super.key, required this.onPressed});
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
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              CupertinoIcons.cloud_upload,
              color: AppColor.darkGreyColor,
            ),
            InkWell(
              onTap: onPressed,
              child: Container(
                alignment: Alignment.center,
                //padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                height: 40.h,
                width: 130.w,
                decoration: BoxDecoration(
                  color: AppColor.mainColor,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Text(
                  "Upload receipt",
                  style: GoogleFonts.inter(
                    color: AppColor.bgColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400
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



class UploadedReceiptWidget extends StatelessWidget {
  UploadedReceiptWidget({super.key, required this.onDelete, required this.file});
  final VoidCallback onDelete;
  final File? file;

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      borderType: BorderType.Rect, //RrRct
      radius: Radius.circular(50.r),
      dashPattern: [6, 6],
      color: AppColor.mainColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            color: AppColor.lightMainColor,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  CupertinoIcons.cloud_upload,
                  color: AppColor.darkGreyColor,
                ),
                SizedBox(width: 10.w,),
                Text(
                  "file uploaded",
                  style: GoogleFonts.inter(
                    color: AppColor.blackColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400
                  ),
                ),
              
              ],
            ),
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
        ],
      )
    );
  }
}