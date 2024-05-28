import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services/event/event_service_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/views/account_owner/services/widget/retainer/edit_service/step_tabs/step_1/textfields/edit_normal_textfield.dart';









class AddLinkWidgetEdit extends StatelessWidget {
  AddLinkWidgetEdit({super.key, required this.meetingLink});
  final String meetingLink;

  final controller = Get.put(EventsController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Add event link for virtual event",
          style: GoogleFonts.inter(
            color: AppColor.blackColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500
          ),
        ),
        SizedBox(height: 30.h),
        ReusableEditTextField(  
          onChanged: (val) {
            controller.addLinkControllerEdit.text = val;
          },
          hintText: "Event link",
          keyboardType: TextInputType.url,
          textInputAction: TextInputAction.done,
          initialValue: meetingLink,
        ),
      ],
    );
  }
}