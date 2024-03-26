import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services/package_service/package_service_controller.dart';
import 'package:luround/main.dart';
import 'package:luround/services/account_owner/services/user_services._service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/loader.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import 'package:luround/views/account_owner/mainpage/screen/mainpage.dart';
import 'package:luround/views/account_owner/services/widget/package/edit_service/step_tabs/step_3/new/custom_checkbox_edit.dart';











class Step3PagePackageServiceEdit extends StatefulWidget{
  Step3PagePackageServiceEdit({super.key,});

  @override
  State<Step3PagePackageServiceEdit> createState() => _Step3PagePackageServiceEditState();
}

class _Step3PagePackageServiceEditState extends State<Step3PagePackageServiceEdit> {

  var mainController = Get.put(PackageServiceController());
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
          itemCount: mainController.daysOfTheWeekCheckBoxEdit.length,
          itemBuilder: (context, index) {

            return CustomCheckBox(
              checkbox: Checkbox.adaptive(
                checkColor: AppColor.bgColor,
                activeColor: AppColor.mainColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.r)
                ),
                value: mainController.daysOfTheWeekCheckBoxEdit[index]["isChecked"],
                onChanged: (value) {   
                  setState(() {
                    mainController.isCheckBoxActiveEdit.value = true;
                    mainController.toggleCheckboxEdit(index, value);
                    print("selectedDays: ${mainController.selectedDaysEdit}");
                  });     
                  //print("$index, ${controller.daysOfTheWeekCheckBoxEdit[index]["day"]}");
                },
              ),
              title: Text(
                mainController.daysOfTheWeekCheckBoxEdit[index]["day"],
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
                value: mainController.daysOfTheWeekCheckBoxEdit[index]["isChecked"],
                onChanged: (value) {   
                  setState(() {
                    mainController.isCheckBoxActiveEdit.value = true;
                    mainController.toggleCheckboxEdit(index, value);
                    print("selectedDays: ${mainController.selectedDaysEdit}");
                  });     
                  //print("$index, ${controller.daysOfTheWeekCheckBoxEdit[index]["day"]}");
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
                      setState(() {
                        mainController.daysOfTheWeekCheckBoxEdit[index]["isChecked"] = !mainController.daysOfTheWeekCheckBoxEdit[index]["isChecked"];
                        //to activate the done button
                        mainController.isCheckBoxActiveEdit.value = true;
                      });              
                    },
                    child: SvgPicture.asset("assets/svg/add_icon.svg"),
                  )
                ],
              ),
              subtitle: mainController.daysOfTheWeekCheckBoxEdit[index]["isChecked"] 
              ?TimeRangeSelectorEdit(index: index)           
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
              textColor: mainController.isCheckBoxActiveEdit.value ? AppColor.bgColor : AppColor.darkGreyColor,
              color: mainController.isCheckBoxActiveEdit.value ? AppColor.mainColor : AppColor.lightPurple, 
              text: "Done", 
              onPressed: mainController.isCheckBoxActiveEdit.value ? 
              //widget.onNext
              () {
                    
                mainController.getTimeIntervalsEdit(
                  earliestTime: mainController.findEarliestTimeEdit(),
                  latestTime: mainController.findLatestTimeEdit(),
                  interval: mainController.durationEdit.value
                )
                .whenComplete(() {
                  servicesService.createUserService(
                    available_time_list: mainController.availableTimeEdit,
                    context: context,
                    //service_type: "Virtual", //In-Person
                    service_name: mainController.serviceNameControllerEdit.text, 
                    description: mainController.descriptionControllerEdit.text, 
                    links: [mainController.addLinksControllerEdit.text], 
                    service_charge_in_person: mainController.inPersonControllerEdit.text, 
                    service_charge_virtual: mainController.virtualControllerEdit.text, 
                    duration: mainController.formatDurationEdit(), 
                    time: "${mainController.findEarliestTimeEdit()} - ${mainController.findLatestTimeEdit()}",
                    date: mainController.selectServiceModelEdit.value,  //selectServiceModel, selectDurationRadio   //regular service model           
                    available_days: mainController.availableDaysEdit(),
                  ).whenComplete(() {
                    //1
                    setState(() {
                      mainController.curentStepEdit = mainController.curentStepEdit - 2;
                    });
                    //2
                    mainController.serviceNameControllerEdit.clear();
                    mainController.descriptionControllerEdit.clear();
                    mainController.addLinksControllerEdit.clear();
                    mainController.inPersonControllerEdit.clear();
                    mainController.virtualControllerEdit.clear();
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