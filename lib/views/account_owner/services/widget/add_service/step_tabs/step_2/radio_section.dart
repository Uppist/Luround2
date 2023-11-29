import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services_controller.dart';
import 'package:luround/controllers/account_viewer/services_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/views/account_owner/services/widget/add_service/step_tabs/step_2/range_widget.dart';







class ScheduleRadioWidget extends StatefulWidget {
  ScheduleRadioWidget ({super.key,});

  @override
  State<ScheduleRadioWidget > createState() => _ScheduleRadioWidgetState();
}

class _ScheduleRadioWidgetState extends State<ScheduleRadioWidget > {

  var controller = Get.put(ServicesController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //1
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Radio.adaptive(
              activeColor: AppColor.mainColor,
              toggleable: false,
              value: "Future timeframe", 
              groupValue: controller.selectDurationRadio, 
              onChanged: (val) {
                setState(() {
                  controller.selectDurationRadio = val.toString();
                  //controller.isradio1.value = true;
                  controller.isradio2.value = false;
                  print("radio 1: ${controller.selectDurationRadio}");
                });
              },
            ),
            SizedBox(width: 10.w,),
            Text(
              "Future booking timeframe",
              style: GoogleFonts.inter(
                color: AppColor.blackColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500
              ),
            ),
          ],
        ),
        //SizedBox(height: 5.h,),
        //
        SizedBox(height: 5,),
        //2
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Radio.adaptive(
              activeColor: AppColor.mainColor,
              toggleable: false,
              //tileColor: AppColor.bgColor,
              value: "${controller.startDate()} - ${controller.endDate()}", //"Date range timeframe", 
              groupValue: controller.selectDurationRadio, 
              onChanged: (val) {
                setState(() {
                  controller.selectDurationRadio = val.toString();
                  controller.isradio2.value = true;
                  print("radio 2: ${controller.selectDurationRadio}");
                });
              },
            ),
            SizedBox(width: 10.w,),
            Text(
              "Within a date range",
              style: GoogleFonts.inter(
                color: AppColor.blackColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500
              ),
            ),
          ],
        ),
        SizedBox(height: 5.h,),
        
        controller.isradio2.value ? 
        TimeRangePickerWidget() : SizedBox(),

        SizedBox(height: 5.h,),
        //3
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Radio.adaptive(
              activeColor: AppColor.mainColor,
              toggleable: false,
              //tileColor: AppColor.bgColor,
              value: "Indefinitely to the future timeframe", 
              groupValue: controller.selectDurationRadio, 
              onChanged: (val) {
                setState(() {
                  controller.selectDurationRadio = val.toString();
                  //controller.isradio3.value = true;
                  controller.isradio2.value = false;
                  print("radio 3: ${controller.selectDurationRadio}");
                });
              },
            ),
            SizedBox(width: 10.w,),
            Text(
              "Indefinitely to the future timeframe",
              style: GoogleFonts.inter(
                color: AppColor.blackColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500
              ),
            ),
          ],
        ),
        SizedBox(height: 5.h,),
        //
        //SizedBox(height: 5,),
      ],
    );
  }
}