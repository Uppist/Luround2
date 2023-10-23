import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/views/account_owner/profile/widget/reviews/review_empty_state.dart';
import '../../../../../controllers/account_owner/profile_page_controller.dart';
import '../../../../../utils/colors/app_theme.dart';
import '../../../../../utils/components/title_text.dart';








class ReviewsPage extends StatelessWidget {
  ReviewsPage({super.key});

  var controller = Get.put(ProfilePageController());

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
                height: 7,
              ),
              //ReviewEmptyState(onPressed: () {},),
              //ListView.builder & CO
              //Ratings Card
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                decoration: BoxDecoration(
                  color: AppColor.bgColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '4.7',
                      style: GoogleFonts.poppins(
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
                        Icon(
                          CupertinoIcons.star_fill,
                          color: AppColor.yellowStar,
                        ),
                        SizedBox(height: 10,),
                        Text(
                          'based on 12 ratings',
                          style: GoogleFonts.poppins(
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
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                            style: GoogleFonts.poppins(
                              color: AppColor.bgColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Fredy Isma',
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    color: AppColor.blackColor,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500
                                  )
                                )
                              ),
                              SizedBox(height: 30,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    CupertinoIcons.star_fill,
                                    color: AppColor.yellowStar,
                                  ),
                                  SizedBox(width: 40,),
                                  Text(
                                    '14 Sept. 2023',
                                    style: GoogleFonts.poppins(
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
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                    color: AppColor.darkGreyColor,
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