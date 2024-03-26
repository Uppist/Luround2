import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services/package_service/package_service_controller.dart';
import 'package:luround/controllers/account_owner/services/regular_service/regular_service_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';











class TimeRangeSelector extends StatefulWidget {
  TimeRangeSelector({super.key, required this.index});
  final int index;

  @override
  State<TimeRangeSelector> createState() => _TimeRangeSelectorState();
}

class _TimeRangeSelectorState extends State<TimeRangeSelector> {
  
  var controller = Get.put(ServicesController());
  

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
        controller.daysOfTheWeekCheckBox[index].addAll({
          "from" : controller.startTimeValue.value,
        });
        //controller.addStartTime();
        controller.addFirstTime();
        print("time list: ${controller.availableTime}");
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
        controller.daysOfTheWeekCheckBox[index].addAll({
          "to" : controller.stopTimeValue.value,
        });
        controller.addLastTime();
      });
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.bgColor,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 20.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //from container      
          InkWell(
            onTap: () {
              openFlutterTimePickerForStartTime(context: context, index: widget.index);
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
                    controller.daysOfTheWeekCheckBox[widget.index]['from'] ?? "from", //"${controller.startTime.value}: ${controller.startMinute.value}",
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
              openFlutterTimePickerForStopTime(context: context, index: widget.index);
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
                    controller.daysOfTheWeekCheckBox[widget.index]['to'] ?? "to", //"${controller.endTime.value}: ${controller.endMinute.value}",
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
          SizedBox(width: 5.w,),

          //delete icon
          Expanded(
            child: IconButton(
              onPressed: () {
                setState(() {
                  controller.daysOfTheWeekCheckBox[widget.index]["isChecked"] = false;
                  controller.daysOfTheWeekCheckBox[widget.index]['to'] = "to";
                  controller.daysOfTheWeekCheckBox[widget.index]['from'] = "from";
                  //controller.removeStartTime(index: widget.index);
                  controller.removeTime(index: widget.index);
                });
                print("time list: ${controller.availableTime}");
                print(controller.daysOfTheWeekCheckBox[widget.index]["isChecked"]);
              }, 
              icon: Icon(Icons.delete_outline_rounded),
              color: AppColor.textGreyColor,
              enableFeedback: true,
            ),
          )
        ],
      )     
    );
  }
}