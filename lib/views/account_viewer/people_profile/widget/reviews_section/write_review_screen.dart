import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_viewer/profile_page_controller__acc_viewer.dart';
import 'package:luround/views/account_viewer/people_profile/widget/reviews_section/reviews_textfield.dart';
import '../../../../../controllers/account_owner/profile_page_controller.dart';
import '../../../../../utils/colors/app_theme.dart';
import '../../../../../utils/components/title_text.dart';








class WriteReviewsPage extends StatefulWidget {
  WriteReviewsPage({super.key});

  @override
  State<WriteReviewsPage> createState() => _WriteReviewsPageState();
}

class _WriteReviewsPageState extends State<WriteReviewsPage> {
  var controller = Get.put(ProfilePageAccViewerController());

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
        title: CustomAppBarTitle(text: 'Back',),
        actions: [
          //button
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(8.0),
            //height: 20,
            width: 80.w,
            decoration: BoxDecoration(
              color: AppColor.mainColor,
              borderRadius: BorderRadius.circular(10.r)
            ),
            child: Text(
              "Post",
              style: GoogleFonts.inter(
                color: AppColor.bgColor,
                fontSize: 13.sp,
                fontWeight: FontWeight.w500
              ),
            ),
          ),
          SizedBox(width: 20.w,)
        ],
        toolbarHeight: 40.h,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 20.h),
              Container(
                color: AppColor.greyColor,
                width: double.infinity,
                height: 7.h,
              ),
              //account of who you'd be reviewing
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColor.bgColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColor.mainColor,
                      radius: 30.r,
                      child: Text(
                        "R",
                        style: GoogleFonts.inter(
                          color: AppColor.bgColor,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    SizedBox(width: 14.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Ronald Richards',
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                color: AppColor.blackColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500
                              )
                            )
                          ),
                          SizedBox(height: 15.h,),                           
                          Text(
                            'Reviews are public and include your account info.',
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                color: AppColor.textGreyColor,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500
                              )
                            )
                          ),
                        ]
                      )
                    )
                  ]
                )
              ),
              Container(
                color: AppColor.greyColor,
                width: double.infinity,
                height: 7.h,
              ),
              //rate this person section
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColor.bgColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Rate this person",
                      style: GoogleFonts.inter(
                        color: AppColor.blackColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    SizedBox(height: 30.h,),
                    //RatingBar.builder()
                    RatingBar.builder(
                      initialRating: 0, //3
                      minRating: 0,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      glow: true,
                      glowRadius: 1,
                      glowColor: AppColor.yellowStar,
                      itemCount: 5,
                      unratedColor: AppColor.textGreyColor.withOpacity(0.2),
                      itemPadding: EdgeInsets.symmetric(horizontal: 20.w),
                      itemBuilder: (context, _) => Icon(
                        CupertinoIcons.star_fill,
                        color: AppColor.yellowStar,
                      ),
                      onRatingUpdate: (rating) {
                        controller.rating.value = rating;
                        print("user rating: ${controller.rating.value}");
                      },
                    ),
                  ]
                )
              ),
              Container(
                color: AppColor.greyColor,
                width: double.infinity,
                height: 7.h,
              ),
              //write a review section
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColor.bgColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Write a review",
                      style: GoogleFonts.inter(
                        color: AppColor.blackColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    SizedBox(height: 10.h,),
                    Text(
                      "Share your thoughts with others",
                      style: GoogleFonts.inter(
                        color: AppColor.darkGreyColor,
                        fontSize: 12.sp,
                        //fontWeight: FontWeight.w500
                      ),
                    ),
                    SizedBox(height: 20.h,),
                    //textfield here
                    ReviewTextField(
                      controller: controller.reviewController,
                      hintText: 'write about your experience (optional)',
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.done,
                      onChanged: (val) {
                        // Check if character count exceeds the maximum
                        if (val.length > controller.maxLength) {
                          // Remove extra characters        
                          controller.reviewController.text = val.substring(0, controller.maxLength);
                          debugPrint("you have reached max length");
                        } 
                        setState(() {}); // Update the UI
                      },
                    ),
                    SizedBox(height: 10.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "${controller.reviewController.text.length}/${controller.maxLength}",
                          style: GoogleFonts.inter(
                            color: AppColor.textGreyColor,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                      ],
                    )
                  ]
                )
              ),
              Container(
                color: AppColor.greyColor,
                width: double.infinity,
                height: 7.h,
              ),
            ]
          )
        )
      )
    );
  }
}