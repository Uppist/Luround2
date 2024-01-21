import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_viewer/services_controller.dart';
import 'package:luround/services/account_viewer/services/get_user_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/loader.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import 'package:luround/utils/components/title_text.dart';
import 'package:luround/views/account_viewer/services/widgets/book_a_service/booking_details/custom_text_row.dart';
import 'package:luround/views/account_viewer/services/widgets/book_a_service/payment_folder/payment_screen.dart';







class BookingDetails extends StatelessWidget {
  BookingDetails({super.key, required this.serviceId, required this.service_name, required this.date, required this.time, required this.service_charge_virtual, required this.service_charge_in_person, required this.duration, required this.service_provider_id});
  final String serviceId;
  final String service_name;
  final String date;
  final String time;
  final String duration;
  final String service_charge_virtual;
  final String service_charge_in_person;
  final String service_provider_id;

  var controller = Get.put(AccViewerServicesController());
  var service = Get.put(AccViewerService());

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
        title: CustomAppBarTitle(text: 'Back',),
      ),
      body: Obx(
        () {
          return service.isLoading.value ? Loader() : SafeArea(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 10.h),
                  Container(
                    color: AppColor.greyColor,
                    width: double.infinity,
                    height: 7.h,
                  ),
                  SizedBox(height: 20.h,),
                  //important section
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //SizedBox(height: 10,),
                        Center(
                          child: Text(
                            "Booking Details",
                            style: GoogleFonts.inter(
                              color: AppColor.blackColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                        ),
          
                        SizedBox(height: 20.h,),
          
                        CustomTextRow(
                          leftText: "Name",
                          rightText: controller.nameBAController.text,
                        ),
                        Divider(color: AppColor.textGreyColor, thickness: 0.2),
                        SizedBox(height: 10.h,),
          
                        CustomTextRow(
                          leftText: "Email",
                          rightText: controller.emailBAController.text,
                        ),
                        Divider(color: AppColor.textGreyColor, thickness: 0.2),
                        SizedBox(height: 10.h,),
          
                        CustomTextRow(
                          leftText: "Phone number",
                          rightText: "${controller.codeBA} ${controller.phoneNumberBAController.text}",
                        ),
                        Divider(color: AppColor.textGreyColor, thickness: 0.2),
                        SizedBox(height: 10.h,),
          
                        CustomTextRow(
                          leftText: "Service name",
                          rightText: service_name
                        ),
                        Divider(color: AppColor.textGreyColor, thickness: 0.2),
                        SizedBox(height: 10.h,),
          
                        CustomTextRow(
                          leftText: "Date",
                          rightText: controller.getDate(initialDate: date)
                        ),
                        Divider(color: AppColor.textGreyColor, thickness: 0.2),
                        SizedBox(height: 10.h,),
          
                        CustomTextRow(
                          leftText: "Time",
                          rightText: controller.selectedTime.isNotEmpty ? controller.selectedTime.value : time
                        ),
                        Divider(color: AppColor.textGreyColor, thickness: 0.2),
                        SizedBox(height: 10.h,),
          
                        CustomTextRow(
                          leftText: "Duration",
                          rightText: duration
                        ),
                        Divider(color: AppColor.textGreyColor, thickness: 0.2),
                        SizedBox(height: 10.h,),
          
                        CustomTextRow(
                          leftText: "Appointment type",
                          rightText: controller.step1Appointment
                        ),
                        Divider(color: AppColor.textGreyColor, thickness: 0.2),
                        SizedBox(height: 10.h,),
          
                        CustomTextRow(
                          leftText: "Service fee",
                          rightText: controller.isVirtual.value  
                          ? "N$service_charge_virtual" 
                          : "N$service_charge_in_person"
                        ),
                        Divider(color: AppColor.textGreyColor, thickness: 0.2),
                        SizedBox(height: 10.h,),
          
                        /*ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: NeverScrollableScrollPhysics(),
                          //padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                          itemCount: 10,
                          separatorBuilder: (context, index) => Divider(color: AppColor.textGreyColor, thickness: 0.2), 
                          itemBuilder: (context, index) {
                            return CustomTextRow(
                              leftText: "name",
                              rightText: "Japhet Alvin",
                            );
                          },
                        ),*/
          
                        SizedBox(height: 20.h,),
                        Text(
                          "Message",
                          style: GoogleFonts.inter(
                            color: AppColor.blackColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        SizedBox(height: 20.h,),
                        Text(
                          controller.messageBAController.text.isEmpty ? "(no message)" : controller.messageBAController.text,
                          style: GoogleFonts.inter(
                            color: AppColor.blackColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400
                          ),
                        ),
                        SizedBox(height: 70.h,),
                        RebrandedReusableButton(
                          textColor: AppColor.bgColor,
                          color: AppColor.mainColor,
                          text: "Proceed to payment", 
                          onPressed: () {
                            //amount of service as argument
                            Get.to(() => PaymentScreen(
                              service_provider_id: service_provider_id,
                              date: date,
                              serviceId: serviceId,
                              service_name: service_name,
                              time: time,
                              duration: duration,
                              amount: controller.isVirtual.value 
                              ? service_charge_virtual
                              : service_charge_in_person
                            ));
                            
                            /*service.bookUserService(
                              context: context, 
                              name: controller.nameBAController.text, 
                              email: controller.emailBAController.text.trim(), 
                              service_name: service_name,                  
                              serviceId: serviceId, 
                              phone_number: "${controller.codeBA} ${controller.phoneNumberBAController.text}", 
                              appointment_type: controller.step1Appointment, 
                              date: controller.getDate(initialDate: date), 
                              time: time, //controller.getTime()
                              duration: duration, 
                              message: controller.messageBAController.text.isEmpty ? "(no message)" : controller.messageBAController.text, 
                              location: controller.step1Appointment == 'Virtual' 
                              ?"The location for this service is set to be virtual." 
                              :"The location for this service is set to be physical."
                            )
                            .whenComplete(() {
                              print("booking successfully completed");
                            });*/

                          },
                        ),
                        SizedBox(height: 10.h,),
                      ]
                    )
                  )
                ]
              )
            )
          );
        }
      )
    );
  }
}