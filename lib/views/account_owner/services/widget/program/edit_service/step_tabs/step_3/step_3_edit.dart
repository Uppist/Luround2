import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services/program_service/program_service_controller.dart';
import 'package:luround/services/account_owner/services/user_services._service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/loader.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import 'package:luround/views/account_owner/mainpage/screen/mainpage.dart';
import 'package:luround/views/account_owner/services/widget/program/edit_service/step_tabs/step_1/textfields/amount_textfield_edit.dart';
import 'package:luround/views/account_owner/services/widget/program/edit_service/step_tabs/step_3/new/date_range_bottomsheet_edit.dart';
import 'package:luround/views/account_owner/services/widget/program/edit_service/step_tabs/step_2/selectors/time_range_s2_edit.dart';
import 'package:luround/views/account_owner/services/widget/program/edit_service/step_tabs/step_3/new/start_date_box.dart';
import 'package:luround/views/account_owner/services/widget/program/edit_service/step_tabs/step_3/new/start_time_box.dart';
import 'package:luround/views/account_owner/services/widget/program/edit_service/step_tabs/step_3/new/stop_date_box.dart';
import 'package:luround/views/account_owner/services/widget/program/edit_service/step_tabs/step_3/new/stop_time_box.dart';













class Step3PageProgramServiceEdit extends StatefulWidget{
  const Step3PageProgramServiceEdit({super.key, required this.service_charge_in_person, required this.service_charge_virtual,});
  final String service_charge_in_person;
  final String service_charge_virtual;

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
          "Date and Time",
          style: GoogleFonts.inter(
            color: AppColor.blackColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500
          ),
        ),
        SizedBox(height: 20.h),
        //r1
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StartDateBoxProgramEdit(),
            StartTimeBoxProgramEdit()
          ],
        ),
        SizedBox(height: 30.h,),
        //r2
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StopDateBoxProgramEdit(),
            StopTimeBoxProgramEdit()
          ],
        ),

        SizedBox(height: 30.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  CupertinoIcons.clock,
                  color: AppColor.blackColor,
                  size: 22.r,
                ),
                SizedBox(width: 5.w,),
                Text(
                  "Duration",
                  style: GoogleFonts.inter(
                    color: AppColor.blackColor,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500
                  ),
                ),
              ],
            ),

            Obx(
              () {
                return Text(
                  mainController.calcDurationEdit.value,
                  style: GoogleFonts.inter(
                    color: AppColor.darkGreyColor,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w400
                  ),
                );
              }
            ),
          ],
        ),

        SizedBox(height: 30.h),
        Text(
          "Maximum number of participants",
          style: GoogleFonts.inter(
            color: AppColor.blackColor,
            fontSize: 15.sp,
            fontWeight: FontWeight.w500
          ),
        ),
        SizedBox(height: 20.h),
        Container(
          //padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 0.h),
          alignment: Alignment.center,
          height: 45.h,
          width: 130.w, //125.w
          decoration: BoxDecoration(
            color: AppColor.bgColor,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
              color: AppColor.textGreyColor,
              width: 1.0, //2
            )
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed:() {
                  mainController.decreaseCountEdit();
                }, 
                icon: Icon(
                  CupertinoIcons.minus_circle,
                  color: AppColor.textGreyColor,
                  size: 24.r,
                )
              ),
              //SizedBox(width: 5.w,),
              Obx(
                () {
                  return Text(
                    mainController.countEdit.value.toString(),
                    style: GoogleFonts.inter(
                      color: AppColor.textGreyColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400
                    ),
                  );
                }
              ),
              //SizedBox(width: 5.w,),
              IconButton(
                onPressed:() {
                  mainController.increaseCountEdit();
                }, 
                icon: Icon(
                  CupertinoIcons.add_circled,
                  color: AppColor.textGreyColor,
                  size: 24.r,
                )
              )
            ],
          )
        ),

        SizedBox(height: 30.h,),

        Text(
          "Service fee per session*",
          style: GoogleFonts.inter(
            color: AppColor.blackColor,
            fontSize: 15.sp,
            fontWeight: FontWeight.w500
          ),
        ),
        SizedBox(height: 20.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "In-person",
              style: GoogleFonts.inter(
                color: AppColor.darkGreyColor, 
                fontSize: 16.sp,
                fontWeight: FontWeight.w500
              ),
            ),
            SizedBox(width: 20.w,),
            Expanded(
              child: AmountTextFieldEdit(  
                onChanged: (val) {
                  setState(() {
                    mainController.inPersonControllerEdit.text = val;
                  });
                },
                hintText: "00.00",
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                initialValue: widget.service_charge_in_person,
              ),
            ),
          ],
        ),
        SizedBox(height: 20.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Virtual",
              style: GoogleFonts.inter(
                color: AppColor.darkGreyColor, 
                fontSize: 16.sp,
                fontWeight: FontWeight.w500
              ),
            ),
            SizedBox(width: 45.w,),
            Expanded(
              child: AmountTextFieldEdit(  
                onChanged: (val) {
                  setState(() {
                    mainController.virtualControllerEdit.text = val;
                  });
                },
                hintText: "00.00",
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                initialValue: widget.service_charge_virtual,
              ),
            ),
          ],
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