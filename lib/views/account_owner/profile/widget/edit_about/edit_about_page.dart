import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/services/account_owner/profile_service/user_profile_service.dart';
import 'package:luround/utils/components/loader.dart';
import '../../../../../controllers/account_owner/profile_page_controller.dart';
import '../../../../../utils/colors/app_theme.dart';
import '../../../../../utils/components/reusable_button.dart';
import '../../../../../utils/components/title_text.dart';
import 'about_textfield.dart';









class EditAboutPage extends StatefulWidget {
  EditAboutPage({super.key, required this.about});
  final String about;

  @override
  State<EditAboutPage> createState() => _EditAboutPageState();
}

class _EditAboutPageState extends State<EditAboutPage> {

  var controller = Get.put(ProfilePageController());
  var profileService = Get.put(AccOwnerProfileService());

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
        title: CustomAppBarTitle(text: 'Edit About',),
      ),
      body: Obx(
        () {
          return profileService.isLoading.value ? Loader() : SafeArea(
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
                Expanded(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //About
                          Text(
                            'About',
                            style: GoogleFonts.inter(
                              color: AppColor.blackColor,
                              fontSize: 17.sp,
                              fontWeight: FontWeight.w600
                            )
                          ),
                          SizedBox(height: 30.h),
                          AboutTextField(
                            onChanged: (val) {
                              setState(() {
                                // Check if character count exceeds the maximum
                                if (val.length > controller.maxLength) {
                                  // Remove extra characters       
                                  controller.aboutController.text = val.substring(0, controller.maxLength);
                                  debugPrint("you have reached max length");
                                } 
                                controller.aboutController.text = val;
                              });
                            
                            },
                            //initial value is the one causing it
                            initialValue: widget.about,  //text gotten from the server
                            hintText: 'Enter a brief summary of your experience, skills and achievements',
                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.done,                   
                          ),
                          SizedBox(height: 20.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                '${controller.aboutController.text.length}/${controller.maxLength}',
                                style: GoogleFonts.inter(
                                  color: AppColor.textGreyColor,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500
                                )
                              ),
                            ],
                          ),
                          SizedBox(height: 490.h,),
                          ReusableButton(
                            color: AppColor.mainColor,
                            text: 'Save',
                            onPressed: () async{
                              await profileService.updateAbout(
                                context: context,
                                about: controller.aboutController.text.isEmpty ? widget.about : controller.aboutController.text
                              )
                              .whenComplete(() => Get.back());
                            },
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
      )
    );
  }
}