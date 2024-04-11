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
import 'package:luround/views/account_owner/services/widget/program/add_service/step_tabs/step_3/new/date_range_bottomsheet.dart';
import 'package:luround/views/account_owner/services/widget/program/add_service/step_tabs/step_2/selectors/time_range_s2.dart';
import 'package:luround/views/account_owner/services/widget/program/add_service/step_tabs/step_3/new/custom_checkbox.dart';
import 'package:luround/views/account_owner/services/widget/program/add_service/step_tabs/step_3/new/start_date_box.dart';
import 'package:luround/views/account_owner/services/widget/program/add_service/step_tabs/step_3/new/start_time_box.dart';
import 'package:luround/views/account_owner/services/widget/program/add_service/step_tabs/step_3/new/stop_date_box.dart';
import 'package:luround/views/account_owner/services/widget/program/add_service/step_tabs/step_3/new/stop_time_box.dart';
import 'package:luround/views/account_owner/services/widget/regular/add_service/step_tabs/step_1/textfields/amount_textfield.dart';












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
            StartDateBoxProgram(),
            StartTimeBoxProgram()
          ],
        ),
        SizedBox(height: 30.h,),
        //r2
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StopDateBoxProgram(),
            StopTimeBoxProgram()
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
                  mainController.calcDuration.value,
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
          //padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 10.h),
          alignment: Alignment.center,
          height: 45.h,
          width: 130.w, //125
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
                  mainController.decreaseCount();
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
                    mainController.count.value.toString(),
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
                  mainController.increaseCount();
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
          "Service fee",
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
              child: AmountTextField(  
                onChanged: (val) {},
                hintText: "00.00",
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                textController: mainController.inPersonController
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
              child: AmountTextField(  
                onChanged: (val) {},
                hintText: "00.00",
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                textController: mainController.virtualController
              ),
            ),
          ],
        ),
        
        SizedBox(height: MediaQuery.of(context).size.height * 0.08),

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
                  links: [mainController.addLinksController.text], 
                  service_charge_in_person: mainController.inPersonController.text, 
                  service_charge_virtual: mainController.virtualController.text, 
                  duration: mainController.calcDuration.value, 
                  service_recurrence: mainController.serviceRecurrence.value,
                  service_timeline: mainController.serviceTimeline.value,
                  timeline_days: mainController.selectedDays,
                  start_date: mainController.startDate(),
                  end_date: mainController.endDate(),
                  start_time: mainController.startTimeValue.value,
                  end_time: mainController.stopTimeValue.value,
                  max_number_of_participants: mainController.count.value
                    
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
}