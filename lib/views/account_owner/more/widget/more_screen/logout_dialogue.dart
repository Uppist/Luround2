import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';









///Alert Dialog
Future<void> logoutDialogue({required BuildContext context,}) async{
  showDialog(
    /*isScrollControlled: true,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 2,
    isDismissible: true,
    backgroundColor: AppColor.bgColor,*/
    //barrierColor: Theme.of(context).colorScheme.background,
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
        contentPadding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 30.h),
        content: Wrap(
          children: [
            Column(
              //mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Logout',
                  style: GoogleFonts.poppins(
                    color: AppColor.blackColor,
                    fontSize: 17.sp,
                    fontWeight: FontWeight.bold
                  )
                ),
                SizedBox(height: 30.h,),
                Text(
                  'Are you sure you want to logout?',
                  style: GoogleFonts.inter(
                    color: AppColor.darkGreyColor,
                    fontSize: 15.sp,
                    //fontWeight: FontWeight.bold
                  )
                ),
                SizedBox(height: 40.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          //padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                          alignment: Alignment.center,
                          height: 50.h,
                          //width: double.infinity,
                          width: 200.w,
                          decoration: BoxDecoration(
                            color: AppColor.mainColor,
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(
                              color: AppColor.mainColor
                            )
                          ),
                          child: Text(
                            "Logout",
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                color: AppColor.bgColor,
                                fontSize: 17.sp,
                                //fontWeight: FontWeight.w500
                              )
                            )
                          ),
                        )
                      ),
                    ),
                    SizedBox(width: 20.w,),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Get.back(closeOverlays: true);
                        },
                        child: Container(
                          //padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                          alignment: Alignment.center,
                          height: 50.h,
                          width: 200.w,
                          //width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColor.bgColor,
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(
                              color: AppColor.textGreyColor
                            )
                          ),
                          child: Text(
                            "Cancel",
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                color: AppColor.textGreyColor,
                                fontSize: 17.sp,
                                //fontWeight: FontWeight.w500
                              )
                            )
                          ),
                        )
                      ),
                    ),
                  ],
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