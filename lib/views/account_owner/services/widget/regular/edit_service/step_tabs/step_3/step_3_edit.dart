import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services/regular_service/regular_service_controller.dart';
import 'package:luround/services/account_owner/services/user_services._service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/loader.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import 'package:luround/views/account_owner/mainpage/screen/mainpage.dart';
import 'package:luround/views/account_owner/services/widget/package/add_service/step_tabs/step_3/new/custom_checkbox_listtile.dart';
import 'package:luround/views/account_owner/services/widget/regular/edit_service/step_tabs/step_3/time_range_picker/time_range_picker_edit.dart';







class Step3PageEdit extends StatefulWidget{
  Step3PageEdit({
    super.key, 
    required this.serviceId, 
    required this.service_name, 
    required this.description, 
    required this.links, 
    required this.service_charge_in_person, 
    required this.service_charge_virtual, 
    required this.duration, 
    required this.time, 
    required this.date, 
    required this.available_days
  });

  final String serviceId;
  final String service_name;
  final String description;
  final List<dynamic> links;
  final String service_charge_in_person;
  final String service_charge_virtual;
  final String duration;
  final String time;
  final String date;
  final String available_days;


  @override
  State<Step3PageEdit> createState() => _Step3PageEditState();
}

class _Step3PageEditState extends State<Step3PageEdit> {


  var mainController = Get.put(ServicesController());
  var servicesService = Get.put(AccOwnerServicePageService());


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Day and Time availability*",
          style: GoogleFonts.inter(
            color: AppColor.blackColor,
            fontSize: 15.sp,
            fontWeight: FontWeight.w500
          ),
        ),
        SizedBox(height: 30.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.circle_rounded,
              color: AppColor.mainColor,
            ),
            SizedBox(width: 10.w,),
            Text(
              "West Africa Standard Time",
              style: GoogleFonts.inter(
                color: AppColor.mainColor,
                fontSize: 15.sp,
                fontWeight: FontWeight.w500
              ),
            ),
          ],
        ),
        SizedBox(height: 30.h),
        ListView.separated(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) => Divider(color: AppColor.textGreyColor, thickness: 0.3,),
          itemCount: mainController.daysOfTheWeekCheckBoxEdit.length,
          itemBuilder: (context, index) {
            return CustomCheckBoxListTile(
              checkbox: Checkbox.adaptive(
                checkColor: AppColor.bgColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.r)
                ),
                activeColor: AppColor.mainColor,
                value: mainController.daysOfTheWeekCheckBoxEdit[index]["isChecked"],
                onChanged: (value) {    
                  setState(() {
                    mainController.isCheckBoxActiveEdit.value = true;
                    mainController.toggleCheckboxEdit(index, value);
                    print("selectedDaysEdit: ${mainController.selectedDaysEdit}");     
                  }); 

                },
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mainController.daysOfTheWeekCheckBoxEdit[index]["day"],
                    style: GoogleFonts.inter(
                      color: AppColor.blackColor,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      /*setState(() {
                        mainController.daysOfTheWeekCheckBoxEdit[index]["isChecked"] = !mainController.daysOfTheWeekCheckBoxEdit[index]["isChecked"];
                        //to activate the done button
                        mainController.isCheckBoxActiveEdit.value = true;
                      });*/                
                    },
                    child: SvgPicture.asset(
                      "assets/svg/add_icon.svg",
                      height: 25.h,
                      width: 25.w,
                    ),
                  )
                ],
              ),
              subtitle: mainController.daysOfTheWeekCheckBoxEdit[index]["isChecked"] 
              ?EditTimeRangeSelector(index: index)           
              :SizedBox(),
            );                
          }
        ),

        SizedBox(height: MediaQuery.of(context).size.height * 0.07),

        Obx(
          () {
            return servicesService.isServiceEDLoading.value ? Loader() : RebrandedReusableButton(
              textColor: mainController.isCheckBoxActiveEdit.value ? AppColor.bgColor : AppColor.darkGreyColor,
              color: mainController.isCheckBoxActiveEdit.value ? AppColor.mainColor : AppColor.lightPurple, 
              text: "Done", 
              onPressed: mainController.isCheckBoxActiveEdit.value ? 
              //widget.onNext
              () {
                
                if(mainController.selectServiceModelEdit.value == "one-off") {
                  mainController.getTimeIntervalsEdit(
                    earliestTime: mainController.findEarliestTimeEdit(),
                    latestTime: mainController.findLatestTimeEdit(),
                    interval: mainController.durationEdit.value
                  ).whenComplete(() {
                    servicesService.updateRegularService(
                      context: context,
                      //service_type: "Virtual", //In-Person
                      serviceId: widget.serviceId,
                      service_name: mainController.serviceNameControllerEdit.text.isEmpty ? widget.service_name : mainController.serviceNameControllerEdit.text, 
                      description: mainController.descriptionControllerEdit.text.isEmpty ? widget.description : mainController.descriptionControllerEdit.text, 
                      links: mainController.addLinksControllerEdit.text.isEmpty ? widget.links : [mainController.addLinksControllerEdit.text], 
                      service_charge_in_person: mainController.inPersonControllerEdit.text.isEmpty ? widget.service_charge_in_person : mainController.inPersonControllerEdit.text, 
                      service_charge_virtual: mainController.virtualControllerEdit.text.isEmpty ? widget.service_charge_virtual : mainController.virtualControllerEdit.text, 
                      duration: mainController.formatDurationEdit().isEmpty ? widget.duration  : mainController.formatDurationEdit(), 
                      time: "${mainController.findEarliestTimeEdit()} - ${mainController.findLatestTimeEdit()}".isEmpty ? widget.time : "${mainController.findEarliestTimeEdit()} - ${mainController.findLatestTimeEdit()}",
                    
                      //change the date below to service model field
                      date: mainController.selectDateRangeEdit,             
                      available_days: mainController.availableDaysEdit(), 
                      available_time: mainController.availableTimeEdit,
                      //NEW
                      //regular service model         
                      service_model: mainController.selectServiceModelEdit.value,
                      service_timeline: mainController.serviceTimelineEdit.value,
                    ).whenComplete(() {
                      //1
                      setState(() {
                        mainController.curentStepEdit.value = mainController.curentStepEdit.value - 2;
                      });
                      //2
                      mainController.serviceNameControllerEdit.clear();
                      mainController.descriptionControllerEdit.clear();
                      mainController.addLinksControllerEdit.clear();
                      mainController.inPersonControllerEdit.clear();
                      mainController.virtualControllerEdit.clear();
                      //3
                      Get.offAll(
                        () => const MainPage(),
                        transition: Transition.rightToLeft
                      );
                    });
                  });
                }
                else{
                  servicesService.updateRegularService(
                    context: context,
                    //service_type: "Virtual", //In-Person
                    serviceId: widget.serviceId,
                    service_name: mainController.serviceNameControllerEdit.text.isEmpty ? widget.service_name : mainController.serviceNameControllerEdit.text, 
                    description: mainController.descriptionControllerEdit.text.isEmpty ? widget.description : mainController.descriptionControllerEdit.text, 
                    links: mainController.addLinksControllerEdit.text.isEmpty ? widget.links : [mainController.addLinksControllerEdit.text], 
                    service_charge_in_person: mainController.inPersonControllerEdit.text.isEmpty ? widget.service_charge_in_person : mainController.inPersonControllerEdit.text, 
                    service_charge_virtual: mainController.virtualControllerEdit.text.isEmpty ? widget.service_charge_virtual : mainController.virtualControllerEdit.text, 
                    duration: mainController.formatDurationEdit().isEmpty ? widget.duration  : mainController.formatDurationEdit(), 
                    time: "${mainController.findEarliestTimeEdit()} - ${mainController.findLatestTimeEdit()}".isEmpty ? widget.time : "${mainController.findEarliestTimeEdit()} - ${mainController.findLatestTimeEdit()}",
                    
                    //change the date below to service model field
                    date: mainController.selectDateRangeEdit,             
                    available_days: mainController.availableDaysEdit(), 
                    available_time: mainController.availableTimeEdit,
                    //NEW
                    //regular service model         
                    service_model: mainController.selectServiceModelEdit.value,
                    service_timeline: mainController.serviceTimelineEdit.value,
                  ).whenComplete(() {
                    //1
                    setState(() {
                      mainController.curentStepEdit.value = mainController.curentStepEdit.value - 2;
                    });
                    //2
                    mainController.serviceNameControllerEdit.clear();
                    mainController.descriptionControllerEdit.clear();
                    mainController.addLinksControllerEdit.clear();
                    mainController.inPersonControllerEdit.clear();
                    mainController.virtualControllerEdit.clear();
                    //3
                    Get.offAll(
                      () => const MainPage(),
                      transition: Transition.rightToLeft
                    );
                  });
                }
                    
              }
              :() {
                print('nothing');
              },
            );
          }
        ),
        SizedBox(height: 5.h),
      ]
    );
  }
}