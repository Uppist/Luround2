import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_viewer/services_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';







class AppointmentType extends StatefulWidget {
  AppointmentType({super.key,});

  @override
  State<AppointmentType> createState() => _AppointmentTypeState();
}

class _AppointmentTypeState extends State<AppointmentType> {
  var controller = Get.put(AccViewerServicesController());
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
              //tileColor: AppColor.bgColor,
              value: "In-person", 
              groupValue: controller.apppointment, 
              onChanged: (val) {
                setState(() {
                  controller.apppointment = val.toString();
                  print(controller.apppointment);
                });
              },
            ),
            SizedBox(width: 10.w,),
            Text(
              "In-person",
              style: GoogleFonts.inter(
                color: AppColor.darkGreyColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500
              ),
            ),
          ],
        ),
        SizedBox(height: 5.h,),
        //2
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Radio.adaptive(
              activeColor: AppColor.mainColor,
              toggleable: false,
              //tileColor: AppColor.bgColor,
              value: "Virtual", 
              groupValue: controller.apppointment, 
              onChanged: (val) {
                setState(() {
                  controller.apppointment = val.toString();
                  print(controller.apppointment);
                });
              },
            ),
            SizedBox(width: 10.w,),
            Text(
              "Virtual",
              style: GoogleFonts.inter(
                color: AppColor.darkGreyColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500
              ),
            ),
          ],
        ),
      ],
    );
  }
}