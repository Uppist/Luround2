import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services/program_service/program_service_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import 'package:luround/views/account_owner/services/widget/program/add_service/step_tabs/step_1/new/custom_checkbox_listtile.dart';
import 'package:luround/views/account_owner/services/widget/program/edit_service/step_tabs/step_2/dropdows/recurrence_dropdown_edit.dart';










class Step2PageProgramServiceEdit  extends StatefulWidget {
  const Step2PageProgramServiceEdit({super.key, required this.onNext, required this.service_charge_in_person, required this.service_charge_virtual});
  final VoidCallback onNext;
  final String service_charge_in_person;
  final String service_charge_virtual;

  @override
  State<Step2PageProgramServiceEdit> createState() => _Step2PageProgramServiceEditState();
}

class _Step2PageProgramServiceEditState extends State<Step2PageProgramServiceEdit> {
  
  final controller = Get.put(ProgramServiceController());
  
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
              child: Icon(
                Icons.check_box,
                color: AppColor.mainColor,
                size: 24.r,
              ),
            ),
            SizedBox(width: 60.w,),
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
          itemCount: controller.daysEdit.length,
          itemBuilder: (context, index) {
    
            return Obx(
              () {
                //
                String day = controller.daysEdit[index]['day'];
                //
                bool isSelected = controller.daysEdit[index]['isSelected'];
                //
                String startTime = controller.getDaySelectionEdit(day)?.startTime ?? "";
                //
                String stopTime = controller.getDaySelectionEdit(day)?.stopTime ?? "";
                
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
                        controller.toggleDaySelectionEdit(
                          index, 
                          day, 
                          value, 
                          startTime, 
                          stopTime,
                        );
                        //
                        controller.isCheckBoxActiveEdit.value = true;
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
                  subtitle: controller.isCheckBoxActiveEdit.value ? const SizedBox() : const SizedBox()
                );
              }
            );
            
          }, 
        ),
        
        SizedBox(height: MediaQuery.of(context).size.height * 0.17),
    
        RebrandedReusableButton(
          textColor: controller.isCheckBoxActiveEdit.value ? AppColor.bgColor : AppColor.darkGreyColor,
          color: controller.isCheckBoxActiveEdit.value ? AppColor.mainColor : AppColor.lightPurple, 
          text: "Next", 
          onPressed: controller.isCheckBoxActiveEdit.value ?
          widget.onNext
          : () {},
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
        var day = controller.daysEdit[dayIndex]['day'];

        if (timeType == 'start') {
          // Update the start time for the selected day
          if(day != null) {
            log(formattedTime);
            controller.updateStartTimeEdit(day, formattedTime,)
            .whenComplete(() {
              log("${controller.selectedDaysEdit}");
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
            controller.updateStopTimeEdit(day, formattedTime,)
            .whenComplete(() {
              //controller.addDay(day, controller.startTime.text, controller.stopTime.text);
              log("${controller.selectedDaysEdit}");
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


  