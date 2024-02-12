import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_viewer/services_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';







class AppointmentTypeBA extends StatefulWidget {
  AppointmentTypeBA({super.key, required this.service_charge_virtual, required this.service_charge_inperson,});
  final String service_charge_virtual;
  final String service_charge_inperson;

  @override
  State<AppointmentTypeBA> createState() => _AppointmentTypeBAState();
}

class _AppointmentTypeBAState extends State<AppointmentTypeBA> {
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
              value: "In-Person", 
              groupValue: controller.step1Appointment, 
              onChanged: (val) {
                setState(() {
                  controller.step1Appointment = val.toString();
                  print(controller.step1Appointment);
                });
              },
            ),
            SizedBox(width: 10.w,),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "In-Person",
                    style: GoogleFonts.inter(
                      color: AppColor.darkGreyColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  Text(
                    "N${widget.service_charge_inperson}",
                    style: GoogleFonts.inter(
                      color: AppColor.blackColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h,),
        //2
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Radio.adaptive(
              activeColor: AppColor.mainColor,
              toggleable: false,
              //tileColor: AppColor.bgColor,
              value: "Virtual", 
              groupValue: controller.step1Appointment, 
              onChanged: (val) {
                setState(() {
                  controller.step1Appointment = val.toString();
                  print(controller.step1Appointment);
                });
              },
            ),
            SizedBox(width: 10.w,),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Virtual",
                    style: GoogleFonts.inter(
                      color: AppColor.darkGreyColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  Text(
                    "N${widget.service_charge_virtual}",
                    style: GoogleFonts.inter(
                      color: AppColor.blackColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}