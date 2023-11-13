import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_viewer/services_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import 'package:luround/utils/components/utils_textfield.dart';
import 'package:luround/views/account_viewer/services/widgets/book_a_service/step_tabs/step_1/radio_section.dart';
import 'package:luround/views/account_viewer/services/widgets/request_quote/country_code_widget.dart';
import 'package:luround/views/account_viewer/services/widgets/request_quote/phone_number_textfield.dart';
import 'package:luround/views/account_viewer/services/widgets/request_quote/reusable_custom_textfield.dart';








class Step1Screen extends StatefulWidget {
  Step1Screen({super.key, required this.onSubmit});
  final VoidCallback onSubmit;

  @override
  State<Step1Screen> createState() => _Step1ScreenState();
}

class _Step1ScreenState extends State<Step1Screen> {

  var controller = Get.put(AccViewerServicesController());

  @override
  void initState() {
    // Add a listener to the text controller
    controller.serviceNameBAController.addListener(() {
      setState(() {
        // Check if the text field is empty or not
        controller.isButtonEnabled2.value = controller.serviceNameBAController.text.isNotEmpty;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKeyBA,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UtilsTextField(  
            onChanged: (val) {},
            hintText: "Your name*",
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            textController: controller.nameBAController,
          ),
          SizedBox(height: 20.h),
          UtilsTextField(  
            onChanged: (val) {},
            hintText: "Email*",
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            textController: controller.emailBAController,
          ),
          SizedBox(height: 20.h),
          PhoneNumberTextField(
            onChanged: (val) {},
            countryCodeWidget: CountryCodeWidget(),
            hintText: "Phone number*",
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            textController: controller.phoneNumberBAController,
          ),
          SizedBox(height: 30.h),
          Text(
            "Service name*",
            style: GoogleFonts.inter(
              color: AppColor.blackColor,
              fontSize: 13.sp,
              fontWeight: FontWeight.w500
            ),
          ),
          SizedBox(height: 10),
          ReusableTextField(  
            onChanged: (val) {},
            hintText: "What service do you need ?",
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            textController: controller.serviceNameBAController,
          ),
          SizedBox(height: 30.h),
          Text(
            "Appointment type*",
            style: GoogleFonts.inter(
              color: AppColor.blackColor,
              fontSize: 13.sp,
              fontWeight: FontWeight.w500
            ),
          ),
          SizedBox(height: 20.h,),
          //appoint radio widget
          AppointmentTypeBA(),
          SizedBox(height: 20.h,),
          Text(
            "Message (optional)",
            style: GoogleFonts.inter(
              color: AppColor.darkGreyColor,
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
            hintText: "Any additional information you would like us to have.",
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
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500
                ),
              ),
            ],
          ),
          SizedBox(height: 90.h,),
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
      ),
    );            
              
  }
}
      
    
