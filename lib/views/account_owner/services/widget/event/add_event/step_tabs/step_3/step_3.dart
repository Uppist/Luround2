import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/main/mainpage_controller.dart';
import 'package:luround/controllers/account_owner/services/event/event_service_controller.dart';
import 'package:luround/services/account_owner/services/user_services_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/converters.dart';
import 'package:luround/utils/components/loader.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import 'package:luround/views/account_owner/mainpage/screen/mainpage.dart';
import 'package:luround/views/account_owner/services/widget/event/add_event/step_tabs/step_2/events_widgets/access_fee_widget.dart';
import 'package:luround/views/account_owner/services/widget/event/add_event/step_tabs/step_2/events_widgets/add_link_widget.dart';
import 'package:luround/views/account_owner/services/widget/event/add_event/step_tabs/step_2/events_widgets/add_location.dart';
import 'package:luround/views/account_owner/services/widget/event/add_event/step_tabs/step_2/events_widgets/price_type_radio.dart';








class Step3Page extends StatefulWidget {
  const Step3Page({super.key});

  @override
  State<Step3Page> createState() => _Step3PageState();
}

class _Step3PageState extends State<Step3Page> {

  final controller = Get.put(EventsController());
  final service = Get.put(AccOwnerServicePageService());
  final MainPageController controllerMp = Get.put(MainPageController());

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
        PriceTypeRadioWidget(
          selectedValue: controller.priceType,
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.04),

        Obx(
          () {
            return controller.priceType.value == "Virtual" 
            ? AddLinkWidget()
            : controller.priceType.value == "In-person" 
            ? AddLocationWidget()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AddLinkWidget(),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  AddLocationWidget()
                ]
            );

          }
        ),

        Obx(
          () {
            return controller.priceType.value == "Virtual" 
            ? SizedBox(height: MediaQuery.of(context).size.height * 0.02)
            : SizedBox(height: MediaQuery.of(context).size.height * 0.02);
          }
        ),

        SizedBox(height: MediaQuery.of(context).size.height * 0.04),

        AccessFeeWidget(priceType: controller.priceType),

        SizedBox(height: MediaQuery.of(context).size.height * 0.10),

        Obx(
          () {
            return service.isServiceCRLoading.value ? const Loader() : RebrandedReusableButton(
              textColor: controller.priceType.value.isNotEmpty ? AppColor.bgColor : AppColor.darkGreyColor,
              color: controller.priceType.value.isNotEmpty ? AppColor.mainColor : AppColor.lightPurple, 
              text: "Done", 
              onPressed: controller.priceType.value.isNotEmpty 
              ? () {
                if(controller.eventSchedule.value == 'Single date'){
                  log('${controller.eventSchedule.value}');
                  service.createEventService(
                    context: context, 
                    duration: getTimeDurationString(startTime: controller.selectedStartTime.value, stopTime: controller.selectedStopTime.value), //come back to this
                    service_name: controller.serviceNameController.text, 
                    description: controller.descriptionController.text, 
                    virtual_meeting_link: controller.addLinkController.text, 
                    physical_location: controller.addLocationController.text, 
                    event_schedule: controller.eventSchedule.value, 
                    date: controller.selectedDate.value, 
                    start_time: controller.selectedStartTime.value, 
                    end_time: controller.selectedStopTime.value, 
                    inpersonFee: controller.inPersonPriceController.text, 
                    virtualFee: controller.virtualPriceController.text, 
                    schedule: []
                  ).whenComplete(() {
                    //1
                    setState(() {
                      controller.curentStep = controller.curentStep - 2;
                      controller.selectedDate.value = '';
                      controller.selectedStartTime.value = '';
                      controller.selectedStopTime.value = '';
                    });
                    //2
                    controller.serviceNameController.clear();
                    controller.descriptionController.clear();
                    controller.addLinkController.clear();
                    controller.addLocationController.clear();
                    controller.dataListForBackend.clear();
                    controller.inPersonPriceController.clear();
                    controller.virtualPriceController.clear();
                    Get.offAll(() => const MainPage());
                  });
                }
                else{ 
                  log('${controller.eventSchedule.value}');
                  final String duration = getTimeDurationString(
                    startTime: controller.dataListForBackend[0]['start_time'],
                    stopTime: controller.dataListForBackend[0]['stop_time']
                  );
                  service.createEventService(
                    context: context, 
                    duration: duration,
                    service_name: controller.serviceNameController.text, 
                    description: controller.descriptionController.text, 
                    virtual_meeting_link: controller.addLinkController.text, 
                    physical_location: controller.addLocationController.text, 
                    event_schedule: controller.eventSchedule.value, 
                    date: '', // controller.dataListForBackend[0]['date'], 
                    start_time: controller.dataListForBackend[0]['start_time'], 
                    end_time: controller.dataListForBackend[0]['stop_time'],
                    inpersonFee: controller.inPersonPriceController.text, 
                    virtualFee: controller.virtualPriceController.text, 
                    schedule: controller.dataListForBackend
                  ).whenComplete(() {
                    //1
                    setState(() {
                      controller.curentStep = controller.curentStep - 2;
                      controller.selectedDate.value = '';
                      controller.selectedStartTime.value = '';
                      controller.selectedStopTime.value = '';
                    });
                    //2
                    controller.serviceNameController.clear();
                    controller.descriptionController.clear();
                    controller.addLinkController.clear();
                    controller.addLocationController.clear();
                    controller.dataListForBackend.clear();
                    controller.inPersonPriceController.clear();
                    controller.virtualPriceController.clear();
                    Get.offAll(() => const MainPage());
                  });
                }

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