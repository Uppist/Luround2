import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';





//DATE RANGE PICKER
class TimeRangePickerWidget extends StatefulWidget {
  TimeRangePickerWidget({super.key});

  @override
  State<TimeRangePickerWidget> createState() => _TimeRangePickerWidgetState();
}

class _TimeRangePickerWidgetState extends State<TimeRangePickerWidget> {
  
  var controller = Get.put(ServicesController());

  

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        controller.showRangeCalendar(context: context);
        //showRangeCalendar(context: context);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 50.w),
        child: Container(
          color: AppColor.bgColor,
          width: double.infinity,
          //onTap: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //from container
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  height: 40.h,
                  width: 90.w,
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
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
                            controller.startDate(),
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                color: AppColor.textGreyColor,
                                fontSize: 12.sp,
                                //fontWeight: FontWeight.w500
                              )
                            )
                          );
                        }
                      ),
                      SizedBox(width: 5.w,),
                      SvgPicture.asset("assets/svg/calendar_icon.svg")
                    ],
                  ),
                ),
              ),
              SizedBox(width: 10.w,),
    
              Text(
                "-",
                style: GoogleFonts.inter(
                  textStyle: TextStyle(
                    color: AppColor.textGreyColor,
                    fontSize: 14.sp,
                    //fontWeight: FontWeight.w500
                  )
                )
              ),

              SizedBox(width: 10.w,),
              //to container
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  height: 40.h,
                  width: 90.w,
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
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
                            controller.endDate(),
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                color: AppColor.textGreyColor,
                                fontSize: 12.sp,
                                //fontWeight: FontWeight.w500
                              )
                            )
                          );
                        }
                      ),
                      SizedBox(width: 5.w,),
                      SvgPicture.asset("assets/svg/calendar_icon.svg")
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}