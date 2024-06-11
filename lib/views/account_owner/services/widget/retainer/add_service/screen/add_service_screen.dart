import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services/retainer/retainer_service_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/title_text.dart';
import 'package:luround/views/account_owner/services/widget/retainer/add_service/step_tabs/step_1/step_1.dart';
import 'package:luround/views/account_owner/services/widget/retainer/add_service/step_tabs/step_2/step_2.dart';
import 'package:luround/views/account_owner/services/widget/retainer/add_service/step_tabs/step_3/step_3.dart';










class AddPackageServiceScreen extends StatefulWidget {
  const AddPackageServiceScreen({super.key});

  @override
  State<AddPackageServiceScreen> createState() => _AddPackageServiceScreenState();
}

class _AddPackageServiceScreenState extends State<AddPackageServiceScreen> {
  
  final controller = Get.put(PackageServiceController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.bgColor,
        leading: IconButton(
          onPressed: () {
            if(controller.curentStep > 0) {
              setState(() {
                //controller.curentStep = value;
                controller.curentStep = controller.curentStep - 1;
              });
              print(controller.curentStep);
            }
            else if(controller.curentStep == 0) {
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
        physics: BouncingScrollPhysics(),
        elevation: 0,
        currentStep: controller.curentStep,
        onStepTapped: (int value) {
          if(controller.curentStep > 0) {
            setState(() {
              //controller.curentStep = value;
              controller.curentStep = controller.curentStep - 1;
            });
            log("$value");
          }
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
              color: controller.curentStep >= stepIndex ? AppColor.mainColor : AppColor.textGreyColor.withOpacity(0.1),
            ),
            child: controller.curentStep >= stepIndex ?
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
            content: Step1PagePackageService (
              onNext: () {
                if(controller.curentStep < 2) {
                  setState(() {
                    controller.curentStep = controller.curentStep + 1;
                  });
                  print("current step: ${controller.curentStep}");
                }
              },
            ),
            isActive: controller.curentStep >= 0,
          ),
          Step(
            title: Text(""), 
            isActive: controller.curentStep >= 1,
            content: Step2PagePackageService (
              /*onNext: () {
                if(controller.curentStep < 2) {
                  setState(() {
                    controller.curentStep = controller.curentStep + 1;
                  });
                  print("current step: ${controller.curentStep}");
                }
              },*/
            )
          ),
          Step(
            title: Text(""), 
            isActive: controller.curentStep >= 2,
            content: Step3PagePackageService ()
          )
        ]
      )
      
    
    );
  }
} 
  
