import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services/retainer/retainer_service_controller.dart';
import 'package:luround/services/account_owner/services/user_services_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/loader.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import 'package:luround/views/account_owner/mainpage/screen/mainpage.dart';
import 'package:luround/views/account_owner/services/widget/retainer/add_service/step_tabs/step_3/new/custom_checkbox_listtile.dart';
import '../../../../../../../../controllers/account_owner/main/mainpage_controller.dart';








class Step3PagePackageServiceEdit extends StatefulWidget{
  const Step3PagePackageServiceEdit({super.key, required this.service_charge_virtual, required this.service_charge_in_person, required this.service_id, required this.service_name, required this.service_description, required this.virtual_meeting_link,});
  final String service_id;
  final String service_name;
  final String service_description;
  final String service_charge_virtual;
  final String service_charge_in_person;
  final String virtual_meeting_link;

  @override
  State<Step3PagePackageServiceEdit> createState() => _Step3PagePackageServiceEditState();
}

class _Step3PagePackageServiceEditState extends State<Step3PagePackageServiceEdit> {

  final mainController = Get.put(PackageServiceController());
  final servicesService = Get.put(AccOwnerServicePageService());
  final MainPageController controllerMp = Get.put(MainPageController());

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

        SizedBox(height: MediaQuery.of(context).size.height * 0.02),

        //available days list
        ListView.separated(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) => SizedBox(height: 20.h,),
          itemCount: mainController.daysEdit.length,
          itemBuilder: (context, index) {
    
            return Obx(
              () {
                //
                String day = mainController.daysEdit[index]['day'];
                //
                bool isSelected = mainController.daysEdit[index]['isSelected'];
                //
                String startTime = mainController.getDaySelectionEdit(day)?.startTime ?? "";
                //
                String stopTime = mainController.getDaySelectionEdit(day)?.stopTime ?? "";
                
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
                        mainController.toggleDaySelectionEdit(
                          index, 
                          day, 
                          value, 
                          startTime, 
                          stopTime,
                        );
                        //
                        mainController.isCheckBoxActiveEdit.value = true;
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
                  subtitle: mainController.isCheckBoxActiveEdit.value ? const SizedBox() : const SizedBox()
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
                    
                servicesService.updateRetainerService(
                  context: context,
                  serviceId: widget.service_id,
                  service_name: mainController.serviceNameControllerEdit.text.isNotEmpty ? mainController.serviceNameControllerEdit.text : widget.service_name, 
                  description: mainController.descriptionControllerEdit.text.isNotEmpty ? mainController.descriptionControllerEdit.text : widget.service_description, 
                  virtual_meeting_link: mainController.addLinksControllerEdit.text.isEmpty ? widget.virtual_meeting_link : mainController.addLinksControllerEdit.text, 
                  pricing: mainController.selectedTimeSlotEdit,
                  availability_schedule: mainController.selectedDaysEdit,
                  coreFeatures: mainController.inputsEdit,        
                ).whenComplete(() {
                  //1
                  setState(() {
                    mainController.curentStepEdit = mainController.curentStepEdit - 2;
                  });
                  //2
                  mainController.serviceNameControllerEdit.clear();
                  mainController.descriptionControllerEdit.clear();
                  mainController.addLinksControllerEdit.clear();
                  mainController.coreFeaturesControllerEdit.clear();
                  mainController.inputsEdit.clear();
                  mainController.selectedDaysEdit.clear();
                  mainController.controllersEdit.clear();
                  //3
                  //controllerMp.navigateToMainpageAtIndex(page: MainPage(), index: 1);
                  Get.offAll(() => MainPage());
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
            mainController.updateStopTimEdit(day, formattedTime,)
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