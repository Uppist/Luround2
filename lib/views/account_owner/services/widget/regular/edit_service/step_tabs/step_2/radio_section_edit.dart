import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services/regular_service/services_controller.dart';
import 'package:luround/controllers/account_viewer/services_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/views/account_owner/services/widget/regular/add_service/step_tabs/step_2/range_widget.dart';







class EditScheduleRadioWidget extends StatefulWidget {
  EditScheduleRadioWidget ({super.key,});

  @override
  State<EditScheduleRadioWidget > createState() => _EditScheduleRadioWidgetState();
}

class _EditScheduleRadioWidgetState extends State<EditScheduleRadioWidget > {

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
              groupValue: controller.selectDateRangeEdit, 
              onChanged: (val) {
                setState(() {
                  controller.selectDateRangeEdit = val.toString();
                  //controller.isradio1.value = true;
                  controller.isradio2Edit.value = false;
                  print("radio 1: ${controller.selectDateRangeEdit}");
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
              value: "${controller.startDateEdit()} - ${controller.endDateEdit()}", //"Date range timeframe", 
              groupValue: controller.selectDateRangeEdit, 
              onChanged: (val) {
                setState(() {
                  controller.selectDateRangeEdit = val.toString();
                  controller.isradio2Edit.value = true;
                  print("radio 2: ${controller.selectDateRangeEdit}");
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
        
        controller.isradio2Edit.value ? 
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
              groupValue: controller.selectDateRangeEdit, 
              onChanged: (val) {
                setState(() {
                  controller.selectDateRangeEdit = val.toString();
                  //controller.isradio3.value = true;
                  controller.isradio2Edit.value = false;
                  print("radio 3: ${controller.selectDateRangeEdit}");
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