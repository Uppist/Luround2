import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_viewer/services_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import 'package:luround/utils/components/reusable_button.dart';
import 'package:luround/utils/components/title_text.dart';
import 'package:luround/utils/components/utils_textfield.dart';
import 'package:luround/views/account_viewer/services/widgets/request_quote/country_code_widget.dart';
import 'package:luround/views/account_viewer/services/widgets/request_quote/phone_number_textfield.dart';
import 'package:luround/views/account_viewer/services/widgets/request_quote/reusable_custom_textfield.dart';
import 'package:luround/views/account_viewer/services/widgets/request_quote/upload_file_widget.dart';
import 'radio_section.dart';






class RequestQuoteScreen extends StatefulWidget {
  RequestQuoteScreen({super.key});

  @override
  State<RequestQuoteScreen> createState() => _RequestQuoteScreenState();
}

class _RequestQuoteScreenState extends State<RequestQuoteScreen> {
  var controller = Get.put(AccViewerServicesController());

  @override
  void initState() {
    // Add a listener to the text controller
    controller.serviceNameController.addListener(() {
      setState(() {
        // Check if the text field is empty or not
        controller.isButtonEnabled.value = controller.serviceNameController.text.isNotEmpty;
      });
    });
    super.initState();
  }

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
        title: CustomAppBarTitle(text: 'Request Quote',),
      ),
      body: SafeArea(
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
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //SizedBox(height: 10,),
                    Form(
                      key: controller.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          UtilsTextField(  
                            onChanged: (val) {},
                            hintText: "Your name*",
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            textController: controller.nameController,
                          ),
                          SizedBox(height: 20.h),
                          UtilsTextField(  
                            onChanged: (val) {},
                            hintText: "Email*",
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            textController: controller.emailController,
                          ),
                          SizedBox(height: 20.h),
                          PhoneNumberTextField(
                            onChanged: (val) {},
                            countryCodeWidget: CountryCodeWidget(),
                            hintText: "Phone number*",
                            keyboardType: TextInputType.phone,
                            textInputAction: TextInputAction.next,
                            textController: controller.phoneNumberController,
                          ),
                          SizedBox(height: 30.h),
                          Text(
                            "Service name*",
                            style: GoogleFonts.poppins(
                              color: AppColor.blackColor,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          SizedBox(height: 10.h),
                          ReusableTextField(  
                            onChanged: (val) {},
                            hintText: "What service do you need ?",
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            textController: controller.serviceNameController,
                          ),
                          SizedBox(height: 30.h),
                          Text(
                            "Appointment type*",
                            style: GoogleFonts.poppins(
                              color: AppColor.blackColor,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          SizedBox(height: 20.h,),
                          //appoint radio widget
                          AppointmentType(),
                          SizedBox(height: 20.h,),
                          Text(
                            "Upload file (optional)",
                            style: GoogleFonts.inter(
                              color: AppColor.darkGreyColor,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          SizedBox(height: 30.h,),
                          UploadFileWidget(
                            onPressed: () {},
                          ),
                          SizedBox(height: 30,),
                          Text(
                            "Message (optional)",
                            style: GoogleFonts.inter(
                              color: AppColor.darkGreyColor,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          SizedBox(height: 10.h,),
                          ReusableTextField(  
                            onChanged: (val) {},
                            hintText: "Type a message",
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            textController: controller.messageController,
                          ),
                          SizedBox(height: 80.h,),
                          RebrandedReusableButton(
                            textColor: controller.isButtonEnabled.value ? AppColor.bgColor : AppColor.darkGreyColor,
                            color: controller.isButtonEnabled.value ? AppColor.mainColor : AppColor.lightPurple, 
                            text: "Submit", 
                            onPressed: controller.isButtonEnabled.value 
                            ? () {
                              //do sumething
                              print("tadaaaa");
                            } 
                            : () {},
                          ),
                          SizedBox(height: 20.h,),
                        ],
                        
                      ),
                    )
                  ]
                )
              )
              ////
            ]
          )
        )
      )
    );
  }
}