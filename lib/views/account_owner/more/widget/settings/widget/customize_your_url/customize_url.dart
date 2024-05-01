import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/more/more_controller.dart';
import 'package:luround/services/account_owner/more/settings/settings_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/extractors.dart';
import 'package:luround/utils/components/loader.dart';
import 'package:luround/utils/components/reusable_button.dart';
import 'package:luround/utils/components/title_text.dart';
import 'package:luround/views/account_owner/more/widget/settings/widget/customize_your_url/customize_url_textfield.dart';









class CustomizeYourURLPage extends StatelessWidget {
  CustomizeYourURLPage({super.key});

  final controller = Get.put(MoreController());
  final service = Get.put(SettingsService());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      /*appBar: AppBar(
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
        title: CustomAppBarTitle(text: 'Customize your URL',),
      ),*/
      body: FutureBuilder(
        future: service.getUserProfileDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loader();
          }
          if (snapshot.hasError) {
            print(snapshot.error);
          }
          if (!snapshot.hasData) {
            print("uh--oh! nothing dey;");
          }
          if (snapshot.hasData) {

            var data = snapshot.data!;

            return SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 10.h,),
                  //Header
                  /////////////
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 7.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: () {
                            Get.back();
                          },
                          icon: Icon(
                            Icons.arrow_back_rounded,
                            color: AppColor.blackColor,
                          )
                        ),
                        SizedBox(width: 3.w,),
                        Text(
                          'Customize your URL',
                          style: GoogleFonts.inter(
                            color: AppColor.blackColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                      ],
                    ),
                  ),
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
                            Text(
                              'Personalize the URL for your profile',
                              style: GoogleFonts.inter(
                                color: AppColor.blackColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400
                              )
                            ),
                            SizedBox(height: 30.h),
                            Text(
                              'Current URL',
                              style: GoogleFonts.inter(
                                color: AppColor.blackColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500
                              )
                            ),
                            SizedBox(height: 30.h),
                            CustomizeURLTextField(
                              onChanged: (val) {
                                controller.customizeURLTextController.text = val;
                                print(controller.customizeURLTextController.text);
                              },
                              initialValue: data.luround_url,
                              hintText: 'Enter your profile url',
                              keyboardType: TextInputType.url,
                              textInputAction: TextInputAction.done,                   
                            ),
                            SizedBox(height: 20.h),
                            Text(
                              'Note: Your custom URL must contain 3-100 letters or numbers. Please do not use spaces, symbols or special characters.',
                              style: GoogleFonts.inter(
                                color: AppColor.darkGreyColor,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w400
                              )
                            ),
                            
                            SizedBox(height: MediaQuery.of(context).size.height * 0.5),
                              
                            ReusableButton(
                              color: AppColor.mainColor,
                              text: 'Save',
                              onPressed: () async{
                                await service.customizeUserURL(
                                  context: context, 
                                  slug: getUserUrlSlug(controller.customizeURLTextController.text),
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
              ),
            );
          }

          return Center(
            child: Text(
              "connection timed out",
              style: GoogleFonts.inter(
                color: AppColor.darkGreyColor,
                fontSize: 13.sp,
                fontWeight: FontWeight.normal
              )
            )
          );

        }
      )
    ); 
  }
}