import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services/event/event_service_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import 'package:luround/views/account_owner/services/widget/event/edit_event/step_tabs/step_2/events_widgets/multiple_dates_edit.dart';
import 'package:luround/views/account_owner/services/widget/event/edit_event/step_tabs/step_2/events_widgets/schedule_radio_edit.dart';
import 'package:luround/views/account_owner/services/widget/event/edit_event/step_tabs/step_2/events_widgets/single_date_widget_edit.dart';









class Step2PageEdit extends StatefulWidget {
  const Step2PageEdit({super.key, required this.onNext});
  final VoidCallback onNext;

  @override
  State<Step2PageEdit> createState() => _Step2PageState();
}

class _Step2PageState extends State<Step2PageEdit> {
  
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
        CustomRadioWidgetEdit(
          selectedValue: controller.eventScheduleEdit,
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.04),
        Obx(
          () {
            return controller.eventScheduleEdit.value == "Single date" 
            ? const SingleDateWidgetEdit()
            : const MultipleDatesWidgetEdit();
          }
        ),

        Obx(
          () {
            return controller.eventScheduleEdit.value == "Single date" 
            ? SizedBox(height: MediaQuery.of(context).size.height * 0.23)
            : SizedBox(height: MediaQuery.of(context).size.height * 0.40);
          }
        ),

        
        Obx(
          () {
            return RebrandedReusableButton(
              textColor: controller.eventScheduleEdit.value.isNotEmpty ? AppColor.bgColor : AppColor.darkGreyColor,
              color: controller.eventScheduleEdit.value.isNotEmpty ? AppColor.mainColor : AppColor.lightPurple, 
              text: "Next", 
              onPressed: controller.eventScheduleEdit.value.isNotEmpty ? 
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
      