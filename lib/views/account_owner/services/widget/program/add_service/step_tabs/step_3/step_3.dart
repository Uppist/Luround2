import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services/program_service/program_service_controller.dart';
import 'package:luround/services/account_owner/services/user_services._service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/loader.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import 'package:luround/views/account_owner/mainpage/screen/mainpage.dart';
import 'package:luround/views/account_owner/services/widget/program/add_service/step_tabs/step_1/new/custom_checkbox_listtile.dart';









class Step3PageProgramService extends StatefulWidget{
  const Step3PageProgramService({super.key,});

  @override
  State<Step3PageProgramService> createState() => _Step3PageProgramServiceState();
}

class _Step3PageProgramServiceState extends State<Step3PageProgramService> {

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
              textColor: mainController.isCheckBoxActive.value ? AppColor.bgColor : AppColor.darkGreyColor,
              color: mainController.isCheckBoxActive.value ? AppColor.mainColor : AppColor.lightPurple, 
              text: "Done", 
              onPressed: mainController.isCheckBoxActive.value ? 
              //widget.onNext
              () {          
                
                servicesService.createProgramService(
                  context: context,
                  service_name: mainController.serviceNameController.text, 
                  description: mainController.descriptionController.text, 
                  program_recurrence: mainController.serviceRecurrence.value,
                  service_charge_in_person: mainController.inPersonPriceController.text, 
                  service_charge_virtual: mainController.virtualPriceController.text, 
                  start_date: mainController.selectedStartDate.value,
                  end_date: mainController.selectedStopDate.value,
                  max_number_of_participants: mainController.count.value,
                  availability_schedule: mainController.selectedDays,
                    
                ).whenComplete(() {
                  //1
                  setState(() {
                    mainController.curentStep = mainController.curentStep - 2;
                    mainController.selectedStartDate.value = '';
                    mainController.selectedStopDate.value = '';
                  });
                  //2
                  mainController.serviceNameController.clear();
                  mainController.descriptionController.clear();
                  mainController.inPersonPriceController.clear();
                  mainController.virtualPriceController.clear();
                  mainController.selectedDays.clear();
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
        var day = mainController.days[dayIndex]['day'];

        if (timeType == 'start') {
          // Update the start time for the selected day
          if(day != null) {
            log(formattedTime);
            mainController.updateStartTime(day, formattedTime,)
            .whenComplete(() {
              log("${mainController.selectedDays}");
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
            mainController.updateStopTime(day, formattedTime,)
            .whenComplete(() {
              //controller.addDay(day, controller.startTime.text, controller.stopTime.text);
              log("${mainController.selectedDays}");
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