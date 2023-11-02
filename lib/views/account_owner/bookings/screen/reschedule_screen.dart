import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:from_to_time_picker/from_to_time_picker.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/bookings_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/custom_snackbar.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import 'package:luround/views/account_owner/bookings/widget/alert_dialogue/reschedule_success.dart';
import 'package:luround/views/account_owner/bookings/widget/bottomsheets/select_date_bottomsheet.dart';
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
          physics: BouncingScrollPhysics(),
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
                    const SizedBox(height: 20,),
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
              SizedBox(height: 10,),
              //WAT
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/svg/earth.svg"),
                  SizedBox(width: 8),
                  Text(
                    "West Africa Standard Time",
                    style: GoogleFonts.inter(
                      color: AppColor.blackColor,
                      fontSize: 14,
                      //fontWeight: FontWeight.w500,
                      //decoration: TextDecoration.underline,
                      //decorationStyle: TextDeco
                    ),
                  ),
                  SizedBox(width: 4),
                  TextButton(
                    onPressed: () {}, 
                    child: Text(
                      "Change",
                      style: GoogleFonts.inter(
                        color: AppColor.mainColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.underline,
                        //decorationStyle: TextDeco
                      ),
                    )
                  )
                ],
              ),
              SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20,),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      //alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                      decoration: BoxDecoration(
                        color: AppColor.lightMainColor2,
                      ),
                      //height: 200,
                      width: double.infinity,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Former",
                            style: GoogleFonts.inter(
                              color: AppColor.darkMainColor,
                              fontSize: 15,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Friday, 14 July 2023",
                                style: GoogleFonts.inter(
                                  color: AppColor.darkGreyColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                              SizedBox(width: 10,),
                              SvgPicture.asset("assets/svg/former.svg"),
                            ],
                          ),
                          SizedBox(height: 30,),
                          Text(
                            "Addiction Intervention Coaching",
                            style: GoogleFonts.inter(
                              color: AppColor.blackColor,
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(height: 30,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "9:00am - 10:00am",
                                style: GoogleFonts.inter(
                                  color: AppColor.darkGreyColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SvgPicture.asset("assets/svg/time_icon.svg"),
                                  SizedBox(width: 5,),
                                  Text(
                                    "45mins",
                                    style: GoogleFonts.inter(
                                      color: AppColor.darkGreyColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ]
                      ),
                    ),
                    SizedBox(height: 30,),
                    Center(
                      child: Text(
                        "Choose a new date",
                        style: GoogleFonts.inter(
                          color: AppColor.blackColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    //select date custom button
                    InkWell(
                      onTap: () {
                        selectDateBottomSheet(
                          context: context, 
                          onCancel: () {
                            Get.back();
                          }, 
                          onApply: () {
                            //LuroundSnackBar.successSnackBar(message: "Date has been confirmed");
                            Get.back();
                          },
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                        alignment: Alignment.centerLeft,
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColor.bgColor,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: AppColor.textGreyColor,
                            width: 1.0, //2
                          )
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(
                              () {
                                return Text(
                                  controller.updatedDate(initialDate: "date data"),
                                  style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                      color: AppColor.textGreyColor,
                                      fontSize: 16,
                                      //fontWeight: FontWeight.w500
                                    )
                                  )           
                                );
                              }
                            ),
                            SvgPicture.asset("assets/svg/calendar_icon.svg"),
                      
                          ],
                        ),
                      )
                    ),
                    SizedBox(height: 30,),
                    Center(
                      child: Text(
                        "Choose a new time",
                        style: GoogleFonts.inter(
                          color: AppColor.blackColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    //select date custom button
                    InkWell(
                      onTap: () {
                        //showLightTimePicker(context: context);
                        controller.openTimeRangePicker(context: context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(
                            () {
                              return Container(
                                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                alignment: Alignment.center,
                                height: 50,
                                width: 150,
                                decoration: BoxDecoration(
                                  color: AppColor.bgColor,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: AppColor.textGreyColor,
                                    width: 1.0, //2
                                  )
                                ),
                                child: Text(
                                  controller.getStartTime(initialTime: "t1"),
                                  style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                      color: AppColor.textGreyColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal
                                    )
                                  )           
                                ),
                              );
                            }
                          ),
                          //SizedBox(width: 10,),             
                          //SizedBox(width: 10,),
                          //2
                          Obx(
                            () {
                              return Container(
                                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                alignment: Alignment.center,
                                height: 50,
                                width: 150,
                                decoration: BoxDecoration(
                                  color: AppColor.bgColor,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                    color: AppColor.textGreyColor,
                                    width: 1.0, //2
                                  )
                                ),
                                child: Text(
                                  controller.getStopTime(initialTime: "t2"),
                                  style: GoogleFonts.inter(
                                    textStyle: TextStyle(
                                      color: AppColor.textGreyColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.normal
                                    )
                                  )           
                                ),
                              );
                            }
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 70,),
                    RebrandedReusableButton(
                      textColor: AppColor.bgColor,
                      color: AppColor.mainColor, 
                      text: "Reschedule", 
                      onPressed: () {
                        rescheduleDialogueBox(context: context);
                      },
                    )
                  ],
                ),
              )

            ]
          )
        )
      )
    );
  }
}