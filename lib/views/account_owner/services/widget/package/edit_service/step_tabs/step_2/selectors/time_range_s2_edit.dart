import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services/package_service/package_service_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';











class TimeRangeSelectorForStep2Edit extends StatefulWidget {
  TimeRangeSelectorForStep2Edit({super.key});

  @override
  State<TimeRangeSelectorForStep2Edit> createState() => _TimeRangeSelectorForStep2EditState();
}

class _TimeRangeSelectorForStep2EditState extends State<TimeRangeSelectorForStep2Edit> {
  
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
        controller.startTimeValueEdit.value = time.format(context);
        print(controller.startTimeValueEdit.value);
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
        controller.stopTimeValueEdit.value = time.format(context);
        print(controller.stopTimeValueEdit.value);
      });
      controller.calculateDuration(startTime: controller.startTimeValueEdit.value, endTime: controller.stopTimeValueEdit.value);
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
                  controller.startTimeValueEdit.value.isNotEmpty ? controller.startTimeValueEdit.value : "from",
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
                  controller.stopTimeValueEdit.value.isNotEmpty ? controller.stopTimeValueEdit.value : "to",
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