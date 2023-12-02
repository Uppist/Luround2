import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';








///Alert Dialog
Future<void> deleteBookingsDialogueBox({required BuildContext context, required VoidCallback onDelete, required String titleText}) async{
  showModalBottomSheet(
    isScrollControlled: true,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 2,
    isDismissible: true,
    useSafeArea: true,
    backgroundColor: AppColor.bgColor,
    //barrierColor: Theme.of(context).colorScheme.background,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(15)
      )
    ),
    context: context, 
    builder: (context) {
      return Wrap(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
            decoration: BoxDecoration(
              //image: DecorationImage(image: AssetImage(''),),
              color: AppColor.bgColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
              ),
            ),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Delete "${titleText}"',
                  style: GoogleFonts.poppins(
                    color: AppColor.blackColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold
                  )
                ),
                SizedBox(height: 40.h,),
                Text(
                  'Are you sure you want to delete this booking ?',
                  style: GoogleFonts.poppins(
                    color: AppColor.darkGreyColor,
                    fontSize: 14.sp,
                    //fontWeight: FontWeight.bold
                  )
                ),
                SizedBox(height: 40.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //cancel button
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          //padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                          alignment: Alignment.center,
                          height: 50.h,
                          //width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColor.bgColor,
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(
                              color: AppColor.darkGreyColor
                            )
                          ),
                          child: Text(
                            "Cancel",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                color: AppColor.darkGreyColor,
                                fontSize: 16.sp,
                                //fontWeight: FontWeight.w500
                              )
                            )
                          ),
                        )
                      ),
                    ),
                    SizedBox(width: 30.w,),
                    //Yes button
                    Expanded(
                      child: InkWell(
                        onTap: onDelete,
                        child: Container(
                          //padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                          alignment: Alignment.center,
                          height: 50.h,
                          //width: double.infinity,
                          decoration: BoxDecoration(
                            color: AppColor.redColor,
                            borderRadius: BorderRadius.circular(10.r),
                            border: Border.all(
                              color: AppColor.redColor
                            )
                          ),
                          child: Text(
                            "Delete",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                color: AppColor.bgColor,
                                fontSize: 16.sp,
                                //fontWeight: FontWeight.w500
                              )
                            )
                          ),
                        )
                      ),
                    )
                  ],
                ),
                //SizedBox(height: 10,),
              ],
            ),
          ),
        ],
      );
    }
  );
}