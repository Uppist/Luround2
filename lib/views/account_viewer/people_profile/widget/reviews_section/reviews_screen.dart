import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_viewer/profile_page_controller__acc_viewer.dart';
import 'package:luround/views/account_owner/profile/widget/reviews/review_empty_state.dart';
import 'package:luround/views/account_viewer/people_profile/widget/reviews_section/write_review_screen.dart';
import '../../../../../controllers/account_owner/profile_page_controller.dart';
import '../../../../../utils/colors/app_theme.dart';
import '../../../../../utils/components/title_text.dart';








class AccViewerReviewsPage extends StatelessWidget {
  AccViewerReviewsPage({super.key});

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
        title: CustomAppBarTitle(text: 'Reviews',),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 10),
              Container(
                color: AppColor.greyColor,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Get.to(() => WriteReviewsPage());
                      }, 
                      child: Text(
                        'Write a review',
                        style: GoogleFonts.inter(
                          textStyle: TextStyle(
                            color: AppColor.mainColor,
                            decoration: TextDecoration.underline,
                            fontSize: 15, //14
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
              Container(
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
              ),
              Container(
                color: AppColor.greyColor,
                width: double.infinity,
                height: 7,
              ),
              SizedBox(height: 20,),
              //List of reviews
              ListView.separated(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 6,
                separatorBuilder: (context, index) => Divider(color: AppColor.darkGreyColor, thickness: 0.2,),
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
                          radius: 30,
                          child: Text(
                            "F",
                            style: GoogleFonts.inter(
                              color: AppColor.bgColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Fredy Isma',
                                style: GoogleFonts.inter(
                                  textStyle: TextStyle(
                                    color: AppColor.blackColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500
                                  )
                                )
                              ),
                              SizedBox(height: 25,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  //rating indicator
                                  RatingBarIndicator(                      
                                    unratedColor: AppColor.textGreyColor.withOpacity(0.2),
                                    itemPadding: EdgeInsets.symmetric(horizontal: 3),
                                    rating: 4.0,  //fetch from db
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
                                    '14 Sept. 2023',
                                    style: GoogleFonts.inter(
                                      textStyle: TextStyle(
                                        color: AppColor.textGreyColor,
                                        fontSize: 14,
                                        //fontWeight: FontWeight.w500
                                      )
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 15),
                              Text(
                                'dddddddddthfthfjtyutyusthethrttttttttttttttttttttttttttttttttttttttttttrstgfxrhzthth',
                                style: GoogleFonts.inter(
                                  textStyle: TextStyle(
                                    color: AppColor.textGreyColor,
                                    fontSize: 15,
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
              SizedBox(height: 20,),

            ]
          )
        )
      )
    );
  }
}