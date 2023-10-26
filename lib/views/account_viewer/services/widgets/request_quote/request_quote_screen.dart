import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_viewer/services_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import 'package:luround/utils/components/reusable_button.dart';
import 'package:luround/utils/components/title_text.dart';
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
              SizedBox(height: 10),
              Container(
                color: AppColor.greyColor,
                width: double.infinity,
                height: 7,
              ),
              SizedBox(height: 20,),
              //important section
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //SizedBox(height: 10,),
                    Form(
                      key: controller.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ReusableTextField(  
                            onChanged: (val) {},
                            hintText: "Your name*",
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            textController: controller.nameController,
                          ),
                          SizedBox(height: 20),
                          ReusableTextField(  
                            onChanged: (val) {},
                            hintText: "Email*",
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            textController: controller.emailController,
                          ),
                          SizedBox(height: 20),
                          PhoneNumberTextField(
                            onChanged: (val) {},
                            countryCodeWidget: CountryCodeWidget(),
                            hintText: "Phone number*",
                            keyboardType: TextInputType.phone,
                            textInputAction: TextInputAction.next,
                            textController: controller.phoneNumberController,
                          ),
                          SizedBox(height: 30),
                          Text(
                            "Service name*",
                            style: GoogleFonts.poppins(
                              color: AppColor.blackColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          SizedBox(height: 10),
                          ReusableTextField(  
                            onChanged: (val) {},
                            hintText: "What service do you need ?",
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            textController: controller.serviceNameController,
                          ),
                          SizedBox(height: 30),
                          Text(
                            "Appointment type*",
                            style: GoogleFonts.poppins(
                              color: AppColor.blackColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          SizedBox(height: 20,),
                          //appoint radio widget
                          AppointmentType(),
                          SizedBox(height: 20,),
                          Text(
                            "Upload file (optional)",
                            style: GoogleFonts.poppins(
                              color: AppColor.darkGreyColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          SizedBox(height: 30,),
                          UploadFileWidget(
                            onPressed: () {},
                          ),
                          SizedBox(height: 30,),
                          Text(
                            "Message (optional)",
                            style: GoogleFonts.poppins(
                              color: AppColor.darkGreyColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          SizedBox(height: 10,),
                          ReusableTextField(  
                            onChanged: (val) {},
                            hintText: "Type a message",
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            textController: controller.messageController,
                          ),
                          SizedBox(height: 80,),
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
                          SizedBox(height: 20,),
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