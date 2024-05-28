import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services/event/event_service_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import 'package:luround/views/account_owner/services/widget/event/add_event/step_tabs/step_2/events_widgets/multiple_dates_widget.dart';
import 'package:luround/views/account_owner/services/widget/event/add_event/step_tabs/step_2/events_widgets/schedule_radio.dart';
import 'package:luround/views/account_owner/services/widget/event/add_event/step_tabs/step_2/events_widgets/single_date_widget.dart';






class Step2Page extends StatefulWidget {
  const Step2Page({super.key, required this.onNext});
  final VoidCallback onNext;

  @override
  State<Step2Page> createState() => _Step2PageState();
}

class _Step2PageState extends State<Step2Page> {
  
  final controller = Get.put(EventsController());
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Event Schedule",
          style: GoogleFonts.inter(
            color: AppColor.blackColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        CustomRadioWidget(
          selectedValue: controller.eventSchedule,
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.04),
        Obx(
          () {
            return controller.eventSchedule.value == "Single date" 
            ? const SingleDateWidget()
            : const MultipleDatesWidget();
          }
        ),

        Obx(
          () {
            return controller.eventSchedule.value == "Single date" 
            ? SizedBox(height: MediaQuery.of(context).size.height * 0.23)
            : SizedBox(height: MediaQuery.of(context).size.height * 0.11);
          }
        ),

        
        Obx(
          () {
            return RebrandedReusableButton(
              textColor: controller.eventSchedule.value.isNotEmpty ? AppColor.bgColor : AppColor.darkGreyColor,
              color: controller.eventSchedule.value.isNotEmpty ? AppColor.mainColor : AppColor.lightPurple, 
              text: "Next", 
              onPressed: controller.eventSchedule.value.isNotEmpty ? 
              widget.onNext
              : () {
                print('nothing');
              },
            );
          }
        ),

      ]
    );
  }
}
      