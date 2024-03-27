import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services/program_service/program_service_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import 'package:luround/views/account_owner/services/widget/program/edit_service/step_tabs/step_2/dropdows/recurrence_dropdown_edit.dart';
import 'package:luround/views/account_owner/services/widget/program/edit_service/step_tabs/step_2/dropdows/timeline_dropdown_edit.dart';
import 'package:luround/views/account_owner/services/widget/program/edit_service/step_tabs/step_2/selectors/date_range_bottomsheet_edit.dart';
import 'package:luround/views/account_owner/services/widget/program/edit_service/step_tabs/step_2/selectors/time_range_s2_edit.dart';











class Step2PageProgramServiceEdit  extends StatefulWidget {
  const Step2PageProgramServiceEdit({super.key, required this.onNext});
  final VoidCallback onNext;

  @override
  State<Step2PageProgramServiceEdit> createState() => _Step2PageProgramServiceEditState();
}

class _Step2PageProgramServiceEditState extends State<Step2PageProgramServiceEdit> {
  
  final controller = Get.put(ProgramServiceController());
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Service timeline",
          style: GoogleFonts.inter(
            color: AppColor.blackColor,
            fontSize: 15.sp,
            fontWeight: FontWeight.w500
          ),
        ),
        //SizedBox(height: 20.h),
        ProgramServiceTimelineEdit(),

        SizedBox(height: 30.h,),
        Text(
          "Select date range",
          style: GoogleFonts.inter(
            color: AppColor.blackColor,
            fontSize: 15.sp,
            fontWeight: FontWeight.w500
          ),
        ),
        SizedBox(height: 20.h),
        InkWell(
          onTap: () async{
            selectDateRangeBottomSheetEdit(
              context: context, 
              onCancel: () {
                Get.back();
              }, 
              onApply: () {
                Get.back();
              }
            );      
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
            alignment: Alignment.centerLeft,
            height: 50.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColor.bgColor,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(
                color: AppColor.textGreyColor,
                width: 1.0, //2
              )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                  () {
                    return Text(
                      "${controller.startDateEdit()} - ${controller.endDateEdit()}",
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                          color: AppColor.textGreyColor,
                          fontSize: 16.sp,
                          //fontWeight: FontWeight.w500
                        )
                      )
                    );
                  }
                ),
                Icon(
                  CupertinoIcons.calendar_today,
                  color: AppColor.textGreyColor,
                ),
              ],
            ),
          )
        ),

        SizedBox(height: 30.h,),
        Text(
          "Service recurrence",
          style: GoogleFonts.inter(
            color: AppColor.blackColor,
            fontSize: 15.sp,
            fontWeight: FontWeight.w500
          ),
        ),
        //SizedBox(height: 20.h),
        ProgramServiceRecurrenceEdit(),

        SizedBox(height: 30.h),
        Text(
          "Select time interval",
          style: GoogleFonts.inter(
            color: AppColor.blackColor,
            fontSize: 15.sp,
            fontWeight: FontWeight.w500
          ),
        ),
        SizedBox(height: 20.h),
        const TimeRangeSelectorForStep2Edit(),

        SizedBox(height: 30.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  CupertinoIcons.clock,
                  color: AppColor.blackColor,
                  size: 22.r,
                ),
                SizedBox(width: 5.w,),
                Text(
                  "Duration",
                  style: GoogleFonts.inter(
                    color: AppColor.blackColor,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500
                  ),
                ),
              ],
            ),

            Obx(
              () {
                return Text(
                  controller.calcDurationEdit.value,
                  style: GoogleFonts.inter(
                    color: AppColor.darkGreyColor,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400
                  ),
                );
              }
            ),
          ],
        ),



        /*Text(
          "Service duration",
          style: GoogleFonts.inter(
            color: AppColor.blackColor,
            fontSize: 15.sp,
            fontWeight: FontWeight.w500
          ),
        ),
        SizedBox(height: 20.h),
        InkWell(
          onTap: () async{
            controller.showDurationPickerDialogEdit(context: context);         
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
            alignment: Alignment.centerLeft,
            height: 50.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColor.bgColor,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(
                color: AppColor.textGreyColor,
                width: 1.0, //2
              )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                  () {
                    return Text(
                      "${controller.durationEdit.value}".substring(0, 7),
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                          color: AppColor.textGreyColor,
                          fontSize: 16.sp,
                          //fontWeight: FontWeight.w500
                        )
                      )
                    );
                  }
                ),
                Icon(
                  CupertinoIcons.time,
                  color: AppColor.textGreyColor,
                ),
              ],
            ),
          )
        ),*/
        
    
        
        
        SizedBox(height: 180.h,), //280.h
    
        RebrandedReusableButton(
          textColor: AppColor.bgColor,
          color: AppColor.mainColor, 
          text: "Next", 
          onPressed: widget.onNext,
        ),
        SizedBox(height: 10.h,),
    
    
      ]
    );
  }
}


  