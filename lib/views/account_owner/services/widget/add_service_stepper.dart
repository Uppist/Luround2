import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/custom_snackbar.dart';
import 'package:luround/utils/components/title_text.dart';
import 'package:luround/views/account_owner/services/widget/step_tabs/step_2/step_2.dart';
import 'package:luround/views/account_owner/services/widget/step_tabs/step_3/step_3.dart';
import 'step_tabs/step_1/step_1.dart';









class AddServiceScreen extends StatefulWidget {
  AddServiceScreen({super.key});

  @override
  State<AddServiceScreen> createState() => _AddServiceScreenState();
}

class _AddServiceScreenState extends State<AddServiceScreen> {
  
  var controller = Get.put(ServicesController());

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
        title: CustomAppBarTitle(text: 'Add Service',),
      ),
      body: SafeArea(
        child: Stepper(
          physics: BouncingScrollPhysics(),
          elevation: 0,
          currentStep: controller.curentStep,
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
            setState(() {
              controller.curentStep = value;
            });
            print(value);
          },
          controlsBuilder: (context, details) {
            return SizedBox();
          },
          stepIconBuilder: (stepIndex, stepState) {
            return Container(
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40)),
                //this maths logic i did here is the GOAT
                color: controller.curentStep >= stepIndex ? AppColor.mainColor : AppColor.textGreyColor.withOpacity(0.1),
              ),
              child: controller.curentStep >= stepIndex ?
                /*controller.curentStep == 0 ?*/ 
                Text(
                  "${stepIndex + 1}",
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppColor.bgColor
                  )
                ) 
                /*:Icon(CupertinoIcons.check_mark, color: AppColor.bgColor, size: 15,)*/
              :Text(
                "${stepIndex + 1}",
                style: GoogleFonts.poppins(
                  fontSize: 13,
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
              content: Step1Page(
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
              content: Step2Page(
                onNext: () {
                  if(controller.curentStep < 2) {
                    setState(() {
                      controller.curentStep = controller.curentStep + 1;
                    });
                    print("current step: ${controller.curentStep}");
                  }
                },
              )
            ),
            Step(
              title: Text(""), 
              isActive: controller.curentStep >= 2,
              content: Step3Page(
                onNext: () {},
              )
            )
          ]
        ),
      )
    );
  }
} 
  
//important section