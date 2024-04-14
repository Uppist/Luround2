import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_viewer/services_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/custom_snackbar.dart';
import 'package:luround/utils/components/title_text.dart';
import 'package:luround/views/account_viewer/services/widgets/bookings/regular_booking/book_a_service_retainer/booking_details/booking_details.dart';
import 'package:luround/views/account_viewer/services/widgets/bookings/regular_booking/book_a_service_retainer/step_tabs/step_1/step_1.dart';
import 'package:luround/views/account_viewer/services/widgets/bookings/regular_booking/book_a_service_retainer/step_tabs/step_2/step_2.dart';









class BookAppointmentScreenRegularRetainer extends StatefulWidget {
  const BookAppointmentScreenRegularRetainer({super.key, required this.serviceId, required this.service_name, required this.service_provider_id, required this.date, required this.time, required this.service_timeline, required this.service_charge_virtual, required this.service_charge_in_person,});
  final String serviceId;
  final String service_name;
  final String service_provider_id;
  final String date;
  final String time;
  final String service_timeline;
  final String service_charge_virtual;
  final String service_charge_in_person;

   

  @override
  State<BookAppointmentScreenRegularRetainer> createState() => _BookAppointmentScreenRegularRetainerState();
}

class _BookAppointmentScreenRegularRetainerState extends State<BookAppointmentScreenRegularRetainer> {
  
  var controller = Get.put(AccViewerServicesController());

  @override
  Widget build(BuildContext context) {


    // Get the arguments using Get.arguments
    /*final Map<String, dynamic> arguments = Get.arguments;
    final String serviceId = arguments['serviceId'];
    final String service_name = arguments['service_name'];
    final String service_provider_id = arguments['service_provider_id'];
    final String date = arguments['date'];
    final String time = arguments['time'];
    final String duration = arguments['duration'];
    final String service_charge_virtual = arguments['service_charge_virtual'];
    final String service_charge_in_person = arguments['service_charge_in_person'];
    final List<dynamic> avail_time = arguments['avail_time'];*/


    return Scaffold(
      backgroundColor: AppColor.bgColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColor.bgColor,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_rounded,
            color: AppColor.blackColor,
          )
        ),
        title: CustomAppBarTitle(text: 'Book Appointment',),
      ),
      body: Stepper(
        physics: const BouncingScrollPhysics(),
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
          return const SizedBox();
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
            title: const Text(""), 
            content: Step1Screen(
              service_name: widget.service_name,
              service_charge_inperson: widget.service_charge_in_person,
              service_charge_virtual: widget.service_charge_virtual,
              onSubmit: () {
                if(controller.curentStep < 1) {
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
            title: const Text(""), 
            isActive: controller.curentStep >= 1,
            content: Step2Screen(
              onApply: () {
                LuroundSnackBar.successSnackBar(
                  message: "date has been confirmed", 
                );
              },
              onCancel: () {
                if(controller.curentStep <= 1) { //<
                  setState(() {
                    controller.curentStep = controller.curentStep - 1;
                  });
                  print("current step: ${controller.curentStep}");
                }
              },
              onSubmit: () {
                //save all details before getting to the next screen
                //booking details
                Get.to(
                  () => BookingDetailsRegularRetainer(
                    service_provider_id: widget.service_provider_id,
                    serviceId: widget.serviceId,
                    service_name: widget.service_name,
                    date: widget.date,
                    time: widget.time,
                    service_timeline: widget.service_timeline,
                    service_charge_in_person: widget.service_charge_in_person,
                    service_charge_virtual: widget.service_charge_virtual,
                  ),
                  transition: Transition.rightToLeft               
                );
              },
            ),
          ),
          
        ]
      )
    );
  }
} 
  
//important section