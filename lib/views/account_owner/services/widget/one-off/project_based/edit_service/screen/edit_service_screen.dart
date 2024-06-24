import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services/one-off/oneoff_service_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/title_text.dart';
import 'package:luround/views/account_owner/services/widget/one-off/project_based/edit_service/step_tabs/step_1/step_1.dart';
import 'package:luround/views/account_owner/services/widget/one-off/project_based/edit_service/step_tabs/step_3/step_3.dart';










class EditProjectBasedOneOffServiceScreen extends StatefulWidget {
  const EditProjectBasedOneOffServiceScreen ({super.key, required this.serviceId, required this.serviceName, required this.description, required this.price});
  final String serviceId;
  final String serviceName;
  final String description;
  final String price;

  @override
  State<EditProjectBasedOneOffServiceScreen > createState() => _EditProjectBasedOneOffServiceScreenState();
}

class _EditProjectBasedOneOffServiceScreenState extends State<EditProjectBasedOneOffServiceScreen> {
  
  final controller = Get.put(ServicesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.bgColor,
        leading: IconButton(
          onPressed: () {
            if(controller.curentStepEdit > 0) {
              setState(() {
                controller.curentStepEdit.value = controller.curentStepEdit.value - 1;
              });
              print(controller.curentStepEdit.value);
            }
            else if(controller.curentStepEdit.value == 0) {
              Get.back();
            }
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            color: AppColor.blackColor,
          )
        ),
        title: const CustomAppBarTitle(text: 'Add service',),
      ),
      body: Stepper(
        physics: const BouncingScrollPhysics(),
        elevation: 0,
        currentStep: controller.curentStepEdit.value,
        /*onStepContinue: () {
          if(controller.curentStep < 2) {
            setState(() {
              controller.curentStep = controller.curentStep + 1;
            });
          }
        },*/
        /*onStepCancel: () {
          if(controller.curentStep <= 2) {
            setState(() {
              controller.curentStep = controller.curentStep - 1;
            });
          }
        },*/
        onStepTapped: (int value) {
          if(controller.curentStepEdit.value > 0) {
            setState(() {
              //controller.curentStep = value;
              controller.curentStepEdit.value = controller.curentStepEdit.value - 1;
            });
            log('$value');
          }
        },
        controlsBuilder: (context, details) {
          return const SizedBox();
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
            title: const Text(""), 
            content: Step1PageOPBEdit(
              onNext: () {
                if(controller.curentStepEdit.value < 2) {
                  setState(() {
                    controller.curentStepEdit.value = controller.curentStepEdit.value + 1;
                  });
                  log("current step: ${controller.curentStepEdit.value}");
                }
              },
              serviceName: widget.serviceName,
              description: widget.description,
              price: widget.price,
            ),
            isActive: controller.curentStepEdit.value >= 0,
          ),
          Step(
            title: const Text(""), 
            isActive: controller.curentStepEdit.value >= 1,
            content: Step3PageOPBEdit(
              serviceId: widget.serviceId,
            )
          ),
        ]
      )
    );
  }
} 
  
