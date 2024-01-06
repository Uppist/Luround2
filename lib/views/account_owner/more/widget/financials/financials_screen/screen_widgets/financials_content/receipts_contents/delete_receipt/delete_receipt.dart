import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/services/account_owner/more/financials/financials_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/loader.dart';





///Alert Dialog
Future<void> deleteReceiptsBottomSheet({
  required BuildContext context, 
  required VoidCallback onDelete, 
  required FinancialsService service
  }) async{
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
      return Container(
        //height: 60.h,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
        width: double.infinity,
        color: AppColor.bgColor,
        child: Builder(
          builder:(context) {
            return 
            /*service.isLoading.value 
            ?SizedBox(
              height: 40.h,
              width: 40.h,
              child: Loader(),
            ):*/
            Wrap(  
              children: [
                Column(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /*Text(
                      'Logout',
                      style: GoogleFonts.poppins(
                        color: AppColor.blackColor,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600
                      )
                    ),
                    SizedBox(height: 30.h,),*/
                    Text(
                      'Are you sure you want to delete?',
                      style: GoogleFonts.inter(
                        color: AppColor.darkGreyColor,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 40.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500
                                  )
                                )
                              ),
                            )
                          ),
                        ),
                        
                        SizedBox(width: 20.w,),

                        Expanded(
                          child: InkWell(
                            onTap: onDelete,
                            child: Container(
                              //padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                              alignment: Alignment.center,
                              height: 50.h,
                              //width: double.infinity,
                              width: 200.w,
                              decoration: BoxDecoration(
                                color: AppColor.redColor,
                                borderRadius: BorderRadius.circular(10.r),
                                border: Border.all(
                                  color: AppColor.redColor
                                )
                              ),
                              child: Text(
                                "Delete",
                                style: GoogleFonts.inter(
                                  textStyle: TextStyle(
                                    color: AppColor.bgColor,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500
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
            );
          }
        ),
      );
    }
  );
}