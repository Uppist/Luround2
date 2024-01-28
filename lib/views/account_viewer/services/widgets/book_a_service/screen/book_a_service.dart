import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_viewer/services_controller.dart';
import 'package:luround/models/account_owner/user_services/user_service_response_model.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/custom_snackbar.dart';
import 'package:luround/utils/components/title_text.dart';
import 'package:luround/views/account_viewer/services/widgets/book_a_service/booking_details/booking_details.dart';
import 'package:luround/views/account_viewer/services/widgets/book_a_service/step_tabs/step_1/step_1.dart';
import 'package:luround/views/account_viewer/services/widgets/book_a_service/step_tabs/step_2/step_2.dart';
import 'package:luround/views/account_viewer/services/widgets/book_a_service/step_tabs/step_3/step_3.dart';









class BookAppointmentScreen extends StatefulWidget {
  BookAppointmentScreen({super.key, required this.serviceId, required this.service_name, required this.date, required this.time, required this.duration, required this.service_charge_virtual, required this.service_charge_in_person, required this.avail_time, required this.service_provider_id});
  final String serviceId;
  final String service_name;
  final String service_provider_id;
  final String date;
  final String time;
  final String duration;
  final String service_charge_virtual;
  final String service_charge_in_person;
  final List<dynamic> avail_time;
   

  @override
  State<BookAppointmentScreen> createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  
  var controller = Get.put(AccViewerServicesController());

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
        title: CustomAppBarTitle(text: 'Book Appointment',),
      ),
      body: Stepper(
        physics: BouncingScrollPhysics(),
        elevation: 0,
        currentStep: controller.curentStep,
        /*onStepContinue: () {
          if(controller.curentStep < 2) {
            /*setState(() {
              controller.curentStep = controller.curentStep + 1;
            });*/
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
          if(controller.curentStep > 0) {
            setState(() {
              //controller.curentStep = value;
              controller.curentStep = controller.curentStep - 1;
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
              color: controller.curentStep >= stepIndex ? AppColor.mainColor : AppColor.textGreyColor.withOpacity(0.1),
            ),
            child: controller.curentStep >= stepIndex ?
              /*controller.curentStep == 0 ?*/ 
              Text(
                "${stepIndex + 1}",
                style: GoogleFonts.inter(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColor.bgColor
                )
              ) 
              /*:Icon(CupertinoIcons.check_mark, color: AppColor.bgColor, size: 15,)*/
            :Text(
              "${stepIndex + 1}",
              style: GoogleFonts.inter(
                fontSize: 12.sp,
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
            content: Step1Screen(
              service_name: widget.service_name,
              onSubmit: () {
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
            content: Step2Screen(
              onApply: () {
                /*if(controller.curentStep < 2) {
                  setState(() {
                    controller.curentStep = controller.curentStep + 1;
                  });
                  print("current step: ${controller.curentStep}");
                }*/
                LuroundSnackBar.successSnackBar(
                  message: "Date has been confirmed", 
                );
              },
              onSubmit: () {
                if(controller.curentStep < 2) {
                  setState(() {
                    controller.curentStep = controller.curentStep + 1;
                  });
                  print("current step: ${controller.curentStep}");
                }
              },
              onCancel: () {
                if(controller.curentStep < 2) {
                  setState(() {
                    controller.curentStep = controller.curentStep - 1;
                  });
                  print("current step: ${controller.curentStep}");
                }
              },
            ),
          ),
          Step(
            title: Text(""), 
            isActive: controller.curentStep >= 2,
            content: Step3Screen(
              avail_time: widget.avail_time,
              onSubmit: () {
                //save all details before getting to the next screen
                //booking details
                Get.to(() => BookingDetails(
                  service_provider_id: widget.service_provider_id,
                  serviceId: widget.serviceId,
                  service_name: widget.service_name,
                  date: widget.date,
                  time: widget.time,
                  duration: widget.duration,
                  service_charge_in_person: widget.service_charge_in_person,
                  service_charge_virtual: widget.service_charge_virtual,
                ));
              },
            ),
          )
        ]
      )
    );
  }
} 
  
//important section