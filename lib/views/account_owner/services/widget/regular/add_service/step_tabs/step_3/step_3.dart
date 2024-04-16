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
import 'package:luround/views/account_owner/services/widget/regular/add_service/step_tabs/step_3/time_range_picker/time_range_picker.dart';











class Step3Page extends StatefulWidget{
  Step3Page({super.key,});

  @override
  State<Step3Page> createState() => _Step3PageState();
}

class _Step3PageState extends State<Step3Page> {

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
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) => Divider(color: AppColor.textGreyColor, thickness: 0.3,),
          itemCount: mainController.daysOfTheWeekCheckBox.length,
          itemBuilder: (context, index) {
    
            return CustomCheckBoxListTile(
              checkbox: Checkbox.adaptive(
                checkColor: AppColor.bgColor,
                activeColor: AppColor.mainColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.r)
                ),
                value: mainController.daysOfTheWeekCheckBox[index]["isChecked"],
                onChanged: (value) {   
                  setState(() {
                    mainController.isCheckBoxActive.value = true;
                    mainController.toggleCheckbox(index, value);
                    print("selectedDays: ${mainController.selectedDays}");
                  });     
                  //print("$index, ${controller.daysOfTheWeekCheckBoxEdit[index]["day"]}");
                },
              ),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mainController.daysOfTheWeekCheckBox[index]["day"],
                    style: GoogleFonts.inter(
                      color: AppColor.blackColor,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  InkWell(
                    onTap: () {    
                      /*setState(() {
                        mainController.daysOfTheWeekCheckBox[index]["isChecked"] = !mainController.daysOfTheWeekCheckBox[index]["isChecked"];
                        //to activate the done button
                        mainController.isCheckBoxActive.value = true;
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
              subtitle: mainController.daysOfTheWeekCheckBox[index]["isChecked"] 
              ?TimeRangeSelector(index: index)           
              :const SizedBox(),
            );
            
          }, 
        ),

        SizedBox(height: MediaQuery.of(context).size.height * 0.07),

        Obx(
          () {
            return servicesService.isServiceCRLoading.value ? Loader() : RebrandedReusableButton(
              textColor: mainController.isCheckBoxActive.value ? AppColor.bgColor : AppColor.darkGreyColor,
              color: mainController.isCheckBoxActive.value ? AppColor.mainColor : AppColor.lightPurple, 
              text: "Done", 
              onPressed: mainController.isCheckBoxActive.value ? 
              //widget.onNext
              () {
                if(mainController.selectServiceModel.value == "ONE-OFF") {

                  print("available_time_list: ${mainController.availableTime}");
                  mainController.getTimeIntervals(
                    earliestTime: mainController.findEarliestTime(),
                    latestTime: mainController.findLatestTime(),
                    interval: mainController.duration.value
                  )
                  .whenComplete(() {
                    
                    servicesService.createRegularService(
                      context: context,
                      service_name: mainController.serviceNameController.text, 
                      description: mainController.descriptionController.text, 
                      links: [mainController.addLinksController.text], 
                      service_charge_in_person: mainController.inPersonController.text, 
                      service_charge_virtual: mainController.virtualController.text, 
                      duration: mainController.formatDuration(), 
                      time: "${mainController.findEarliestTime()} - ${mainController.findLatestTime()}",
                      available_time_list: mainController.availableTime,
                      available_days: mainController.availableDays(),
                      date: mainController.selectDateRange,

                      //NEW
                      //regular service model         
                      service_model: mainController.selectServiceModel.value,
                      service_timeline: mainController.serviceTimeline.value,
                    ).whenComplete(() {
                      //1
                      setState(() {
                        mainController.curentStep = mainController.curentStep - 2;
                      });
                      //2
                      mainController.serviceNameController.clear();
                      mainController.descriptionController.clear();
                      mainController.addLinksController.clear();
                      mainController.inPersonController.clear();
                      mainController.virtualController.clear();
                      //3
                      Get.offAll(
                        () => MainPage(),
                        transition: Transition.rightToLeft
                      );
                    }); 
                  });
                }
                else{
                  servicesService.createRegularService(
                    context: context,
                    service_name: mainController.serviceNameController.text, 
                    description: mainController.descriptionController.text, 
                    links: [mainController.addLinksController.text], 
                    service_charge_in_person: mainController.inPersonController.text, 
                    service_charge_virtual: mainController.virtualController.text, 
                    duration: mainController.formatDuration(), 
                    time: "${mainController.findEarliestTime()} - ${mainController.findLatestTime()}",
                    available_time_list: mainController.availableTime,
                    available_days: mainController.availableDays(),
                    date: mainController.selectDateRange,

                    //NEW
                    //regular service model         
                    service_model: mainController.selectServiceModel.value,
                    service_timeline: mainController.serviceTimeline.value,
                  ).whenComplete(() {
                    //1
                    setState(() {
                      mainController.curentStep = mainController.curentStep - 2;
                    });
                    //2
                    mainController.serviceNameController.clear();
                    mainController.descriptionController.clear();
                    mainController.addLinksController.clear();
                    mainController.inPersonController.clear();
                    mainController.virtualController.clear();
                    //3
                    Get.offAll(
                      () => MainPage(),
                      transition: Transition.rightToLeft
                    );
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