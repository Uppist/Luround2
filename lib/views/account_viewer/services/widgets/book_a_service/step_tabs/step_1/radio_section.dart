import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_viewer/services_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';







class AppointmentTypeBA extends StatefulWidget {
  AppointmentTypeBA({super.key,});

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
              value: "In-person", 
              groupValue: controller.step1Appointment, 
              onChanged: (val) {
                setState(() {
                  controller.step1Appointment = val.toString();
                  print(controller.step1Appointment);
                });
              },
            ),
            SizedBox(width: 10,),
            Text(
              "In-person",
              style: GoogleFonts.inter(
                color: AppColor.darkGreyColor,
                fontSize: 16,
                fontWeight: FontWeight.w500
              ),
            ),
          ],
        ),
        SizedBox(height: 5,),
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
            SizedBox(width: 10,),
            Text(
              "Virtual",
              style: GoogleFonts.inter(
                color: AppColor.darkGreyColor,
                fontSize: 16,
                fontWeight: FontWeight.w500
              ),
            ),
          ],
        ),
      ],
    );
  }
}