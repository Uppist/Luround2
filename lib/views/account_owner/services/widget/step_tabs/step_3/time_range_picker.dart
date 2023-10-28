import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:from_to_time_picker/from_to_time_picker.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';






class TimeRangeSelector extends StatefulWidget {
  TimeRangeSelector({super.key});

  @override
  State<TimeRangeSelector> createState() => _TimeRangeSelectorState();
}

class _TimeRangeSelectorState extends State<TimeRangeSelector> {
  
  var controller = Get.put(ServicesController());

  Future<void> showLightTimePicker({required BuildContext context}) async{
    showDialog(
      context: context,
        builder: (_) => FromToTimePicker(
          /*dialogBackgroundColor: Color(0xFF121212),
          fromHeadlineColor: Colors.white,
          toHeadlineColor: Colors.white,
          upIconColor: Colors.white,
          downIconColor: Colors.white,
          timeBoxColor: Color(0xFF1E1E1E),
          timeHintColor: Colors.grey,
          timeTextColor: Colors.white,
          dividerColor: Color(0xFF121212),
          doneTextColor: Colors.white,
          dismissTextColor: Colors.white,
          defaultDayNightColor: Color(0xFF1E1E1E),
          defaultDayNightTextColor: Colors.white,
          colonColor: Colors.white,*/
          doneTextColor: AppColor.mainColor,
          dismissTextColor: AppColor.mainColor,
          showHeaderBullet: true,
          onTab: (from, to) {
            //POST REQUEST GO RUN THINGS FROM HERE
            print('from $from to $to');
            setState(() {
              //hour
              controller.startTime.value = from.hour.toString();
              controller.endTime.value = to.hour.toString();
              //minute
              controller.startMinute.value = from.minute.toString();
              controller.endMinute.value = to.minute.toString();
            });
            print('from cv ${controller.startTime.value} to cv ${controller.endTime.value}');
        },
      )
    );
  }

  
  

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showLightTimePicker(context: context);
      },
      child: Container(
        //padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          color: AppColor.bgColor,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //from container
              Container(
                alignment: Alignment.center,
                height: 40,
                //width: 80,
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColor.bgColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: AppColor.textGreyColor,
                    width: 1.0, //2
                  )
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${controller.startTime.value}: ${controller.startMinute.value}",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: AppColor.textGreyColor,
                          fontSize: 16,
                          //fontWeight: FontWeight.w500
                        )
                      )
                    ),
                    SizedBox(width: 20,),
                    Icon(
                      CupertinoIcons.time,
                      color: AppColor.textGreyColor,
                    )
                  ],
                ),
              ),
    
              Text(
                "-",
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    color: AppColor.textGreyColor,
                    fontSize: 16,
                    //fontWeight: FontWeight.w500
                  )
                )
              ),
    
              //to container
              Container(
                alignment: Alignment.center,
                height: 40,
                //width: 80,
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColor.bgColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: AppColor.textGreyColor,
                    width: 1.0, //2
                  )
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${controller.endTime.value}: ${controller.endMinute.value}",
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: AppColor.textGreyColor,
                          fontSize: 16,
                          //fontWeight: FontWeight.w500
                        )
                      )
                    ),
                    SizedBox(width: 20,),
                    Icon(
                      CupertinoIcons.time,
                      color: AppColor.textGreyColor,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}