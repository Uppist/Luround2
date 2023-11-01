import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/bookins_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/views/account_owner/profile/widget/notifications/notifications_page.dart';








class RescheduleBookingPage extends StatefulWidget {
  RescheduleBookingPage({super.key});

  @override
  State<RescheduleBookingPage> createState() => _RescheduleBookingPageState();
}

class _RescheduleBookingPageState extends State<RescheduleBookingPage> {
  var controller = Get.put(BookingsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image(
                          image: AssetImage('assets/images/luround_logo.png'),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                Get.to(() => NotificationsPage());
                              },
                              child: SvgPicture.asset("assets/svg/notify_active.svg"),
                            ),
                          ],
                        )
                      ]
                    ),
                    const SizedBox(height: 40,),
                    Row(
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
                        SizedBox(width: 3,),
                        Text(
                          "Reschedule",
                          style: GoogleFonts.poppins(
                            color: AppColor.blackColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                      ],
                    ),
                    //SizedBox(height: 30,),
                  ]
                )
              ),
              Container(
                height: 7,
                width: double.infinity,
                color: AppColor.greyColor,
              ),
              SizedBox(height: 20,),
              //WAT
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/svg/earth.svg"),
                  SizedBox(width: 5),
                  Text(
                    "West Africa Standard Time",
                    style: GoogleFonts.inter(
                      color: AppColor.blackColor,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      //decoration: TextDecoration.underline,
                      //decorationStyle: TextDeco
                    ),
                  ),
                  SizedBox(width: 5),
                  /*TextButton(
                    onPressed: (), 
                    child: child
                  )*/
                ],
              ),

            ]
          )
        )
      )
    );
  }
}