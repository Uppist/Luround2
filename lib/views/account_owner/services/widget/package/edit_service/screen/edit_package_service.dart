import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services/package_service/package_service_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/title_text.dart';
import 'package:luround/views/account_owner/services/widget/package/edit_service/step_tabs/step_1/step_1_edit.dart';
import 'package:luround/views/account_owner/services/widget/package/edit_service/step_tabs/step_2/step_2_edit.dart';
import 'package:luround/views/account_owner/services/widget/package/edit_service/step_tabs/step_3/step_3_edit.dart';







class EditPackageServiceScreen extends StatefulWidget {
  EditPackageServiceScreen({
    super.key, 
    required this.serviceId,
    required this.service_name, 
    required this.description, 
    required this.links, 
    required this.service_charge_in_person, 
    required this.service_charge_virtual, 
    required this.duration, 
    required this.time, 
    required this.date, 
    required this.available_days
  });

  final String serviceId;
  final String service_name;
  final String description;
  final List<dynamic> links;
  final String service_charge_in_person;
  final String service_charge_virtual;
  final String duration;
  final String time;
  final String date;
  final String available_days;

  @override
  State<EditPackageServiceScreen> createState() => _EditPackageServiceScreenState();
}

class _EditPackageServiceScreenState extends State<EditPackageServiceScreen> {
  
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
          return Stepper(
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
              if(controller.curentStepEdit.value > 0) {
                setState(() {
                  //controller.curentStep = value;
                  controller.curentStepEdit.value = controller.curentStepEdit.value - 1;
                });
                print(value);
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
                content: Step1PagePackageServiceEdit(
                  serviceId: widget.serviceId,
                  service_name: widget.service_name,
                  description: widget.description,
                  links: widget.links,
                  service_charge_in_person: widget.service_charge_in_person,
                  service_charge_virtual: widget.service_charge_virtual,
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
                content: Step2PagePackageServiceEdit(
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
                content: Step3PagePackageServiceEdit(
                  /*serviceId: widget.serviceId,
                  service_name: widget.service_name,
                  description: widget.description,
                  links: widget.links,
                  service_charge_in_person: widget.service_charge_in_person,
                  service_charge_virtual: widget.service_charge_virtual,
                  duration: widget.duration,
                  time: widget.time,
                  date: widget.date,
                  available_days: widget.available_days,*/
                )
              )
            ]
          );
        }
      )
    );
  }
}