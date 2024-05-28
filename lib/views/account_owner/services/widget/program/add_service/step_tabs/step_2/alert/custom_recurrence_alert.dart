import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services/program_service/program_service_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/reusable_custom_textfield.dart';






Future<void> customRecurenceAlert({
  //required int index,
  required RxString selectedValue,
  required ProgramServiceController controller,
}) async {
  await Get.dialog(
    transitionCurve: const ElasticOutCurve(),
    useSafeArea: true,
    barrierDismissible: false,
    AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20.r),
        ),
      ),
      backgroundColor: AppColor.bgColor,
      //elevation: 2,
      //contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0.h),
      //wrap
      content: Wrap(
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.h),
            /*decoration: BoxDecoration(
              color: AppColor.blackColor,
              borderRadius: BorderRadius.all(
                Radius.circular(20.r),
              ),
            ),*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Set Recurrence",
                  style: GoogleFonts.inter(
                    color: AppColor.blackColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),

                SizedBox(height: 20.h,),
                
                ReusableTextField(  
                  onChanged: (val) {
                    controller.customServiceRecurenceController.text = val;
                  },
                  hintText: "Type it here",
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  textController: controller.customServiceRecurenceController
                ),

                SizedBox(height: 40.h,),

                //BUTTONS
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          //padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8),
                          alignment: Alignment.center,
                          height: 50.h,
                          //width: 150.w,
                          decoration: BoxDecoration(
                            color: AppColor.bgColor,
                            borderRadius: BorderRadius.circular(15.r),
                            border: Border.all(
                              color: AppColor.textGreyColor,
                              width: 2.0,
                            )
                          ),
                          child: Text(
                            "Cancel",
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                color: AppColor.textGreyColor,
                                fontSize: 16.sp,
                                //fontWeight: FontWeight.w500
                              )
                            )
                          ),
                        )
                      ),
                    ),
                    SizedBox(width: 60.w,),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          selectedValue.value = controller.customServiceRecurenceController.text;
                          if(controller.customServiceRecurenceController.text.isNotEmpty){
                            controller.listOfServiceRecurrence.add(selectedValue.value);
                            controller.customServiceRecurenceController.clear();
                            log("${controller.listOfServiceRecurrence}"); 
                          }
                          else{
                            //set the selected val back to custom
                            selectedValue.value = "Custom";
                          }

                          Get.back();
                        },
                        child: Container(
                          //padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          alignment: Alignment.center,
                          height: 50.h,
                          width: 150.w,
                          decoration: BoxDecoration(
                            color: AppColor.mainColor,
                            borderRadius: BorderRadius.circular(15.r),
                            border: Border.all(
                              color: AppColor.mainColor,
                              width: 2.0,
                            )
                          ),
                          child: Text(
                            "Confirm",
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
                    ),
                  ],
                ),


              ],
            ),
          ),
  
        ],
      ),
    ),
  );
}







Future<void> customRecurenceAlertEdit({
  //required int index,
  required RxString selectedValue,
  required ProgramServiceController controller,
}) async {
  await Get.dialog(
    transitionCurve: const ElasticOutCurve(),
    useSafeArea: true,
    barrierDismissible: false,
    AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20.r),
        ),
      ),
      backgroundColor: AppColor.bgColor,
      //elevation: 2,
      //contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0.h),
      //wrap
      content: Wrap(
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.h),
            /*decoration: BoxDecoration(
              color: AppColor.blackColor,
              borderRadius: BorderRadius.all(
                Radius.circular(20.r),
              ),
            ),*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Set Recurrence",
                  style: GoogleFonts.inter(
                    color: AppColor.blackColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),

                SizedBox(height: 20.h,),
                
                ReusableTextField(  
                  onChanged: (val) {
                    controller.customServiceRecurenceControllerEdit.text = val;
                  },
                  hintText: "Type it here",
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  textController: controller.customServiceRecurenceControllerEdit
                ),

                SizedBox(height: 40.h,),

                //BUTTONS
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          //padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8),
                          alignment: Alignment.center,
                          height: 50.h,
                          //width: 150.w,
                          decoration: BoxDecoration(
                            color: AppColor.bgColor,
                            borderRadius: BorderRadius.circular(15.r),
                            border: Border.all(
                              color: AppColor.textGreyColor,
                              width: 2.0,
                            )
                          ),
                          child: Text(
                            "Cancel",
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                color: AppColor.textGreyColor,
                                fontSize: 16.sp,
                                //fontWeight: FontWeight.w500
                              )
                            )
                          ),
                        )
                      ),
                    ),
                    SizedBox(width: 60.w,),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          selectedValue.value = controller.customServiceRecurenceControllerEdit.text;
                          if(controller.customServiceRecurenceControllerEdit.text.isNotEmpty){
                            controller.listOfServiceRecurrenceEdit.add(selectedValue.value);
                            controller.customServiceRecurenceControllerEdit.clear();
                            log("${controller.listOfServiceRecurrenceEdit}"); 
                          }
                          else{
                            //set the selected val back to custom
                            selectedValue.value = "Custom";
                          }

                          Get.back();
                        },
                        child: Container(
                          //padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          alignment: Alignment.center,
                          height: 50.h,
                          width: 150.w,
                          decoration: BoxDecoration(
                            color: AppColor.mainColor,
                            borderRadius: BorderRadius.circular(15.r),
                            border: Border.all(
                              color: AppColor.mainColor,
                              width: 2.0,
                            )
                          ),
                          child: Text(
                            "Confirm",
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
                    ),
                  ],
                ),


              ],
            ),
          ),
  
        ],
      ),
    ),
  );
}