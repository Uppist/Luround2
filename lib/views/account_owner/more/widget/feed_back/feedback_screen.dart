import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/more_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import 'package:luround/views/account_owner/more/widget/feed_back/description_textfield.dart';
import 'package:luround/views/account_owner/more/widget/feed_back/subject_textfield.dart';
import 'package:luround/views/account_owner/profile/widget/notifications/notifications_page.dart';










class FeedbackPage extends StatefulWidget {
  FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  var controller = Get.put(MoreController());

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
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ///Header Section
            Container(
              color: AppColor.bgColor,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset('assets/images/luround_logo.png'),
                      InkWell(
                        onTap: () {
                          Get.to(() => NotificationsPage());
                        },
                        child: SvgPicture.asset("assets/svg/notify_active.svg"),
                      ),
                    ]
                  ),
                ]
              )
            ),
            /////////////////////////////////////////////
            Container(
              color: AppColor.greyColor,
              width: double.infinity,
              height: 7.h,
            ),
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
                      fontSize: 17.sp,
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
                child: Form(
                  key: GlobalKey(),
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
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        SizedBox(height: 10.h),
                        SubjectTextField(
                          onChanged: (val) {},
                          hintText: "Enter here",
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          controller: controller.subjectController,
                        ),
                        SizedBox(height: 30.h),
                        //2
                        Text(
                          "Description",
                          style: GoogleFonts.inter(
                            color: AppColor.blackColor,
                            fontSize: 15.sp,
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
                      ],
                    ),
                  ),
                ),
              ),
            ),
            //
            SizedBox(height: 50.h),  //250
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
              child: RebrandedReusableButton(
                textColor: AppColor.bgColor,
                color: AppColor.mainColor,
                text: "Submit", 
                onPressed: () {}
              )
            ),
            SizedBox(height: 20.h),

          ]
        )
      )
    );
  }
}