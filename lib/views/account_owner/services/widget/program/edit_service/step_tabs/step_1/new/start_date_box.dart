import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services/program_service/program_service_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/date_picker.dart';









class StartDateBoxProgramEdit extends StatelessWidget {
  StartDateBoxProgramEdit({super.key});

  final controller = Get.put(ProgramServiceController());

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        selectDate(
          context: context, 
          selectedDate: controller.selectedStartDateEdit
        );
      },
      child: Container(
        alignment: Alignment.center,
        height: 50.h,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        decoration: BoxDecoration(
          color: AppColor.bgColor,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            color: AppColor.textGreyColor,
            width: 1.0, //2
          )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(
              () {
                return Text(
                  controller.selectedStartDateEdit.value,
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                      color: AppColor.textGreyColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400
                    )
                  )
                );
              }
            ),
            //SizedBox(width: 5.w,),
            Icon(
              CupertinoIcons.calendar,
              size: 24.r,
              color: AppColor.textGreyColor,
            )
          ],
        )
      ),
    );
  }
}