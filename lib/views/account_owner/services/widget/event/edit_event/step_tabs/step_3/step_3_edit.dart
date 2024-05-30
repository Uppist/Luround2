import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services/event/event_service_controller.dart';
import 'package:luround/services/account_owner/services/user_services_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import 'package:luround/views/account_owner/mainpage/screen/mainpage.dart';
import 'package:luround/views/account_owner/services/widget/event/edit_event/step_tabs/step_2/events_widgets/access_fee_widget_edit.dart';
import 'package:luround/views/account_owner/services/widget/event/edit_event/step_tabs/step_2/events_widgets/add_link_widget_edit.dart';
import 'package:luround/views/account_owner/services/widget/event/edit_event/step_tabs/step_2/events_widgets/add_location_widget_edit.dart';
import 'package:luround/views/account_owner/services/widget/event/edit_event/step_tabs/step_2/events_widgets/price_type_radio_edit.dart';









class Step3PageEdit extends StatefulWidget {
  const Step3PageEdit({super.key, required this.location, required this.meetingLink, required this.inPersonFee, required this.virtualFee, required this.serviceId});
  final String location;
  final String meetingLink;
  final String inPersonFee;
  final String virtualFee;
  final String serviceId;


  @override
  State<Step3PageEdit> createState() => _Step3PageEditState();
}

class _Step3PageEditState extends State<Step3PageEdit> {

  final controller = Get.put(EventsController());
  final service = Get.put(AccOwnerServicePageService());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Event type",
          style: GoogleFonts.inter(
            color: AppColor.blackColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        PriceTypeRadioWidgetEdit(
          selectedValue: controller.priceTypeEdit,
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.04),

        Obx(
          () {
            return controller.priceTypeEdit.value == "Virtual" 
            ? AddLinkWidgetEdit(meetingLink: widget.meetingLink,)
            : AddLocationWidgetEdit(location: widget.location,);
          }
        ),

        Obx(
          () {
            return controller.priceTypeEdit.value == "Virtual" 
            ? SizedBox(height: MediaQuery.of(context).size.height * 0.02)
            : SizedBox(height: MediaQuery.of(context).size.height * 0.02);
          }
        ),

        SizedBox(height: MediaQuery.of(context).size.height * 0.04),

        AccessFeeWidgetEdit(
          inPersonFee: widget.inPersonFee,
          virtualFee: widget.virtualFee,
        ),

        SizedBox(height: MediaQuery.of(context).size.height * 0.12),

        Obx(
          () {
            return RebrandedReusableButton(
              textColor: controller.priceTypeEdit.value.isNotEmpty ? AppColor.bgColor : AppColor.darkGreyColor,
              color: controller.priceTypeEdit.value.isNotEmpty ? AppColor.mainColor : AppColor.lightPurple, 
              text: "Done", 
              onPressed: controller.priceTypeEdit.value.isNotEmpty 
              ? () {
                service.updateEventService(
                  context: context, 
                  serviceId: widget.serviceId,
                  service_name: controller.serviceNameControllerEdit.text, 
                  description: controller.descriptionControllerEdit.text, 
                  virtual_meeting_link: controller.addLinkControllerEdit.text, 
                  physical_location: controller.addLocationControllerEdit.text, 
                  event_schedule: controller.eventScheduleEdit.value, 
                  date: controller.selectedDateEdit.value, 
                  start_time: controller.selectedStartTimeEdit.value, 
                  end_time: controller.selectedStopTimeEdit.value, 
                  inpersonFee: controller.inPersonPriceControllerEdit.text, 
                  virtualFee: controller.virtualPriceControllerEdit.text, 
                  pricing: controller.controllersEdit
                ).whenComplete(() {
                  //1
                  setState(() {
                    controller.curentStepEdit = controller.curentStepEdit - 2;
                    controller.selectedDateEdit.value = '';
                    controller.selectedStartTimeEdit.value = '';
                    controller.selectedStopTimeEdit.value = '';
                  });
                  //2
                  controller.serviceNameControllerEdit.clear();
                  controller.descriptionControllerEdit.clear();
                  controller.addLinkControllerEdit.clear();
                  controller.addLocationControllerEdit.clear();
                  controller.controllersEdit.clear();
                  controller.inPersonPriceControllerEdit.clear();
                  controller.virtualPriceControllerEdit.clear();
                  //3
                  Get.offAll(
                    () => const MainPage(),
                    transition: Transition.rightToLeft
                  );
                });
              }
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