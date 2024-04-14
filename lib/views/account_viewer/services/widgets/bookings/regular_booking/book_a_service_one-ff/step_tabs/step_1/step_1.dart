import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_viewer/services_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import 'package:luround/utils/components/utils_textfield.dart';
import 'package:luround/views/account_viewer/services/widgets/bookings/regular_booking/book_a_service_one-ff/step_tabs/step_1/countrycode_ba.dart';
import 'package:luround/views/account_viewer/services/widgets/bookings/regular_booking/book_a_service_one-ff/step_tabs/step_1/radio_section.dart';
import 'package:luround/views/account_viewer/services/widgets/request_quote/phone_number_textfield.dart';
import 'package:luround/views/account_viewer/services/widgets/request_quote/reusable_custom_textfield.dart';








class Step1Screen extends StatefulWidget {
  Step1Screen({super.key, required this.onSubmit, required this.service_name, required this.service_charge_virtual, required this.service_charge_inperson});
  final VoidCallback onSubmit;
  final String service_name;
  final String service_charge_virtual;
  final String service_charge_inperson;

  @override
  State<Step1Screen> createState() => _Step1ScreenState();
}

class _Step1ScreenState extends State<Step1Screen> {

  var controller = Get.put(AccViewerServicesController());

  @override
  void initState() {
    // Add a listener to the text controller
    controller.nameBAController.addListener(() {
      setState(() {
        // Check if the text field is empty or not
        controller.isButtonEnabled2.value = controller.nameBAController.text.isNotEmpty;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Full name*",
          style: GoogleFonts.inter(
            color: AppColor.blackColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500
          ),
        ),
        SizedBox(height: 10.h,),
        UtilsTextField2(  
          onChanged: (val) {
            setState(() {
              controller.nameBAController.text = val;
            });
          },
          hintText: "Your name",
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
          initialValue: '',
        ),
        SizedBox(height: 30.h),
        Text(
          "Email address*",
          style: GoogleFonts.inter(
            color: AppColor.blackColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500
          ),
        ),
        SizedBox(height: 10.h,),
        UtilsTextField2(  
          onChanged: (val) {
            setState(() {
              controller.emailBAController.text = val;
            });
          },
          hintText: "Your email address",
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          initialValue: '',
        ),
        SizedBox(height: 30.h),
        Text(
          "Phone number",
          style: GoogleFonts.inter(
            color: AppColor.blackColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500
          ),
        ),
        SizedBox(height: 10.h,),
        PhoneNumberTextField(
          onChanged: (val) {},
          countryCodeWidget: CountryCodeWidgetBA(),
          hintText: "Your phone number",
          keyboardType: TextInputType.phone,
          textInputAction: TextInputAction.next,
          textController: controller.phoneNumberBAController,
        ),
        SizedBox(height: 30.h),
        Text(
          "Service name",
          style: GoogleFonts.inter(
            color: AppColor.blackColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500
          ),
        ),
        SizedBox(height: 10),
        ReusableTextField2(  
          onChanged: (val) {
            setState(() {
              controller.serviceNameBAController.text = val;
            });
          },
          hintText: "Enter service name",
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.done,
          initialValue: widget.service_name,
        ),
        SizedBox(height: 30.h),
        Text(
          "Appointment type*",
          style: GoogleFonts.inter(
            color: AppColor.blackColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500
          ),
        ),
        SizedBox(height: 20.h,),
        //appoint radio widget
        AppointmentTypeBA(
          service_charge_inperson: widget.service_charge_inperson,
          service_charge_virtual: widget.service_charge_virtual,
        ),
        SizedBox(height: 20.h,),
        Text(
          "Note (optional)",
          style: GoogleFonts.inter(
            color: AppColor.blackColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500
          ),
        ),
        SizedBox(height: 10.h,),
        ReusableTextField(  
          onChanged: (val) {
            // Check if character count exceeds the maximum
            if (val.length > controller.maxLength) {
              // Remove extra characters        
              controller.messageBAController.text = val.substring(0, controller.maxLength);
              debugPrint("you have reached max length");
            } 
            setState(() {}); // Update the UI
          },
          hintText: "Any additional information you would like to add.",
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.done,
          textController: controller.messageBAController,
        ),
        SizedBox(height: 20.h,),
        //max length for message textfield
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "${controller.messageBAController.text.length}/${controller.maxLength}",
              style: GoogleFonts.inter(
                color: AppColor.textGreyColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400
              ),
            ),
          ],
        ),
        
        //sizedbox_height
        SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
        
        RebrandedReusableButton(
          textColor: controller.isButtonEnabled2.value ? AppColor.bgColor : AppColor.darkGreyColor,
          color: controller.isButtonEnabled2.value ? AppColor.mainColor : AppColor.lightPurple, 
          text: "Next", 
          onPressed: controller.isButtonEnabled2.value ? 
          widget.onSubmit
          : () {
            print('nothing');
          },
        ),
        SizedBox(height: 5.h,),
    
      ],                     
    );            
              
  }
}
      
    
