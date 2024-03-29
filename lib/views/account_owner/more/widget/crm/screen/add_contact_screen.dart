import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/services/account_owner/more/crm/crm_service.dart';
import 'package:luround/services/account_owner/profile_service/user_profile_service.dart';
import 'package:luround/utils/components/loader.dart';
import 'package:luround/utils/components/my_snackbar.dart';
import 'package:luround/views/account_owner/more/widget/crm/widget/contact_textfield.dart';
import '../../../../../../controllers/account_owner/profile/profile_page_controller.dart';
import '../../../../../../utils/colors/app_theme.dart';
import '../../../../../../utils/components/reusable_button.dart';
import '../../../../../../utils/components/title_text.dart';









class AddContactScreen extends StatefulWidget {
  AddContactScreen({super.key,});

  @override
  State<AddContactScreen> createState() => _AddContactScreenState();
}

class _AddContactScreenState extends State<AddContactScreen> {

  var service = Get.put(CRMService());

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
        title: CustomAppBarTitle(text: 'Add new contact',),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 10.h),
          Container(
            color: AppColor.greyColor,
            width: double.infinity,
            height: 7.h,
          ),
          SizedBox(height: 20.h,),
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //name of client
                    Text(
                      'Name',
                      style: GoogleFonts.inter(
                        color: AppColor.blackColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500
                      )
                    ),
                    SizedBox(height: 20.h),
                    ContactTextField(
                      onChanged: (val) {
                        setState(() {
                          service.contactNameController.text = val;
                        });                 
                      },
                      initialValue: "",
                      hintText: 'Your contact name',
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,                   
                    ),
                    SizedBox(height: 30.h),
                    //name of client
                    Text(
                      'Email Address',
                      style: GoogleFonts.inter(
                        color: AppColor.blackColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500
                      )
                    ),
                    SizedBox(height: 20.h),
                    //email of client
                    ContactTextField(
                      onChanged: (val) {
                        setState(() {
                          service.contactEmailController.text = val;
                        });                 
                      },
                      initialValue: "",
                      hintText: 'Your contact email',
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,                   
                    ),
                    SizedBox(height: 30.h),
                    //mobile number of client
                    Text(
                      'Phone Number',
                      style: GoogleFonts.inter(
                        color: AppColor.blackColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500
                      )
                    ),
                    SizedBox(height: 20.h),
                    ContactTextField(
                      onChanged: (val) {
                        setState(() {
                          service.contactPhoneNumberController.text = val;
                        });                 
                      },
                      initialValue: "",
                      hintText: 'Your contact phone number',
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.done,                   
                    ),
      
                    SizedBox(height: 320.h,),
                    
                    Obx(
                      () {
                        return service.isLoading.value ? Loader()
                        :ReusableButton(
                          color: AppColor.mainColor,
                          text: 'Save',
                          onPressed: () async{
                            if(service.contactNameController.text.isNotEmpty && service.contactEmailController.text.isNotEmpty && service.contactPhoneNumberController.text.isNotEmpty) {
                              service.addNewContact(
                                context: context, 
                                client_name: service.contactNameController.text, 
                                client_email: service.contactEmailController.text,
                                client_phone_number: service.contactPhoneNumberController.text,
                              );
                            }
                            else {
                              showMySnackBar(
                                context: context,
                                message: "fields must not be empty", 
                                backgroundColor: AppColor.redColor
                              );
                            }
                          },
                        );
                      }
                    ),
                    SizedBox(height: 20.h,),
                  ],
                ),
              ),
            ),
          ),
            
        ]
      )
    
    );
  }
}