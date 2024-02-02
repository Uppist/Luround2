import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:from_to_time_picker/from_to_time_picker.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/bookings/bookings_controller.dart';
import 'package:luround/services/account_owner/bookings_service/user_bookings_services.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/custom_snackbar.dart';
import 'package:luround/utils/components/loader.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import 'package:luround/views/account_owner/bookings/widget/bottomsheets/reschedule_success.dart';
import 'package:luround/views/account_owner/bookings/widget/bottomsheets/select_date_bottomsheet.dart';
import 'package:luround/views/account_owner/profile/widget/notifications/notifications_page.dart';








class RescheduleBookingPage extends StatefulWidget {
  RescheduleBookingPage({super.key, required this.service_date, required this.service_name, required this.service_time, required this.service_duration, required this.bookingId});
  final String service_date;
  final String service_name;
  final String service_time;
  final String service_duration;
  final String bookingId;


  @override
  State<RescheduleBookingPage> createState() => _RescheduleBookingPageState();
}

class _RescheduleBookingPageState extends State<RescheduleBookingPage> {

  var controller = Get.put(BookingsController());
  var service = Get.put(AccOwnerBookingService());
  

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
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /*Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset('assets/images/luround_logo.png'),
                            InkWell(
                              onTap: () {
                                Get.to(() => NotificationsPage());
                              },
                              child: SvgPicture.asset("assets/svg/notify_active.svg"),
                            ),
                          ]
                        ),*/
                        SizedBox(height: 10.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            
                            InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: Icon(
                                Icons.arrow_back_rounded,
                                color: AppColor.blackColor,
                              ),
                            ),
                          
                            SizedBox(width: 10.w,),
                            Text(
                              "Reschedule",
                              style: GoogleFonts.inter(
                                color: AppColor.blackColor,
                                fontSize: 16.sp,
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
                    height: 7.h,
                    width: double.infinity,
                    color: AppColor.greyColor,
                  ),
                  SizedBox(height: 10.h,),
                  //WAT
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset("assets/svg/earth.svg"),
                      SizedBox(width: 8.w),
                      Text(
                        "West Africa Standard Time",
                        style: GoogleFonts.inter(
                          color: AppColor.blackColor,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      TextButton(
                        onPressed: () {}, 
                        child: Text(
                          "Change",
                          style: GoogleFonts.inter(
                            color: AppColor.mainColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                            decorationColor: AppColor.mainColor
                          ),
                        )
                      )
                    ],
                  ),
                  SizedBox(height: 15.h,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          //alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
                          decoration: BoxDecoration(
                            color: AppColor.lightMainColor2,
                          ),
                          //height: 200,
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Former schedule",
                                style: GoogleFonts.inter(
                                  color: AppColor.darkMainColor,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600
                                ),
                              ),
                              SizedBox(height: 20.h,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.service_date,
                                    style: GoogleFonts.inter(
                                      color: AppColor.darkGreyColor,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500
                                    ),
                                  ),
                                  SizedBox(width: 10.w,),
                                  SvgPicture.asset("assets/svg/former.svg"),
                                ],
                              ),
                              SizedBox(height: 30.h,),
                              Text(
                                widget.service_name,
                                style: GoogleFonts.inter(
                                  color: AppColor.blackColor,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600
                                ),
                              ),
                              SizedBox(height: 30.h,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    widget.service_time,
                                    style: GoogleFonts.inter(
                                      color: AppColor.darkGreyColor,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SvgPicture.asset("assets/svg/time_icon.svg"),
                                      SizedBox(width: 5,),
                                      Text(
                                        widget.service_duration,
                                        style: GoogleFonts.inter(
                                          color: AppColor.darkGreyColor,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ]
                          ),
                        ),
                        SizedBox(height: 30.h,),
                        Center(
                          child: Text(
                            "Choose a new date",
                            style: GoogleFonts.inter(
                              color: AppColor.blackColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h,),
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
                            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                            alignment: Alignment.centerLeft,
                            height: 50.h,
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
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400
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
                        SizedBox(height: 30.h,),
                        Center(
                          child: Text(
                            "Choose a new time",
                            style: GoogleFonts.inter(
                              color: AppColor.blackColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h,),
                        //select date custom button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Obx(
                              () {
                                return InkWell(
                                  onTap: () {
                                    controller.openFlutterTimePickerForStartTime(context: context);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                                    alignment: Alignment.center,
                                    height: 50.h,
                                    width: 150.w,
                                    decoration: BoxDecoration(
                                      color: AppColor.bgColor,
                                      borderRadius: BorderRadius.circular(5.r),
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
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400
                                        )
                                      )           
                                    ),
                                  ),
                                );
                              }
                            ),
                            
                            Divider(color: AppColor.textGreyColor, ),
                            //SizedBox(width: 10,),             
                            //SizedBox(width: 10,),
                            //2
                            Obx(
                              () {
                                return InkWell(
                                  onTap: () {
                                    controller.openFlutterTimePickerForStopTime(context: context)
                                    .whenComplete(() {
                                      controller.calculateDuration(
                                        startTime: controller.getStartTime(initialTime: "t1"), 
                                        endTime: controller.getStopTime(initialTime: "t2"),
                                      );
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                    alignment: Alignment.center,
                                    height: 50.h,
                                    width: 150.w,
                                    decoration: BoxDecoration(
                                      color: AppColor.bgColor,
                                      borderRadius: BorderRadius.circular(5.r),
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
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w400
                                        )
                                      )           
                                    ),
                                  ),
                                );
                              }
                            ),
                          ],
                        ),
                        SizedBox(height: 110.h,),
                        Obx(
                          () {
                            return service.isLoading.value ? Loader()
                              :RebrandedReusableButton(
                                textColor: AppColor.bgColor,
                                color: AppColor.mainColor, 
                                text: "Reschedule", 
                                onPressed: () {
                                  service.rescheduleBooking(
                                    context: context, 
                                    bookingId: widget.bookingId, 
                                    date: controller.updatedDate(initialDate: widget.service_date), 
                                    //time: "${controller.getStartTime(initialTime: controller.splitTimeRangeT1(timeRange: widget.service_time))} - ${controller.getStopTime(initialTime: controller.splitTimeRangeT2(timeRange: widget.service_time))}"
                                    time: "${controller.getStartTime(initialTime: "t1")} - ${controller.getStopTime(initialTime: "t2")}",
                                    duration: ""
                                  );
                                  //rescheduleDialogueBox(context: context);
                                },
                              );
                          }
                        ),
                        SizedBox(height: 20.h,),
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