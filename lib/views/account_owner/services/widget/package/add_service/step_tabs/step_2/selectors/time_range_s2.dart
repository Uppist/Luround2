import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services/package_service/package_service_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';











class TimeRangeSelectorForStep2 extends StatefulWidget {
  TimeRangeSelectorForStep2({super.key});

  @override
  State<TimeRangeSelectorForStep2> createState() => _TimeRangeSelectorForStep2State();
}

class _TimeRangeSelectorForStep2State extends State<TimeRangeSelectorForStep2> {
  

  var controller = Get.put(PackageServiceController());

  //t1
  Future<void> openFlutterTimePickerForStartTime({required BuildContext context, required int index}) async{
    var time = await showTimePicker(
      context: context, 
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.input,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false), 
          child: child!
        );
      },
    );

    if (time != null) {
      setState(() {
        controller.startTimeValue.value = time.format(context);
        print(controller.startTimeValue.value);
      });
    }
  }
  
  //t2
  Future<void> openFlutterTimePickerForStopTime({required BuildContext context, required int index}) async{
    var time = await showTimePicker(
      context: context, 
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.input,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false), 
          child: child!
        );
      },
    );

    if (time != null) {
      setState(() {
        controller.stopTimeValue.value = time.format(context);
        print(controller.stopTimeValue.value);
      });
      controller.calculateDuration(startTime: controller.startTimeValue.value, endTime: controller.stopTimeValue.value);
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //from container      
        InkWell(
          onTap: () {
            openFlutterTimePickerForStartTime(context: context, index: 0);
          },
          child: Container(
            alignment: Alignment.center,
            height: 40.h,
            width: 100.w,
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
                Text(
                  controller.startTimeValue.value.isNotEmpty ? controller.startTimeValue.value : "from",
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                      color: AppColor.textGreyColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.normal
                    )
                  )
                )
                
                                 
                /*SizedBox(width: 5.w,),
                Icon(
                  CupertinoIcons.time,
                  color: AppColor.textGreyColor,
                )*/
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
              fontSize: 16.sp,
              //fontWeight: FontWeight.w500
            )
          )
        ),           
        SizedBox(width: 10.w,),
    
        //to container
        InkWell(
          onTap: () {
            openFlutterTimePickerForStopTime(context: context, index: 0);
          },
          child: Container(
            alignment: Alignment.center,
            height: 40.h,
            width: 100.w,
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
                Text(
                  controller.stopTimeValue.value.isNotEmpty ? controller.stopTimeValue.value : "to",
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                    color: AppColor.textGreyColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.normal
                    )
                  )
                ),                                  
                /*SizedBox(width: 5.w,),
                Icon(
                  CupertinoIcons.time,
                  color: AppColor.textGreyColor,
                )*/
              ],
            ),
          ),
        ),
        
      ],
    );
  }
}