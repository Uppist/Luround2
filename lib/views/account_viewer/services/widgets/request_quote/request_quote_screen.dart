import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_viewer/services_controller.dart';
import 'package:luround/services/account_viewer/services/get_user_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/loader.dart';
import 'package:luround/utils/components/my_snackbar.dart';
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
  RequestQuoteScreen({super.key, required this.service_name, required this.service_provider_name, required this.service_provider_email, required this.service_id});
  final String service_name;
  final String service_id;
  final String service_provider_name;
  final String service_provider_email;

  @override
  State<RequestQuoteScreen> createState() => _RequestQuoteScreenState();
}

class _RequestQuoteScreenState extends State<RequestQuoteScreen> {

  var controller = Get.put(AccViewerServicesController());
  var service = Get.put(AccViewerService());

  /*@override
  void initState() {
    // Add a listener to the text controller
    controller.serviceNameController.addListener(() {
      setState(() {
        // Check if the text field is empty or not
        controller.isButtonEnabled.value = controller.serviceNameController.text.isNotEmpty;
      });
    });
    super.initState();
  }*/

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
      body: SingleChildScrollView(
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
                      Column(
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
                                controller.nameController.text = val;
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
                                controller.emailController.text = val;
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
                            countryCodeWidget: CountryCodeWidget(),
                            hintText: "Your phone number",
                            keyboardType: TextInputType.phone,
                            textInputAction: TextInputAction.next,
                            textController: controller.phoneNumberController,
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
                          SizedBox(height: 10.h),
                          UtilsTextField2(  
                            onChanged: (val) {
                              setState(() {
                                controller.serviceNameController.text = val;
                              });
                            },
                            hintText: "Enter service name",
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
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
                          AppointmentType(),
                          SizedBox(height: 30.h),
                          Text(
                            "Your budget/offer",
                            style: GoogleFonts.inter(
                              color: AppColor.blackColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          SizedBox(height: 10.h),
                          ReusableTextField(  
                            onChanged: (val) {},
                            hintText: "0.00",
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.done,
                            textController: controller.offerController,
                          ),

                          SizedBox(height: 30.h),    

                          Text(
                            "Upload file (optional)",
                            style: GoogleFonts.inter(
                              color: AppColor.blackColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          /////////////////
                          SizedBox(height: 30.h,),
                          Obx(
                            () {
                              return controller.isFileUploaded.value ?
                                UploadedFileWidget(
                                  onDelete: () {
                                    //setState(() {
                                      controller.selectedFileForRequestingQuote.value = null;
                                      controller.isFileUploaded.value  = false;
                                    //});
                                    },
                                  )
                                  :UploadFileWidget(
                                    onPressed: () {
                                    controller.selectFile(context);
                                  },
                                );
                              }
                          ),
                          SizedBox(height: 30,),
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
                            onChanged: (val) {},
                            hintText: "Any additional information you would like to add",
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            textController: controller.messageController,
                          ),
                          SizedBox(height: 80.h,),
                          Obx(
                            () {
                              return service.isLoading.value ? Loader() : RebrandedReusableButton(
                                textColor: AppColor.bgColor,
                                color: AppColor.mainColor, 
                                text:  "Submit", 
                                onPressed: () {
                                  if(
                                    controller.nameController.text.isNotEmpty 
                                    && controller.emailController.text.isNotEmpty 
                                    && controller.phoneNumberController.text.isNotEmpty
                                    && controller.offerController.text.isNotEmpty
                                    && controller.code.value.isNotEmpty
                                  ) {
                                    //do sumething
                                    service.requestQuote(
                                      context: context, 
                                      service_id: widget.service_id, 
                                      offer: controller.offerController.text, 
                                      uploaded_file: controller.fileUrl.value, 
                                      appointment_type: controller.apppointment,
                                      client_name: controller.nameController.text, 
                                      client_email: controller.emailController.text, 
                                      client_phone_number: "${controller.code.value} ${controller.phoneNumberController.text}", 
                                      client_note: controller.messageController.text.isNotEmpty ? controller.messageController.text : "(non)",
                                    ).whenComplete(() {
                                      controller.nameController.clear();
                                      controller.emailController.clear();
                                      controller.phoneNumberController.clear();
                                      controller.serviceNameController.clear();
                                      controller.messageController.clear();
                                      controller.offerController.clear();
                                      controller.selectedFileForRequestingQuote.value = null;
                                      controller.isFileUploaded.value  = false;
                                      Get.back();
                                    });
                                  }
                                  else if(controller.code.value.isEmpty) {
                                    showMySnackBar(
                                      context: context,
                                      backgroundColor: AppColor.redColor,
                                      message: "please select country code"
                                    );
                                  }
                                  else if(controller.apppointment.isEmpty) {
                                    showMySnackBar(
                                      context: context,
                                      backgroundColor: AppColor.redColor,
                                      message: "please select an appointment type"
                                    );
                                  }
                                  else {
                                    showMySnackBar(
                                      context: context,
                                      backgroundColor: AppColor.redColor,
                                      message: "fields must not be empty"
                                    );
                                  }
                                  
                                } 
                                                
                              );
                            }
                          ),
                          SizedBox(height: 20.h,),
                        ],
                        
                      )
                    ]
                  )
                )
                ////
              ]
            )
          )
        
    
    );
  }
}