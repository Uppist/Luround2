import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_viewer/profile_page_controller__acc_viewer.dart';
import 'package:luround/models/account_owner/user_profile/review_response.dart';
import 'package:luround/services/account_viewer/services/get_user_service.dart';
import 'package:luround/utils/components/converters.dart';
import 'package:luround/utils/components/extractors.dart';
import 'package:luround/utils/components/loader.dart';
import 'package:luround/views/account_owner/profile/widget/reviews/review_empty_state.dart';
import 'package:luround/views/account_viewer/people_profile/widget/reviews_section/write_review_screen.dart';
import 'package:luround/views/account_viewer/web_routes/routes.dart';
import '../../../../../utils/colors/app_theme.dart';
import '../../../../../utils/components/title_text.dart';








class AccViewerReviewsPage extends StatelessWidget {
  AccViewerReviewsPage({super.key, required this.userName, required this.photoUrl, required this.userId,});
  final String userName;
  final String photoUrl;
  final String userId;

  var controller = Get.put(ProfilePageAccViewerController());
  var service = Get.put(AccViewerService());


  @override
  Widget build(BuildContext context) {


    // Get the arguments using Get.arguments
    /*final Map<String, dynamic> arguments = Get.arguments;
    // Access the arguments
    final String userName = arguments['userName'];
    final String photoUrl = arguments['photoUrl'];
    final String userId = arguments['userId'];*/

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
        future: service.getUserReviews(userID: userId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Loader();
          }
          if (snapshot.hasError) {
            print(snapshot.error);
            /*return ReviewEmptyState(
              onPressed: () {
                service.getUserReviews();
              },
            );*/
            return SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 10.h),
                  Container(
                    color: AppColor.greyColor,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    height: 60.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Get.to(() => WriteReviewsScreen(
                              userId: userId,
                              photoUrl: photoUrl,
                              userName: userName,
                            ));

                            /*Get.toNamed(
                              WriteReviewRoute,
                              arguments: {
                                'userId': userId,
                                'photoUrl': photoUrl,
                                'userName': userName,
                              }
                            );*/
                          }, 
                          child: Text(
                           'Write a review',
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                color: AppColor.mainColor,
                                decoration: TextDecoration.underline,
                                decorationColor: AppColor.mainColor,
                                fontSize: 14.sp, //14
                                fontWeight: FontWeight.w500
                              )
                            )
                          )
                        ),
                      ],
                    ),
                  ),
                  ReviewEmptyState(
                    onPressed: () {
                      service.getUserReviews(userID: userId);
                    },
                  )
                ]
              )
            );
          }
          if (!snapshot.hasData) {
            print("uh--oh! nothing dey;");
            /*return ReviewEmptyState(
              onPressed: () {
                service.getUserReviews();
              },
            );*/
            return SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 10.h),
                  Container(
                    color: AppColor.greyColor,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    height: 60.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Get.to(() => WriteReviewsScreen(
                              userId: userId,
                              photoUrl: photoUrl,
                              userName: userName,
                            ));

                            /*Get.toNamed(
                              WriteReviewRoute,
                              arguments: {
                                'userId': userId,
                                'photoUrl': photoUrl,
                                'userName': userName,
                              }
                            );*/
                          }, 
                          child: Text(
                           'Write a review',
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                color: AppColor.mainColor,
                                decoration: TextDecoration.underline,
                                decorationColor: AppColor.mainColor,
                                fontSize: 14.sp, //14
                                fontWeight: FontWeight.w500
                              )
                            )
                          )
                        ),
                      ],
                    ),
                  ),
                  ReviewEmptyState(
                    onPressed: () {
                      service.getUserReviews(userID: userId);
                    },
                  )
                ]
              )
            );
          }
          if (snapshot.hasData) {

            var data = snapshot.data!;
            return SafeArea(
              child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 10.h),
                  Container(
                    color: AppColor.greyColor,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                    height: 60.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {

                            Get.to(() => WriteReviewsScreen(
                              userId: userId,
                              photoUrl: photoUrl,
                              userName: userName,
                            ));
                            
                            /*Get.toNamed(
                              WriteReviewRoute,
                              arguments: {
                                'userId': userId,
                                'photoUrl': photoUrl,
                                'userName': userName,
                              }
                            );*/
                          }, 
                          child: Text(
                            'Write a review',
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                color: AppColor.mainColor,
                                decoration: TextDecoration.underline,
                                decorationColor: AppColor.mainColor,
                                fontSize: 14.sp, //14
                                fontWeight: FontWeight.w500
                              )
                            )
                          )
                        ),
                      ],
                    ),
                  ),
                  //ReviewEmptyState(onPressed: () {},),
                  //ListView.builder & CO
          
                  //Ratings Card
                  /*Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
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
                              fontSize: 20,
                              fontWeight: FontWeight.w500
                            )
                          )
                        ),
                        SizedBox(width: 20,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //rating indicator
                            RatingBarIndicator(                      
                              unratedColor: AppColor.textGreyColor.withOpacity(0.2),
                              itemPadding: EdgeInsets.symmetric(horizontal: 5),
                              rating: 4.0,  //fetch from db
                              itemBuilder: (context, index) => Icon(
                                CupertinoIcons.star_fill,
                                color: AppColor.yellowStar,
                              ),
                              itemCount: 5,
                              itemSize: 20.0, //30
                              direction: Axis.horizontal,
                            ),
                            SizedBox(height: 10,),
                            Text(
                              'based on 12 ratings',
                              style: GoogleFonts.inter(
                                textStyle: TextStyle(
                                  color: AppColor.darkGreyColor,
                                  fontSize: 14,
                                  //fontWeight: FontWeight.w500
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
                    physics: NeverScrollableScrollPhysics(),
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
                            ////Image
                            data[index].userPhoto != 'url'
                            ?CircleAvatar(
                              backgroundColor: AppColor.greyColor,
                              backgroundImage: NetworkImage(
                                data[index].userPhoto
                              ),
                              radius: 30.r,
                            )
                            :CircleAvatar(
                              backgroundColor: AppColor.greyColor,
                              radius: 30.r,
                              child: Text(
                                getFirstLetter(data[index].userName ?? "Non"),
                                style: GoogleFonts.inter(
                                  color: AppColor.blackColor,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600
                                ),
                              ),
                            ),
                            //////////
                            SizedBox(width: 10.w),
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
                                  SizedBox(height: 25.h,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      //rating indicator
                                      RatingBarIndicator(                      
                                        unratedColor: AppColor.textGreyColor.withOpacity(0.2),
                                        itemPadding: EdgeInsets.symmetric(horizontal: 3.w),
                                        rating: double.tryParse(data[index].rating.toString()) ?? 0.0,  //fetch from db
                                        itemBuilder: (context, index) => Icon(
                                          CupertinoIcons.star_fill,
                                          color: AppColor.yellowStar,
                                        ),
                                        itemCount: 5,
                                        itemSize: 20.0.r, //30
                                        direction: Axis.horizontal,
                                      ),
                                      //SizedBox(width: 40,),
                                      Text(
                                        convertServerTimeToDate(data[index].createdAt),
                                        style: GoogleFonts.inter(
                                          textStyle: TextStyle(
                                            color: AppColor.textGreyColor,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w500
                                          )
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 15.h),
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