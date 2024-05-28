import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services/event/event_service_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/date_picker.dart';
import 'package:luround/utils/components/time_picker.dart';







class SingleDateWidget extends StatefulWidget {
  const SingleDateWidget({super.key});

  @override
  State<SingleDateWidget> createState() => _SingleDateWidgetState();
}

class _SingleDateWidgetState extends State<SingleDateWidget> {

  final controller = Get.put(EventsController());


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Select date",
          style: GoogleFonts.inter(
            color: AppColor.blackColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500
          ),
        ),
        SizedBox(height: 30.h),
        InkWell(
          onTap: () {
            selectDate(
              context: context,
              selectedDate: controller.selectedDate
            );
          },
          child: Container(
            alignment: Alignment.center,
            height: 50.h,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
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
                      controller.selectedDate.value,
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                          color: AppColor.textGreyColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400
                        )
                      )
                    );
                  }
                ),
                //SizedBox(width: 5.w,),
                Icon(
                  CupertinoIcons.calendar,
                  size: 24.r,
                  color: AppColor.textGreyColor,
                )
              ],
            )
          ),
        ),

        SizedBox(height: 30.h),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Start time",
              style: GoogleFonts.inter(
                color: AppColor.blackColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500
              ),
            ),
            Text(
              "End time",
              style: GoogleFonts.inter(
                color: AppColor.blackColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500
              ),
            ),
          ],
        ),

        SizedBox(height: 30.h),

        //TIME BOXES
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                selectTime(
                  context,
                  controller.selectedStartTime
                );
              },
              child: Container(
                alignment: Alignment.center,
                height: 50.h,
                width: 115.w,
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
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
                          controller.selectedStartTime.value,
                          style: GoogleFonts.inter(
                            textStyle: TextStyle(
                              color: AppColor.textGreyColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400
                            )
                          )
                        );
                      }
                    ),
                    SizedBox(width: 5.w,),
                    Icon(
                      CupertinoIcons.alarm,
                      size: 24.r,
                      color: AppColor.textGreyColor,
                    )
                  ],
                )
              ),
            ),
            InkWell(
              onTap: () {
                selectTime(
                  context,
                  controller.selectedStopTime
                );
              },
              child: Container(
                alignment: Alignment.center,
                height: 50.h,
                width: 115.w,
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
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
                          controller.selectedStopTime.value,
                          style: GoogleFonts.inter(
                            textStyle: TextStyle(
                              color: AppColor.textGreyColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400
                            )
                          )
                        );
                      }
                    ),
                    SizedBox(width: 5.w,),
                    Icon(
                      CupertinoIcons.alarm,
                      size: 24.r,
                      color: AppColor.textGreyColor,
                    )
                  ],
                )
              ),
            ),
          ],
        ),
      
      ],
    );
  }
}