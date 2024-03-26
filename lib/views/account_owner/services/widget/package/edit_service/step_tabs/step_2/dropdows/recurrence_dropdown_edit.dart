import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services/package_service/package_service_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';








class PackageServiceRecurrenceEdit extends StatelessWidget {
  PackageServiceRecurrenceEdit({super.key});

  var controller = Get.put(PackageServiceController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return DropdownButtonFormField<String>(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(        
            border: const OutlineInputBorder(
              borderSide: BorderSide.none, // Remove the border
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColor.textGreyColor), // Set the color you prefer
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: AppColor.blackColor), // Set the color you prefer
            ),     
            hintText: "Tap to select",
            hintStyle: GoogleFonts.inter(color: AppColor.textGreyColor, fontSize: 14.sp, fontWeight: FontWeight.w400),              
          ),
          icon: Icon(
            CupertinoIcons.chevron_down,
            color: AppColor.blackColor,
            size: 24.r,
          ),
          iconDisabledColor: AppColor.textGreyColor,
          iconEnabledColor: AppColor.blackColor,
          dropdownColor: AppColor.bgColor,
          borderRadius: BorderRadius.circular(10.r),
          value: controller.serviceRecurrenceEdit.value,
          onChanged: (String? newValue) {
            controller.serviceRecurrenceEdit.value = newValue!;
            debugPrint("selected recurrence: ${controller.serviceRecurrenceEdit.value}");
          },
          style: GoogleFonts.inter(
            color: AppColor.blackColor, //textGreyColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
            
          //dropdown menu item padding
          //padding: EdgeInsets.symmetric(horizontal: 20.w),
          items: controller.listOfServiceRecurrenceEdit
            .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: GoogleFonts.inter(
                    color: AppColor.darkGreyColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              );
            }
          ).toList(),
        );
      }
    );
  }
}