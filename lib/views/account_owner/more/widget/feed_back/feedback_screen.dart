import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/more/more_controller.dart';
import 'package:luround/services/account_owner/more/feedback/feedback_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/loader.dart';
import 'package:luround/utils/components/my_snackbar.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import 'package:luround/views/account_owner/more/widget/feed_back/description_textfield.dart';
import 'package:luround/views/account_owner/more/widget/feed_back/subject_textfield.dart';
import 'package:luround/views/account_owner/profile/widget/notifications/notifications_page.dart';










class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  
  var controller = Get.put(MoreController());
  var service = Get.put(FeedbackService());

  @override
  void initState() {
    // TODO: implement initState
    /*controller.descriptionController.addListener(() {
      setState(() {
        controller.isSubmit = controller.descriptionController.text.isNotEmpty;
      });
    });*/
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: Obx(
        () {
          return service.isLoading.value ? Loader() : SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 10.h,),
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
                        "Contact us",
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
                SizedBox(height: 10.h,),
                Expanded(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 10.h),
                          //1
                          Text(
                            "Subject",
                            style: GoogleFonts.inter(
                              color: AppColor.blackColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          SizedBox(height: 10.h),
                          SubjectTextField(
                            onChanged: (val) {},
                            hintText: "Enter your subject here",
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            controller: controller.subjectController,
                          ),
                          SizedBox(height: 30.h),
                          //2
                          Text(
                            "Description",
                            style: GoogleFonts.inter(
                              color: AppColor.blackColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          SizedBox(height: 10.h),
                          FeedbackDescriptionTextField(
                            onTap: () {
                              /*setState(() {
                                controller.isSubmit = true;
                              });*/
                            },
                            onChanged: (val) {},
                            hintText: "Enter the details of your request. Our team will respond as soon as possible.",
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            controller: controller.descriptionController,
                          ),
            
                          SizedBox(height: MediaQuery.of(context).size.height * 0.49),
                          
                          RebrandedReusableButton(
                            textColor: AppColor.bgColor,
                            color: AppColor.mainColor,
                            text: "Submit", 
                            onPressed: () {
                              if(controller.subjectController.text.isNotEmpty && controller.descriptionController.text.isNotEmpty) {
                                service.sendFeedback(
                                  context: context, 
                                  description: controller.descriptionController.text, 
                                  subject: controller.subjectController.text
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
                          ),
                              
                          SizedBox(height: 20.h),
                        ],
                      ),
                    ),
                  ),
                ),
                //
                      
              ]
            ),
          );
        }
      )
    );
  }
}