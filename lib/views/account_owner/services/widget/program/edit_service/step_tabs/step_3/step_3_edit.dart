import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/main/mainpage_controller.dart';
import 'package:luround/controllers/account_owner/services/program_service/program_service_controller.dart';
import 'package:luround/main.dart';
import 'package:luround/services/account_owner/services/user_services_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/converters.dart';
import 'package:luround/utils/components/loader.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import 'package:luround/views/account_owner/mainpage/screen/mainpage.dart';
import 'package:luround/views/account_owner/services/widget/one-off/edit_service/step_tabs/step_1/textfields/amount_textfield_edit.dart';








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

  final mainController = Get.put(ProgramServiceController());
  final servicesService = Get.put(AccOwnerServicePageService());
  final MainPageController controllerMp = Get.put(MainPageController());


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        
        Text(
          "Maximum number of participants",
          style: GoogleFonts.inter(
            color: AppColor.blackColor,
            fontSize: 15.sp,
            fontWeight: FontWeight.w500
          ),
        ),
        SizedBox(height: 30.h),
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
        SizedBox(height: 40.h,),

        Text(
          "Program fee",
          style: GoogleFonts.inter(
            color: AppColor.blackColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500
          ),
        ),
        SizedBox(height: 40.h,),
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
            SizedBox(width: 30.w,),
            Expanded(
              child: AmountTextFieldEdit(
                onChanged: (val) {
                  //setState(() {
                    mainController.inPersonPriceControllerEdit.text = val;
                  //});
                },
                hintText: "${currency(context).currencySymbol} 00.00",
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                initialValue: widget.service_charge_in_person,

              ),
            ),
          ],
        ),
        SizedBox(height: 30.h,),
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
                  //setState(() {
                    mainController.virtualPriceControllerEdit.text = val;
                  //});
                },
                hintText: "${currency(context).currencySymbol} 00.00",
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                initialValue: widget.service_charge_virtual,
              ),
            ),
          ],
        ),

        SizedBox(height: MediaQuery.of(context).size.height * 0.33),

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
                  duration: calculateDurationBetweenDates(mainController.selectedStartDateEdit.value, mainController.selectedStopDateEdit.value) ?? "",
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

  
}