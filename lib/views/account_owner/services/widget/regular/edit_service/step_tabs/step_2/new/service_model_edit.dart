import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services/regular_service/regular_service_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';








class EditRegularServiceModelSelector extends StatefulWidget {
  const EditRegularServiceModelSelector({super.key,});

  @override
  State<EditRegularServiceModelSelector> createState() => _EditRegularServiceModelSelectorState();
}

class _EditRegularServiceModelSelectorState extends State<EditRegularServiceModelSelector> {

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
              groupValue: controller.selectServiceModelEdit.value, 
              onChanged: (val) {
                setState(() {
                  controller.selectServiceModelEdit.value = val.toString();
                  //controller.isradio1.value = true;
                  controller.isOneOffEdit.value = false;
                  print("radio 1: ${controller.selectServiceModelEdit.value}");
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
        //3
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Radio.adaptive(
              activeColor: AppColor.mainColor,
              toggleable: false,
              //tileColor: AppColor.bgColor,
              value: "Retainer", 
              groupValue: controller.selectServiceModelEdit.value, 
              onChanged: (val) {
                setState(() {
                  controller.selectServiceModelEdit.value = val.toString();
                  //controller.isradio3.value = true;
                  controller.isRetainerEdit.value = false;
                  print("radio 2: ${controller.selectServiceModelEdit.value}");
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