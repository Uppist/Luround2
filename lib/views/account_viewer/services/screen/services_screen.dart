import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_viewer/services_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/reusable_button.dart';
import 'package:luround/views/account_viewer/services/widgets/book_a_service/book_a_service.dart';
import 'package:luround/views/account_viewer/services/widgets/request_quote/request_quote_screen.dart';
import 'package:luround/views/account_viewer/services/widgets/services/in-person_meeting.dart';
import 'package:luround/views/account_viewer/services/widgets/services/virtual_meeting.dart';








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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image(
                        image: AssetImage('assets/images/luround_logo.png'),
                      ),
                    ]
                  ),
                  const SizedBox(height: 30,),
                  Center(
                    child: Text(
                      "Services",
                      style: GoogleFonts.inter(
                        color: AppColor.blackColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                  //SizedBox(height: 10,),
                ],
              ),
            ),         
            /////////////////
            ///
            const SizedBox(height: 20,),

            //Futurebuilder will start from here (will wrap this listview)
            Expanded(
              child: ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5), //external paddin
                itemCount: 8,
                separatorBuilder: (context, index) => const SizedBox(height: 25,),
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
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              //check if the account owner selected in-person or virtual
                              //VirtualContainer()  //InpersonContainer()
                              const Center(            
                                child: InpersonContainer()
                              ),
                              const SizedBox(height: 40,),
                              Text(
                                "Personal Training",
                                style: GoogleFonts.inter(
                                  color: AppColor.blackColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                              const SizedBox(height: 20,),
                              Text(
                                "Mon-Fri . 9:00AM - 10:00PM",
                                style: GoogleFonts.inter(
                                  color: AppColor.textGreyColor,
                                  fontSize: 15,
                                  //fontWeight: FontWeight.w500
                                ),
                              ),
                              const SizedBox(height: 20,),
                              Text(
                                "zgshxttttttttttttttttttttttthxgfhfcgjcfgjhgyuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuuxs",
                                style: GoogleFonts.inter(
                                  color: AppColor.darkGreyColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                              const SizedBox(height: 20,),
                              //link 1
                              InkWell(
                                onTap: () {},
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SvgPicture.asset("assets/svg/link_icon.svg"),
                                    const SizedBox(width: 10,),
                                    Text(
                                      "https://www.link.com",
                                      style: GoogleFonts.inter(
                                        color: AppColor.blueColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 20,),
                              //link 1
                              InkWell(
                                onTap: () {},
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SvgPicture.asset("assets/svg/link_icon.svg"),
                                    const SizedBox(width: 10,),
                                    Text(
                                      "https://www.link.com",
                                      style: GoogleFonts.inter(
                                        color: AppColor.blueColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 30,),
                              //price/session
                              RichText(
                                text: TextSpan(
                                  children: [
                                    //price
                                    TextSpan(
                                      text: "N25,000",
                                      style: GoogleFonts.inter(
                                        color: AppColor.blackColor,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                    //time
                                    TextSpan(
                                      text: "/30mins",
                                      style: GoogleFonts.inter(
                                        color: AppColor.darkGreyColor,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500
                                      ),
                                    ),
                                    //session
                                    TextSpan(
                                      text: " per session",
                                      style: GoogleFonts.inter(
                                        color: AppColor.textGreyColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500
                                      ),
                                    )
                                  ]
                                ),
                              ),
                              const SizedBox(height: 20,),
            
                              //request quote                        
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  //price
                                  Text(
                                    "Require a personalized touch?",
                                    style: GoogleFonts.inter(
                                      color: AppColor.textGreyColor,
                                      fontSize: 14,
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
                                        fontSize: 14,
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
                          height: 100,
                          width: double.infinity,
                          color: AppColor.bgColor,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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