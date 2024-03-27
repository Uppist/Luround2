import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services/program_service/program_service_controller.dart';
import 'package:luround/main.dart';
import 'package:luround/services/account_owner/services/user_services._service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/loader.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import 'package:luround/views/account_owner/mainpage/screen/mainpage.dart';
import 'package:luround/views/account_owner/services/widget/program/add_service/step_tabs/step_3/new/custom_checkbox.dart';












class Step3PageProgramService extends StatefulWidget{
  Step3PageProgramService({super.key,});

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
        /*Text(
          "Day and Time availability*",
          style: GoogleFonts.inter(
            color: AppColor.blackColor,
            fontSize: 15.sp,
            fontWeight: FontWeight.w500
          ),
        ),*/
        Text(
          "Day availability*",
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

            return CustomCheckBox(
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
              title: Text(
                mainController.daysOfTheWeekCheckBox[index]["day"],
                style: GoogleFonts.inter(
                  color: AppColor.blackColor,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500
                ),
              )
            );

            /*return CustomCheckBoxListTile(
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
                      setState(() {
                        mainController.daysOfTheWeekCheckBox[index]["isChecked"] = !mainController.daysOfTheWeekCheckBox[index]["isChecked"];
                        //to activate the done button
                        mainController.isCheckBoxActive.value = true;
                      });              
                    },
                    child: SvgPicture.asset("assets/svg/add_icon.svg"),
                  )
                ],
              ),
              subtitle: mainController.daysOfTheWeekCheckBox[index]["isChecked"] 
              ?TimeRangeSelector(index: index)           
              :const SizedBox(),
            );*/
                 
          }, 
        ),
        SizedBox(height: 90.h),

        //button
        RebrandedReusableButton(
          textColor: AppColor.bgColor,
          color: AppColor.mainColor, 
          text: "Done", 
          onPressed: () {}
        ),

        //button
        /*Obx(
          () {
            return servicesService.isServiceCRLoading.value ? Loader() : RebrandedReusableButton(
              textColor: mainController.isCheckBoxActive.value ? AppColor.bgColor : AppColor.darkGreyColor,
              color: mainController.isCheckBoxActive.value ? AppColor.mainColor : AppColor.lightPurple, 
              text: "Done", 
              onPressed: mainController.isCheckBoxActive.value ? 
              //widget.onNext
              () {
                    
                mainController.getTimeIntervals(
                  earliestTime: mainController.findEarliestTime(),
                  latestTime: mainController.findLatestTime(),
                  interval: mainController.duration.value
                )
                .whenComplete(() {
                  servicesService.createUserService(
                    available_time_list: mainController.availableTime,
                    context: context,
                    //service_type: "Virtual", //In-Person
                    service_name: mainController.serviceNameController.text, 
                    description: mainController.descriptionController.text, 
                    links: [mainController.addLinksController.text], 
                    service_charge_in_person: mainController.inPersonController.text, 
                    service_charge_virtual: mainController.virtualController.text, 
                    duration: mainController.formatDuration(), 
                    time: "${mainController.findEarliestTime()} - ${mainController.findLatestTime()}",
                    date: mainController.selectServiceModel.value,  //selectServiceModel, selectDurationRadio   //regular service model           
                    available_days: mainController.availableDays(),
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
                    Get.offUntil(
                      GetPageRoute(
                        curve: Curves.bounceIn,
                        page: () => const MainPage(),
                      ), 
                      (route) => true
                    );
                  });       
                });
                        
              }
              : () {
                print('nothing');
              },
                
            );
          }
        ),*/

        SizedBox(height: 5.h),
      ]
    );
    
  }
}