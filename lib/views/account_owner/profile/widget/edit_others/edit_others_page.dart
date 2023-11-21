import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/services/account_owner/local_storage/profile_service/user_profile_service.dart';
import 'package:luround/views/account_owner/profile/widget/edit_others/country_code_widget.dart';
import 'package:luround/views/account_owner/profile/widget/edit_others/custom_tap_icon.dart';
import 'package:luround/views/account_owner/profile/widget/edit_others/phone_number_textfield.dart';
import '../../../../../controllers/account_owner/profile_page_controller.dart';
import '../../../../../utils/colors/app_theme.dart';
import '../../../../../utils/components/reusable_button.dart';
import '../../../../../utils/components/title_text.dart';
import 'field_widget.dart';
import 'reusable_custom_textfield.dart';









class EditOthersPage extends StatefulWidget {
  EditOthersPage({super.key});

  @override
  State<EditOthersPage> createState() => _EditOthersPageState();
}

class _EditOthersPageState extends State<EditOthersPage> {
  var controller = Get.put(ProfilePageController());
  var profileService = Get.put(UserProfileService());

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
        title: CustomAppBarTitle(text: 'Others',),
        actions: [
          InkWell(
            onTap: () {
              profileService.updateMediaLinks(
                location:  controller.locationController.text, 
                mobile: controller.mobileNumberController.text, 
                email: controller.emailController.text, 
                website: controller.websiteController.text, 
                linkedIn: controller.linkedInController.text, 
                facebook: controller.facebookController.text,
                countryCode: controller.code.value,
              ).whenComplete(() {
                Get.back();
                print('done');
                setState(() {
                  controller.isMobileSelected.value = false;
                  controller.isLocationSelected.value = false;
                  controller.isEmailSelected.value = false;
                  controller.isWebsiteSelected.value = false;
                  controller.isLinkedInSelected.value = false;
                  controller.isFacebookSelected.value = false;
                  //
                  controller.locationController.clear(); 
                  controller.mobileNumberController.clear(); 
                  controller.emailController.clear();
                  controller.websiteController.clear(); 
                  controller.linkedInController.clear(); 
                  controller.facebookController.clear();
                });

              });
            },
            child: SvgPicture.asset("assets/svg/save_button.svg")
          ),
          /*SaveButton(
            onPressed: () {},
            text: 'Save',
          ),*/
          SizedBox(width: 20.w,),
        ],
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
              SizedBox(height: 30.h,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    //Text
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Others',
                          style: GoogleFonts.inter(
                            color: AppColor.blackColor,
                            fontSize: 17.sp,
                            fontWeight: FontWeight.bold
                          )
                        ),
                        Text(
                          'Hold field to re-order',
                          style: GoogleFonts.inter(
                            color: AppColor.yellowStar,
                            //fontWeight: FontWeight.w500,
                            fontSize: 15.sp
                          ),
                        )
                      ],
                    ),

                    SizedBox(height: 20.h,),


                    //ListView.builder here//////////////////////////
                    controller.isLocationSelected.value ? 
                    CustomFieldWidget(               
                      svgAssetName: "assets/svg/location_icon.svg", 
                      fieldName: "Location", 
                      onCancel: () {
                        setState(() {
                          controller.isLocationSelected.value = false;
                          controller.locationController.clear();
                        });
                      }, 
                      fieldWidget: ReusableTextField(
                        onChanged: (val){},
                        onFocusChanged: (hasFocus) {
                          controller.updateLocationFocus(hasFocus);
                        },
                        hintText: 'Where are you located?',
                        keyboardType: TextInputType.text,
                        textController: controller.locationController,
                        textInputAction: TextInputAction.next,
                      )
                    ): SizedBox(),

                    controller.isMobileSelected.value ? 
                    CustomFieldWidget(               
                      svgAssetName: "assets/svg/call_icon.svg", 
                      fieldName: "Mobile", 
                      onCancel: () {
                        setState(() {
                          controller.isMobileSelected.value = false;
                          controller.mobileNumberController.clear();
                        });
                      }, 
                      fieldWidget: PhoneNumberTextField(
                        //country code widget
                        countryCodeWidget: CountryCodeWidget(),  
                        onChanged: (val){},
                        onFocusChanged: (hasFocus) {
                          controller.updateMobileFocus(hasFocus);
                        },
                        hintText: 'Enter your mobile number',
                        keyboardType: TextInputType.phone,
                        textController: controller.mobileNumberController,
                        textInputAction: TextInputAction.next,
                      )
                    ): SizedBox(),

                    controller.isEmailSelected.value ? 
                    CustomFieldWidget(               
                      svgAssetName: "assets/svg/email_icon.svg", 
                      fieldName: "Email", 
                      onCancel: () {
                        setState(() {
                          controller.isEmailSelected.value = false;
                          controller.emailController.clear();
                        });
                      }, 
                      fieldWidget: ReusableTextField(
                        onChanged: (val){},
                        onFocusChanged: (hasFocus) {
                          controller.updateEmailFocus(hasFocus);
                        },
                        hintText: 'Enter your valid email address',
                        keyboardType: TextInputType.emailAddress,
                        textController: controller.emailController,
                        textInputAction: TextInputAction.next,
                      )
                    ): SizedBox(),

                    controller.isWebsiteSelected.value ? 
                    CustomFieldWidget(               
                      svgAssetName: "assets/svg/site_icon.svg", 
                      fieldName: "Website", 
                      onCancel: () {
                        setState(() {
                          controller.isWebsiteSelected.value = false;
                          controller.websiteController.clear();
                        });
                      }, 
                      fieldWidget: ReusableTextField(
                        onChanged: (val){},
                        onFocusChanged: (hasFocus) {
                          controller.updateWebsiteFocus(hasFocus);
                        },
                        hintText: 'Pates url to your portfolio site',
                        keyboardType: TextInputType.url,
                        textController: controller.websiteController,
                        textInputAction: TextInputAction.next,
                      )
                    ): SizedBox(),

                    controller.isLinkedInSelected.value ? 
                    CustomFieldWidget(               
                      svgAssetName: "assets/svg/linkedin_icon.svg", 
                      fieldName: "LinkedIn", 
                      onCancel: () {
                        setState(() {
                          controller.isLinkedInSelected.value = false;
                          controller.linkedInController.clear();
                        });
                      }, 
                      fieldWidget: ReusableTextField(
                        onChanged: (val){},
                        onFocusChanged: (hasFocus) {
                          controller.updateLinkedInFocus(hasFocus);
                        },
                        hintText: 'Paste url to your LinkedIn profile',
                        keyboardType: TextInputType.url,
                        textController: controller.linkedInController,
                        textInputAction: TextInputAction.next,
                      )
                    ): SizedBox(),

                    controller.isFacebookSelected.value ? 
                    CustomFieldWidget(               
                      svgAssetName: "assets/svg/facebook_icon.svg", 
                      fieldName: "Facebook", 
                      onCancel: () {
                        setState(() {
                          controller.isFacebookSelected.value = false;
                          controller.facebookController.clear();
                        });
                      }, 
                      fieldWidget: ReusableTextField(
                        onChanged: (val){},
                        onFocusChanged: (hasFocus) {
                          controller.updateFacebookFocus(hasFocus);
                        },
                        hintText: 'Paste url to your Facebook page',
                        keyboardType: TextInputType.url,
                        textController: controller.facebookController,
                        textInputAction: TextInputAction.next,
                      )
                    ): SizedBox(),


                    
                    ////////////////////////////////
                    SizedBox(height: 40.h),
                    Text(
                      'Tap on icon to add',
                      style: GoogleFonts.inter(
                        color: AppColor.blackColor,
                        fontSize: 17.sp,
                        fontWeight: FontWeight.bold
                      )
                    ),

                    SizedBox(height: 40),


                    //tap an icon custom row grid here///////////////////////////
                    //1
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomTapIcon(
                          svgAssetName: "assets/svg/location_icon.svg",
                          iconTitle: 'Location',
                          onTap: () {
                            setState(() {
                              controller.isLocationSelected.value = true;
                            });
                          },
                        ),
                        //SizedBox(width: 118,), //120
                        CustomTapIcon(
                          svgAssetName: "assets/svg/call_icon.svg",
                          iconTitle: 'Mobile',
                          onTap: () {
                            setState(() {
                              controller.isMobileSelected.value = true;
                            });
                          },
                        ),
                        //SizedBox(width: 140,),
                        CustomTapIcon(
                          svgAssetName: "assets/svg/email_icon.svg",
                          iconTitle: 'Email',
                          onTap: () {
                            setState(() {
                              controller.isEmailSelected.value = true;
                            });
                          },
                        )
                      ],
                    ),
                    SizedBox(height: 60.h,),
                    //2
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        CustomTapIcon(
                          svgAssetName: "assets/svg/site_icon.svg",
                          iconTitle: 'Website',
                          onTap: () {
                            setState(() {
                              controller.isWebsiteSelected.value = true;
                            });
                          },
                        ),
                        //SizedBox(width: 60,),
                        CustomTapIcon(
                          svgAssetName: "assets/svg/linkedin_icon.svg",
                          iconTitle: 'LinkedIn',
                          onTap: () {
                            setState(() {
                              controller.isLinkedInSelected.value = true;
                            });
                          },
                        ),
                        //SizedBox(width: 50,),
                        CustomTapIcon(
                          svgAssetName: "assets/svg/facebook_icon.svg",
                          iconTitle: 'Facebook',
                          onTap: () {
                            setState(() {
                              controller.isFacebookSelected.value = true;
                            });
                          },
                        )
                      ],
                    ),
                    ///////////////////////////////////////////////////////


                    SizedBox(height: 20.h,),
                  ]
                )
              )
            ]
          )
        )
      )
    );
  }
}