import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services/regular_service/regular_service_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';








class RegularServiceModelSelector extends StatefulWidget {
  const RegularServiceModelSelector({super.key,});

  @override
  State<RegularServiceModelSelector> createState() => _RegularServiceModelSelectorState();
}

class _RegularServiceModelSelectorState extends State<RegularServiceModelSelector> {

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
              value: "One-off", 
              groupValue: controller.selectServiceModel.value, 
              onChanged: (val) {
                setState(() {
                  controller.selectServiceModel.value = val.toString();
                  //controller.isradio1.value = true;
                  controller.isOneOff.value = false;
                  print("radio 1: ${controller.selectServiceModel.value}");
                });
              },
            ),  
          
            SizedBox(width: 10.w,),

            Text(
              "One-off",
              style: GoogleFonts.inter(
                color: AppColor.darkGreyColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400
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
              value: "Retainer", 
              groupValue: controller.selectServiceModel.value, 
              onChanged: (val) {
                setState(() {
                  controller.selectServiceModel.value = val.toString();
                  //controller.isradio3.value = true;
                  controller.isRetainer.value = false;
                  print("radio 2: ${controller.selectServiceModel.value}");
                });
              },
            ),

            SizedBox(width: 10.w,),

            Text(
              "Retainer",
              style: GoogleFonts.inter(
                color: AppColor.darkGreyColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400
              ),
            ),

          ],
        ),
        SizedBox(height: 5.h,),
      ],
    );
  }
}