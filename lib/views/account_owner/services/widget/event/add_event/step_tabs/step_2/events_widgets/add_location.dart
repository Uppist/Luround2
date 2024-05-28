import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services/event/event_service_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/reusable_custom_textfield.dart';






class AddLocationWidget extends StatelessWidget {
  AddLocationWidget({super.key});

  final controller = Get.put(EventsController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Add event location for In-person event",
          style: GoogleFonts.inter(
            color: AppColor.blackColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500
          ),
        ),
        SizedBox(height: 30.h),
        ReusableTextField(  
          onChanged: (val) {},
          hintText: "Event location",
          keyboardType: TextInputType.streetAddress,
          textInputAction: TextInputAction.done,
          textController: controller.addLocationController
        ),
      ],
    );
  }
}