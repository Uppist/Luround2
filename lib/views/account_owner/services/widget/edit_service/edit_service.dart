import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/title_text.dart';
import 'package:luround/views/account_owner/services/widget/edit_service/step_tabs/step_1/step_1_edit.dart';
import 'package:luround/views/account_owner/services/widget/edit_service/step_tabs/step_2/step_2_edit.dart';
import 'package:luround/views/account_owner/services/widget/edit_service/step_tabs/step_3/step_3_edit.dart';








class EditServiceScreen extends GetView<ServicesController> {
  EditServiceScreen({super.key});

  //final ServicesController serviceController = ServicesController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.bgColor,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            color: AppColor.blackColor,
          )
        ),
        title: CustomAppBarTitle(text: 'Edit Service',),
      ),
      body: Obx(
        () {
          return SafeArea(
            child: Stepper(
              physics: BouncingScrollPhysics(),
              elevation: 0,
              currentStep: controller.curentStepEdit.value,
              /*onStepContinue: () {
                if(controller.curentStep < 2) {
                  setState(() {
                    controller.curentStep = controller.curentStep + 1;
                  });
                }
              },
              onStepCancel: () {
                if(controller.curentStep <= 2) {
                  setState(() {
                    controller.curentStep = controller.curentStep - 1;
                  });
                }
              },*/
              onStepTapped: (int value) {              
                controller.curentStepEdit.value = value;
                print(value);
              },
              controlsBuilder: (context, details) {
                return SizedBox();
              },
              stepIconBuilder: (stepIndex, stepState) {
                return Container(
                  alignment: Alignment.center,
                  //padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(40.r)),
                    //this maths logic i did here is the GOAT
                    color: controller.curentStepEdit.value >= stepIndex ? AppColor.mainColor : AppColor.textGreyColor.withOpacity(0.1),
                  ),
                  child: controller.curentStepEdit.value >= stepIndex ?
                    /*controller.curentStep == 0 ?*/ 
                    Text(
                      "${stepIndex + 1}",
                      style: GoogleFonts.inter(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColor.bgColor
                      )
                    ) 
                    /*:Icon(CupertinoIcons.check_mark, color: AppColor.bgColor, size: 15,)*/
                  :Text(
                    "${stepIndex + 1}",
                    style: GoogleFonts.inter(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColor.bgColor
                    )
                  )
            
                );
              },
              type: StepperType.horizontal,
              steps: [
                Step(
                  title: Text(""), 
                  content: Step1PageEdit(
                    onNext: () {
                      if(controller.curentStepEdit.value < 2) {                  
                        controller.curentStepEdit.value = controller.curentStepEdit.value + 1;                 
                        print("current step: ${controller.curentStepEdit.value}");
                      }
                    },
                  ),
                  isActive: controller.curentStepEdit.value >= 0,
                ),
                Step(
                  title: Text(""), 
                  isActive: controller.curentStepEdit.value >= 1,
                  content: Step2PageEdit(
                    onNext: () {
                      if(controller.curentStepEdit.value < 2) {             
                        controller.curentStepEdit.value = controller.curentStepEdit.value + 1;
                        print("current step: ${controller.curentStepEdit.value}");
                      }
                    },
                  )
                ),
                Step(
                  title: Text(""), 
                  isActive: controller.curentStepEdit.value >= 2,
                  content: Step3PageEdit(
                    serviceId: "",
                  )
                )
              ]
            ),
          );
        }
      )
    );
  }
}