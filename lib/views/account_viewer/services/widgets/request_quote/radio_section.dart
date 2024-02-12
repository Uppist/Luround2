import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_viewer/services_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';







class AppointmentType extends StatefulWidget {
  AppointmentType({super.key, required this.service_charge_virtual, required this.service_charge_inperson,});
  final String service_charge_virtual;
  final String service_charge_inperson;

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
              value: "In-Person", 
              groupValue: controller.apppointment, 
              onChanged: (val) {
                setState(() {
                  controller.apppointment = val.toString();
                  print(controller.apppointment);
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
              groupValue: controller.apppointment, 
              onChanged: (val) {
                setState(() {
                  controller.apppointment = val.toString();
                  print(controller.apppointment);
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