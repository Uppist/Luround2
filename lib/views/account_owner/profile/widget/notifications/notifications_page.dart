import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../controllers/account_owner/profile_page_controller.dart';
import '../../../../../utils/colors/app_theme.dart';
import '../../../../../utils/components/title_text.dart';
import 'notifications_empty_state.dart';








class NotificationsPage extends StatelessWidget {
  NotificationsPage({super.key});

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
        title: CustomAppBarTitle(text: 'Notifications',),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 10),
              
              /*Container(
                color: AppColor.greyColor,
                width: double.infinity,
                height: 7,
              ),

              NotificationEmptyState(onPressed: () {}),*/
            
              //listview.builder
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
                            "J",
                            style: GoogleFonts.inter(
                              color: AppColor.bgColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        /*RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Yester Moron ",  //recepient name
                                style: GoogleFonts.poppins(
                                  color: AppColor.blackColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16
                                )
                              ),
                              TextSpan(
                                text: "booked a ",  
                                style: GoogleFonts.poppins(
                                  color: AppColor.darkGreyColor,
                                  //fontWeight: FontWeight.w500,
                                  fontSize: 16
                                )
                              ),
                              TextSpan(
                                text: "Personal Training ",  //notification type
                                style: GoogleFonts.poppins(
                                  color: AppColor.blackColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16
                                )
                              ),
                              TextSpan(
                                text: " \nsession.",  
                                style: GoogleFonts.poppins(
                                  color: AppColor.darkGreyColor,
                                  //fontWeight: FontWeight.w500,
                                  fontSize: 16
                                )
                              ),
                            ]
                          )                     
                        )*/
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Yester Moron booked a Personal Training session.",  //recepient name
                                style: GoogleFonts.inter(
                                  textStyle: TextStyle(
                                    overflow: TextOverflow.visible,
                                    color: AppColor.blackColor,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  )
                                )
                              ),
                              SizedBox(height: 20,),
                              Text(
                                "Jun 24 at 10:00",  //recepient name
                                style: GoogleFonts.inter(
                                  color: AppColor.darkGreyColor,
                                  //fontWeight: FontWeight.w500,
                                  fontSize: 14
                                )
                              ),
                            ],
                          ),
                        )
                      ]
                    )
                  );
                }
              )
              //////////////////
            ]
          )
        )
      )
    );
  }
}