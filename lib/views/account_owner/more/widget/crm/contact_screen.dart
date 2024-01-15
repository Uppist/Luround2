


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/services/account_owner/more/crm/crm_service.dart';
import '../../../../../controllers/account_owner/profile/profile_page_controller.dart';
import '../../../../../utils/colors/app_theme.dart';
import '../../../../../utils/components/title_text.dart';








class ContactScreen extends StatelessWidget {
  ContactScreen({super.key});

  var service = Get.put(CRMService());

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
        title: CustomAppBarTitle(text: 'Contacts',),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 10.h),
              
              /*Container(
                color: AppColor.greyColor,
                width: double.infinity,
                height: 7,
              ),*/

              //SearchTextFiled Here
              

            
              //listview.builder
              ListView.separated(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 6,
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
                          backgroundColor: AppColor.mainColor,
                          radius: 30.r,
                          child: Text(
                            "J",
                            style: GoogleFonts.inter(
                              color: AppColor.bgColor,
                              fontSize: 21.sp,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        SizedBox(width: 15.w),
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
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14.sp,
                                  )
                                )
                              ),
                              SizedBox(height: 20.h,),
                              Text(
                                "Jun 24 at 10:00",  //recepient name
                                style: GoogleFonts.inter(
                                  color: AppColor.darkGreyColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.sp
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