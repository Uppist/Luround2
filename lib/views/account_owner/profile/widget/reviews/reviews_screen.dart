import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/models/account_owner/user_profile/review_response.dart';
import 'package:luround/services/account_owner/profile_service/user_profile_service.dart';
import 'package:luround/utils/components/converters.dart';
import 'package:luround/utils/components/extractors.dart';
import 'package:luround/utils/components/loader.dart';
import 'package:luround/views/account_owner/profile/widget/reviews/review_empty_state.dart';
import '../../../../../controllers/account_owner/profile/profile_page_controller.dart';
import '../../../../../utils/colors/app_theme.dart';
import '../../../../../utils/components/title_text.dart';








class ReviewsPage extends StatelessWidget {
  ReviewsPage({super.key});

  var controller = Get.put(ProfilePageController());
  var service = Get.put(AccOwnerProfileService());

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
        title: CustomAppBarTitle(text: 'Reviews',),
      ),
      body: FutureBuilder<List<ReviewResponse>>(
        future: service.getUserReviews(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loader();
          }
          if (snapshot.hasError) {
            print(snapshot.error);
            return ReviewEmptyState(
              onPressed: () {
                service.getUserReviews();
              },
            );
          }
          if (!snapshot.hasData) {
            print("uh--oh! nothing dey;");
            return ReviewEmptyState(
              onPressed: () {
                service.getUserReviews();
              },
            );
          }
          if (snapshot.hasData) {

            var data = snapshot.data!;
            
            return SafeArea(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    //Header
                    /////////////
                    /*SizedBox(height: 10.h,),
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
                            'Reviews',
                            style: GoogleFonts.inter(
                              color: AppColor.blackColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                        ],
                      ),
                    ),*/
                    /////////
                  SizedBox(height: 10.h),
                  /*Container(
                    color: AppColor.greyColor,
                    width: double.infinity,
                    height: 7.h,
                  ),
                  //ReviewEmptyState(onPressed: () {},),
                  //ListView.builder & CO
                  //Ratings Card
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
                    decoration: BoxDecoration(
                      color: AppColor.bgColor,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '4.0',
                          style: GoogleFonts.inter(
                            textStyle: TextStyle(
                              color: AppColor.blackColor,
                              //decoration: TextDecoration.underline,
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w500
                            )
                          )
                        ),
                        SizedBox(width: 20.w,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //rating indicator
                            RatingBarIndicator(                      
                              unratedColor: AppColor.textGreyColor.withOpacity(0.2),
                              itemPadding: EdgeInsets.symmetric(horizontal: 5.w),
                              rating: 4.0,  //fetch from db data.totalRatings
                              itemBuilder: (context, index) => Icon(
                                CupertinoIcons.star_fill,
                                color: AppColor.yellowStar,
                              ),
                              itemCount: 5,
                              itemSize: 20.0, //30
                              direction: Axis.horizontal,
                            ),
                            SizedBox(height: 10.h,),
                            Text(
                              'based on ${data.length} ratings',
                              style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                  color: AppColor.darkGreyColor,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500
                                )
                              )
                            ),
                          ],
                        )
                      ],
                    ),
                  ),*/
                  Container(
                    color: AppColor.greyColor,
                    width: double.infinity,
                    height: 7.h,
                  ),
                  SizedBox(height: 20.h,),
                  //List of reviews
                  ListView.separated(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: data.length,
                    separatorBuilder: (context, index) => Divider(color: AppColor.darkGreyColor, thickness: 0.2,),
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColor.bgColor,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundColor: AppColor.greyColor,
                              radius: 30.r,
                              child: Text(
                                getFirstLetter(data[index].userName),
                                style: GoogleFonts.inter(
                                  color: AppColor.blackColor,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600
                                ),
                              ),
                            ),
                            SizedBox(width: 15.w),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data[index].userName,
                                    style: GoogleFonts.inter(
                                      textStyle: TextStyle(
                                        color: AppColor.blackColor,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w600
                                      )
                                    )
                                  ),
                                  SizedBox(height: 10.sp,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      //rating indicator
                                      RatingBarIndicator(                      
                                        unratedColor: AppColor.textGreyColor.withOpacity(0.2),
                                        itemPadding: EdgeInsets.symmetric(horizontal: 2.w),
                                        rating: double.parse("${data[index].rating}"),  //fetch from db
                                        itemBuilder: (context, index) => Icon(
                                          CupertinoIcons.star_fill,
                                          color: AppColor.yellowStar,
                                        ),
                                        itemCount: 5,
                                        itemSize: 20.0, //30
                                        direction: Axis.horizontal,
                                      ),
                                      //SizedBox(width: 40,),
                                      Text(
                                        //'14 Sept. 2023',
                                        convertServerTimeToDate(data[index].createdAt),
                                        style: GoogleFonts.inter(
                                          textStyle: TextStyle(
                                            color: AppColor.textGreyColor,
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w400
                                          )
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 15),
                                  Text(
                                    data[index].reviewText,
                                    style: GoogleFonts.inter(
                                      textStyle: TextStyle(
                                        color: AppColor.textGreyColor,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500
                                      )
                                    )
                                  ),
                                ]
                              )
                            )
                          ]
                        )
                      );
                    }
                    ),
                    SizedBox(height: 20.h,),        
                  ]
                )
              )
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