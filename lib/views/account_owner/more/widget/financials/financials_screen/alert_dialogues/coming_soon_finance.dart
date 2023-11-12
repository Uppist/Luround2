import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';









///Alert Dialog
Future<void> comingSoonDialogue({required BuildContext context,}) async{
  showDialog(
    /*isScrollControlled: true,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 2,
    isDismissible: true,
    backgroundColor: AppColor.bgColor,*/
    barrierDismissible: false,
    useSafeArea: true,
    context: context, 
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15.r)
          )
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
        content: Wrap(
          children: [
            Column(
              //mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Financials',
                  style: GoogleFonts.inter(
                    color: AppColor.blackColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold
                  )
                ),
                SizedBox(height: 30.h,),
                Text(
                  'Generate quotes, invoices and receipts for your clients with just one tap and track your financials seamlessly.\n          (coming soon)',
                  style: GoogleFonts.inter(
                    color: AppColor.darkGreyColor,
                    fontSize: 13.sp,
                    //fontWeight: FontWeight.bold
                  )
                ),
                SizedBox(height: 30.h,),
                InkWell(
                  onTap: () {
                    Get.back(closeOverlays: true);
                  },
                  child: Container(
                    //padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                    alignment: Alignment.center,
                    height: 50.h,
                    //width: double.infinity,
                    decoration: BoxDecoration(
                      color: AppColor.mainColor,
                      borderRadius: BorderRadius.circular(10.r),
                      border: Border.all(
                        color: AppColor.mainColor
                      )
                    ),
                    child: Text(
                      "Okay",
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                          color: AppColor.bgColor,
                          fontSize: 16.sp,
                          //fontWeight: FontWeight.w500
                        )
                      )
                    ),
                  )
                ),
                SizedBox(height: 10.h),
        
              ],
            ),
          ],
        ),
      );
    }
  );
}