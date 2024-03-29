import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services/program_service/program_service_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import 'package:luround/views/account_owner/services/widget/program/add_service/step_tabs/step_2/dropdows/recurrence_dropdown.dart';
import 'package:luround/views/account_owner/services/widget/program/add_service/step_tabs/step_2/dropdows/timeline_dropdown.dart';
import 'package:luround/views/account_owner/services/widget/program/add_service/step_tabs/step_2/selectors/date_range_bottomsheet.dart';
import 'package:luround/views/account_owner/services/widget/program/add_service/step_tabs/step_2/selectors/time_range_s2.dart';











class Step2PageProgramService  extends StatefulWidget {
  const Step2PageProgramService({super.key, required this.onNext});
  final VoidCallback onNext;

  @override
  State<Step2PageProgramService> createState() => _Step2PageProgramServiceState();
}

class _Step2PageProgramServiceState extends State<Step2PageProgramService > {
  
  var controller = Get.put(ProgramServiceController());
  
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
        ProgramServiceTimeline(),

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
            selectDateRangeBottomSheet(
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
                      "${controller.startDate()} - ${controller.endDate()}",
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
        ProgramServiceRecurrence(),

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
        TimeRangeSelectorForStep2(),

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
                  controller.calcDuration.value,
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

        SizedBox(height: 30.h),
        Text(
          "Maximum number of participants",
          style: GoogleFonts.inter(
            color: AppColor.blackColor,
            fontSize: 15.sp,
            fontWeight: FontWeight.w500
          ),
        ),
        SizedBox(height: 20.h),
        Container(
          //padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.h),
          alignment: Alignment.center,
          height: 45.h,
          width: 135.w, //125
          decoration: BoxDecoration(
            color: AppColor.bgColor,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
              color: AppColor.textGreyColor,
              width: 1.0, //2
            )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed:() {
                  controller.decreaseCount();
                }, 
                icon: Icon(
                  CupertinoIcons.minus_circle,
                  color: AppColor.textGreyColor,
                  size: 24.r,
                )
              ),
              //SizedBox(width: 5.w,),
              Obx(
                () {
                  return Text(
                    controller.count.value.toString(),
                    style: GoogleFonts.inter(
                      color: AppColor.textGreyColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400
                    ),
                  );
                }
              ),
              //SizedBox(width: 5.w,),
              IconButton(
                onPressed:() {
                  controller.increaseCount();
                }, 
                icon: Icon(
                  CupertinoIcons.add_circled,
                  color: AppColor.textGreyColor,
                  size: 24.r,
                )
              )
            ],
          )
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
            controller.showDurationPickerDialog(context: context);         
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
                      "${controller.duration.value}".substring(0, 7),
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


  