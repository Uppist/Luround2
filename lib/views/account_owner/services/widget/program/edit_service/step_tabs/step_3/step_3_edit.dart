import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services/program_service/program_service_controller.dart';
import 'package:luround/services/account_owner/services/user_services_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/converters.dart';
import 'package:luround/utils/components/loader.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import 'package:luround/views/account_owner/mainpage/screen/mainpage.dart';
import 'package:luround/views/account_owner/services/widget/program/edit_service/step_tabs/step_1/new/custom_checkbox_listtile_edit.dart';








class Step3PageProgramServiceEdit extends StatefulWidget{
  const Step3PageProgramServiceEdit({super.key, required this.service_charge_in_person, required this.service_charge_virtual, required this.service_id, required this.service_name, required this.service_description, required this.duration, required this.links, required this.max_number_of_participants,});
  final String service_charge_in_person;
  final String service_charge_virtual;
  final String service_id;
  final String service_name;
  final String service_description;
  final String duration;
  final int max_number_of_participants;
  final List<dynamic> links;

  @override
  State<Step3PageProgramServiceEdit> createState() => _Step3PageProgramServiceEditState();
}

class _Step3PageProgramServiceEditState extends State<Step3PageProgramServiceEdit> {

  var mainController = Get.put(ProgramServiceController());
  var servicesService = Get.put(AccOwnerServicePageService());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        
        Text(
          "Day and Time Availability",
          style: GoogleFonts.inter(
            color: AppColor.blackColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500
          ),
        ),

        SizedBox(height: MediaQuery.of(context).size.height * 0.04),
        //from & to row
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Text(
                "",
                style: GoogleFonts.inter(
                  color: AppColor.darkGreyColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400
                ),
              ),
            ),
            SizedBox(width: 40.w,),
            Expanded(
              child: Text(
                "From",
                style: GoogleFonts.inter(
                  color: AppColor.darkGreyColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400
                ),
              ),
            ),
            //SizedBox(width: 0.w,),
            Expanded(
              child: Text(
                "To",
                style: GoogleFonts.inter(
                  color: AppColor.darkGreyColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: MediaQuery.of(context).size.height * 0.03),

        //available days list
        ListView.separated(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) => SizedBox(height: 20.h,),
          itemCount: mainController.days.length,
          itemBuilder: (context, index) {
    
            return Obx(
              () {
                //
                String day = mainController.days[index]['day'];
                //
                bool isSelected = mainController.days[index]['isSelected'];
                //
                String startTime = mainController.getDaySelection(day)?.startTime ?? "start time";
                //
                String stopTime = mainController.getDaySelection(day)?.stopTime ?? "stop time";
                
                return CustomCheckBoxListTile(
                  checkbox: Checkbox.adaptive(
                    checkColor: AppColor.bgColor,
                    activeColor: AppColor.mainColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.r)
                    ),
                    value: isSelected,
                    onChanged: (value) {   
                      // Toggle checkbox and update selection in the list
                      setState(() {
                        //
                        isSelected = value!;
                        //
                        mainController.toggleDaySelection(
                          index, 
                          day, 
                          value, 
                          startTime, 
                          stopTime,
                        );
                        //
                        mainController.isCheckBoxActive.value = true;
                      });
                    },
                  ),              
                  
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          day,
                          style: GoogleFonts.inter(
                            color: AppColor.blackColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                      ),

                      SizedBox(width: 10.w,),

                      //start time
                      Expanded(
                        child: InkWell(
                          onTap: () => _selectTime(context, 'start', index),
                          child: Container(
                            alignment: Alignment.center,
                            height: 40.h,
                            //width: 100.w,
                            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                            decoration: BoxDecoration(
                              color: AppColor.bgColor,
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(
                                color: AppColor.textGreyColor,
                                width: 1.0, //2
                              )
                            ),
                            child: Text(
                              startTime,
                              style: GoogleFonts.inter(
                                color: AppColor.blackColor,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400
                              ),
                            ),
                          ),
                        )
                      ),

                      SizedBox(width: 10.w,),

                      //stop time
                      Expanded(
                        child: InkWell(
                          onTap: () => _selectTime(context, 'stop', index),
                          child: Container(
                            alignment: Alignment.center,
                            height: 40.h,
                            //width: 100.w,
                            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                            decoration: BoxDecoration(
                              color: AppColor.bgColor,
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(
                                color: AppColor.textGreyColor,
                                width: 1.0, //2
                              )
                            ),
                            child: Text(
                              stopTime,
                              style: GoogleFonts.inter(
                                color: AppColor.blackColor,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400
                              ),
                            ),
                          ),
                        )
                      ),
                
                    ],
                  ),
                  subtitle: mainController.isCheckBoxActive.value ? const SizedBox() : const SizedBox()
                );
              }
            );
            
          }, 
        ),

        SizedBox(height: MediaQuery.of(context).size.height * 0.065),

        //button
        Obx(
          () {
            return servicesService.isServiceCRLoading.value ? Loader() : RebrandedReusableButton(
              textColor: mainController.isCheckBoxActiveEdit.value ? AppColor.bgColor : AppColor.darkGreyColor,
              color: mainController.isCheckBoxActiveEdit.value ? AppColor.mainColor : AppColor.lightPurple, 
              text: "Done", 
              onPressed: mainController.isCheckBoxActiveEdit.value ? 
              //widget.onNext
              () {
                    
                
                servicesService.updateProgramService(
                  context: context,
                  serviceId: widget.service_id,
                  service_name: mainController.serviceNameControllerEdit.text.isNotEmpty ? mainController.serviceNameControllerEdit.text : widget.service_name, 
                  description: mainController.descriptionControllerEdit.text.isNotEmpty ? mainController.descriptionControllerEdit.text : widget.service_description, 
                  program_recurrence: mainController.serviceRecurrenceEdit.value,
                  service_charge_in_person: mainController.inPersonPriceControllerEdit.text.isNotEmpty ? mainController.inPersonPriceControllerEdit.text : widget.service_charge_in_person, 
                  service_charge_virtual: mainController.virtualPriceControllerEdit.text.isNotEmpty ? mainController.virtualPriceControllerEdit.text : widget.service_charge_virtual, 
                  start_date: mainController.selectedStartDateEdit.value,
                  end_date: mainController.selectedStopDateEdit.value,
                  duration: calculateDurationBetweenDates(mainController.selectedStartDateEdit.value, mainController.selectedStopDateEdit.value),
                  max_number_of_participants: mainController.countEdit.value == 0 ? widget.max_number_of_participants : mainController.countEdit.value,
                  availability_schedule: mainController.selectedDaysEdit,
                  ).whenComplete(() {
                    //1
                    setState(() {
                      mainController.curentStepEdit = mainController.curentStepEdit - 2;
                      mainController.selectedStartDateEdit.value = '';
                      mainController.selectedStopDateEdit.value = '';
                    });
                    //2
                    mainController.serviceNameControllerEdit.clear();
                    mainController.descriptionControllerEdit.clear();
                    mainController.inPersonPriceControllerEdit.clear();
                    mainController.virtualPriceControllerEdit.clear();
                    mainController.selectedDaysEdit.clear();
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


  // Function to show the time picker and set the selected time
  void _selectTime(BuildContext context, String timeType, int dayIndex) async {
    // Ensure the dayIndex is within the valid range
    /*if (dayIndex < 0 || dayIndex >= controller.days.length) {
      log('Invalid day index: $dayIndex');
      return;
    }*/

    // Determine if the user prefers 24-hour format
    bool use24HourFormat = MediaQuery.of(context).alwaysUse24HourFormat;

    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: use24HourFormat),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        String formattedTime = picked.format(context);
        var day = mainController.daysEdit[dayIndex]['day'];

        if (timeType == 'start') {
          // Update the start time for the selected day
          if(day != null) {
            log(formattedTime);
            mainController.updateStartTimeEdit(day, formattedTime,)
            .whenComplete(() {
              log("${mainController.selectedDaysEdit}");
            });
          }
          else{
            throw Exception('please select day first');
          }
        } 
        else {
          // Update the stop time for the selected day
          if(day != null) {
            log(formattedTime);
            mainController.updateStopTimeEdit(day, formattedTime,)
            .whenComplete(() {
              //controller.addDay(day, controller.startTime.text, controller.stopTime.text);
              log("${mainController.selectedDaysEdit}");
            });
          }
          else{
            throw Exception('please select day first');
          }
        }

      });
    }
  }
  
}