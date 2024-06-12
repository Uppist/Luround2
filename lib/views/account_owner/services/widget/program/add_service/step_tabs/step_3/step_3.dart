import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
import 'package:luround/views/account_owner/services/widget/one-off/add_service/step_tabs/step_1/textfields/amount_textfield.dart';








class Step3PageProgramService extends StatefulWidget{
  const Step3PageProgramService({super.key,});

  @override
  State<Step3PageProgramService> createState() => _Step3PageProgramServiceState();
}

class _Step3PageProgramServiceState extends State<Step3PageProgramService> {

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
              child: AmountTextField(
                onChanged: (val) {
                  //setState(() {
                    mainController.inPersonPriceController.text = val;
                  //});
                },
                hintText: "${currency(context).currencySymbol} 00.00",
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                textController: mainController.inPersonPriceController,

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
              child: AmountTextField(  
                onChanged: (val) {
                  //setState(() {
                    mainController.virtualPriceController.text = val;
                  //});
                },
                hintText: "${currency(context).currencySymbol} 00.00",
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                textController: mainController.virtualPriceController,
              ),
            ),
          ],
        ),
    

        SizedBox(height: MediaQuery.of(context).size.height * 0.33),
        

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
                  duration: calculateDurationBetweenDates(mainController.selectedStartDate.value, mainController.selectedStopDate.value),
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