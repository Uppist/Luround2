import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_viewer/services_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/reusable_button.dart';
import 'package:luround/views/account_viewer/services/widgets/book_a_service/book_a_service.dart';
import 'package:luround/views/account_viewer/services/widgets/request_quote/request_quote_screen.dart';
import 'package:luround/views/account_viewer/services/widgets/toggle_price/toggle_price_accviewer.dart';








class AccViewerServicesPage extends StatelessWidget {
  AccViewerServicesPage({super.key});

  var controller = Get.put(AccViewerServicesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.greyColor,
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset('assets/images/luround_logo.png'),
                    ]
                  ),
                  SizedBox(height: 30.h,),
                  Center(
                    child: Text(
                      "Services",
                      style: GoogleFonts.inter(
                        color: AppColor.blackColor,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                  //SizedBox(height: 10,),
                ],
              ),
            ),         
            /////////////////
      
            SizedBox(height: 20.h,),

            //Futurebuilder will start from here (will wrap this listview)
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h), //external paddin
                itemCount: 8,
                separatorBuilder: (context, index) => SizedBox(height: 25.h,),
                itemBuilder: (context, index) {
                  return Container(
                    //height: 500,
                    width: double.infinity,
                    color: index.isEven ? AppColor.lightRed : AppColor.lightPurple,
                    alignment: Alignment.center,
                    //padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //check if the account owner selected in-person or virtual
                        
                              Center(            
                                child: TogglePriceContainerAccViewer(index: index,)
                              ),
                              SizedBox(height: 40.h,),
                              Text(
                                "Personal Training",
                                style: GoogleFonts.inter(
                                  color: AppColor.blackColor,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                              SizedBox(height: 20.h,),
                              Text(
                                "Mon-Fri . 9:00AM - 10:00PM",
                                style: GoogleFonts.inter(
                                  color: AppColor.textGreyColor,
                                  fontSize: 14.sp,
                                  //fontWeight: FontWeight.w500
                                ),
                              ),
                              SizedBox(height: 20.h,),
                              Text(
                                "zgshxttttttttttttttttttttttthxgfhfcgjcfgjhgyuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuxs",
                                style: GoogleFonts.inter(
                                  color: AppColor.darkGreyColor,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                              SizedBox(height: 20.h,),
                              //link 1
                              InkWell(
                                onTap: () {},
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SvgPicture.asset("assets/svg/link_icon.svg"),
                                    SizedBox(width: 10.w,),
                                    Text(
                                      "https://www.link.com",
                                      style: GoogleFonts.inter(
                                        color: AppColor.blueColor,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20.h,),
                              //link 1
                              InkWell(
                                onTap: () {},
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SvgPicture.asset("assets/svg/link_icon.svg"),
                                    SizedBox(width: 10.w,),
                                    Text(
                                      "https://www.link.com",
                                      style: GoogleFonts.inter(
                                        color: AppColor.blueColor,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 30.h,),
                              //price/session
                              Obx(
                                () {
                                  return RichText(
                                    text: TextSpan(
                                      children: [
                                        //price
                                        TextSpan(
                                          text: controller.isVirtual.value && controller.selectedIndex.value == index ? "N13,000" : "N25,000",
                                          style: GoogleFonts.inter(
                                            color: AppColor.blackColor,
                                            fontSize: 22.sp,
                                            fontWeight: FontWeight.bold
                                          ),
                                        ),
                                        //time
                                        TextSpan(
                                          text: "/30mins",
                                          style: GoogleFonts.inter(
                                            color: AppColor.darkGreyColor,
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w500
                                          ),
                                        ),
                                        //session
                                        TextSpan(
                                          text: " per session",
                                          style: GoogleFonts.inter(
                                            color: AppColor.textGreyColor,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w500
                                          ),
                                        )
                                      ]
                                    ),
                                  );
                                }
                              ),
                              SizedBox(height: 20.h,),
            
                              //request quote                        
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  //price
                                  Text(
                                    "Require a personalized touch?",
                                    style: GoogleFonts.inter(
                                      color: AppColor.textGreyColor,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500
                                    ),
                                  ),
                                  //SizedBox(width: 5,),
                                  //time
                                  TextButton(
                                    onPressed: () {
                                      Get.to(() => RequestQuoteScreen());
                                    },
                                    child: Text(
                                      "Request Quote",
                                        style: GoogleFonts.inter(
                                        color: AppColor.yellowStar,
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w500,
                                        decoration: TextDecoration.underline
                                      ),
                                    ),
                                  ),
                                ]
                              )
                            ]
                          )                                           
                        ),
                        //
                        Container(
                          height: 100.h,
                          width: double.infinity,
                          color: AppColor.bgColor,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                          child: ReusableButton(
                            onPressed: () {
                              Get.to(() => BookAppointmentScreen());
                            },
                            color: AppColor.mainColor,
                            text: "Book Now",
                          ),
                        ),
                      ],
                    ),
                  );
                }
              ),
            ),
            
            ///
          ]
        )
      )
    );
  }
}