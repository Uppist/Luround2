import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services/event/event_service_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/views/account_owner/services/widget/one-off/add_service/step_tabs/step_1/textfields/amount_textfield.dart';






class AccessFeeWidgetEdit extends StatelessWidget {
  AccessFeeWidgetEdit({super.key});

  final controller = Get.put(EventsController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Access fee",
          style: GoogleFonts.inter(
            color: AppColor.blackColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500
          ),
        ),
        SizedBox(height: 30.h),

        //In-person Field
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                "In-person",
                style: GoogleFonts.inter(
                  color: AppColor.darkGreyColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500
                ),
              ),
            ),
            //SizedBox(width: 30.w),
            Expanded(
              child: AmountTextField(  
                onChanged: (val) {},
                hintText: "00:00",
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                textController: controller.inPersonPriceControllerEdit
              ),
            )
          ],
        ),
        SizedBox(height: 20.h),
        //Virtual Field
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                "Virtual",
                style: GoogleFonts.inter(
                  color: AppColor.darkGreyColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500
                ),
              ),
            ),
            //SizedBox(width: 30.w),
            Expanded(
              child: AmountTextField(  
                onChanged: (val) {},
                hintText: "00:00",
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                textController: controller.virtualPriceControllerEdit
              ),
            )
          ],
        ),
      ],
    );
  }
}