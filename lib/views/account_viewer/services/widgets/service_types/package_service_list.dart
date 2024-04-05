import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_viewer/services_controller.dart';
import 'package:luround/services/account_viewer/services/get_user_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/reusable_button.dart';
import 'package:luround/views/account_viewer/services/widgets/book_a_service/screen/book_a_service.dart';
import 'package:luround/views/account_viewer/services/widgets/request_quote/request_quote_screen.dart';
import 'package:luround/views/account_viewer/services/widgets/toggle_price/toggle_price_package_accviewer.dart';








class PackageServiceListWeb extends StatefulWidget {
  const PackageServiceListWeb({super.key});

  @override
  State<PackageServiceListWeb> createState() => _PackageServiceListWebState();
}

class _PackageServiceListWebState extends State<PackageServiceListWeb> {

  final controller = Get.put(AccViewerServicesController());
  final userService = Get.put(AccViewerService());

  @override
  Widget build(BuildContext context) {

    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0),
      itemCount: 2, //userService.filterSearchServicesList.length,
      separatorBuilder: (context, index) => SizedBox(height: 25.h,),
      itemBuilder: (context, index) {

        //run even and odd checks for dynamism
        final data = userService.filterSearchServicesList[index];

        return Container(
          //height: 500,
          width: double.infinity,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
          decoration: BoxDecoration(
            color: index.isEven ? AppColor.navyBlue : AppColor.darkMainColor,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //SizedBox(height: 10.h),
              //toggle price button
              Center(
                child: TogglePriceContainerAccViewerPackage(index: index)
              ),

              SizedBox(height: 30.h,),
              
              //ALL SUBSEQUENT INFORMATION COMES HERE
              Text(
                "Personal Training",
                style: GoogleFonts.inter(
                  color: AppColor.bgColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600
                ),
              ),
              SizedBox(height: 20.h,),
              //1
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Service type:",
                    style: GoogleFonts.inter(
                      color: AppColor.whiteTextColor,
                      fontSize: 10..sp,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  SizedBox(width: 10.w,),
                  Text(
                    "Package",
                    style: GoogleFonts.inter(
                      color: AppColor.bgColor,
                      fontSize: 12..sp,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ],
              ),

              SizedBox(height: 5.h,),

              //2
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Timeline:",
                    style: GoogleFonts.inter(
                      color: AppColor.whiteTextColor,
                      fontSize: 10..sp,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  SizedBox(width: 10.w,),
                  Text(
                    "3 months",
                    style: GoogleFonts.inter(
                      color: AppColor.bgColor,
                      fontSize: 12..sp,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ],
              ),

              SizedBox(height: 5.h,),

              //3
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Recurrence:",
                    style: GoogleFonts.inter(
                      color: AppColor.whiteTextColor,
                      fontSize: 10..sp,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  SizedBox(width: 10.w,),
                  Expanded(
                    child: Text(
                      "Twice a week (Thursday, Friday)",
                      style: GoogleFonts.inter(
                        color: AppColor.bgColor,
                        fontSize: 12..sp,
                        fontWeight: FontWeight.w500
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 5.h,),

              //4
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Duration:",
                    style: GoogleFonts.inter(
                      color: AppColor.whiteTextColor,
                      fontSize: 10..sp,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  SizedBox(width: 10.w,),
                  Text(
                    "40 mins per session",
                    style: GoogleFonts.inter(
                      color: AppColor.bgColor,
                      fontSize: 12..sp,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20.h,),

              Text(
                "Available from",
                style: GoogleFonts.inter(
                  color: index.isEven ? AppColor.yellowStar : AppColor.limeGreen,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500
                ),
              ),  
              SizedBox(height: 20.h,),
              //1
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Start date:",
                    style: GoogleFonts.inter(
                      color: AppColor.whiteTextColor,
                      fontSize: 10..sp,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  SizedBox(width: 10.w,),
                  Text(
                    "2024-08-12",
                    style: GoogleFonts.inter(
                      color: AppColor.bgColor,
                      fontSize: 12..sp,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5.h,),
              //2
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "End date:",
                        style: GoogleFonts.inter(
                          color: AppColor.whiteTextColor,
                          fontSize: 10..sp,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      SizedBox(width: 10.w,),
                      Text(
                        "2024-09-12",
                        style: GoogleFonts.inter(
                          color: AppColor.bgColor,
                          fontSize: 12..sp,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    ],
                  ),
                  //price
                  Obx(
                    () {
                      return Text(
                        key: Key('price_text_$index'),
                        controller.isVirtualPackage.value && controller.selectedIndexPackage.value == index 
                        ?'N20,000'  //"N${userService.filterSearchServicesList[index].service_charge_virtual}" 
                        :'N40,000',  //"N${userService.filterSearchServicesList[index].service_charge_in_person}",
                        style: GoogleFonts.inter(
                          color: AppColor.bgColor,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w600
                        ),
                        overflow: TextOverflow.ellipsis,
                      );
                    }
                  )
                ],
              ),
              SizedBox(height: 5.h,),
              //3
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Time:",
                        style: GoogleFonts.inter(
                          color: AppColor.whiteTextColor,
                          fontSize: 10..sp,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      SizedBox(width: 10.w,),
                      Text(
                        "9:00 AM - 11:30 PM",
                        style: GoogleFonts.inter(
                          color: AppColor.bgColor,
                          fontSize: 12..sp,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    ],
                  ),
                  //timeline again
                  Text(
                    'for 3 months timeline',
                    style: GoogleFonts.inter(
                      color: AppColor.bgColor,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),

                ],
              ),

              SizedBox(height: 20.h,),

              Text(
                'This service aims at giving you the best personal and quality training',
                style: GoogleFonts.inter(
                  color: AppColor.bgColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400
                ),
              ),

              //quote and booking section
              SizedBox(height: 30.h,),
                           
              //request quote                                  
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //price
                  Text(
                    "Require a personalized touch?",
                    style: GoogleFonts.inter(
                      color: AppColor.whiteTextColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500
                    ),
                  ),

                  SizedBox(width: 5.w,),

                  InkWell(        
                    onTap: () {
                      Get.to(() => RequestQuoteScreen(
                        service_charge_inperson: data.service_charge_in_person!,
                        service_charge_virtual: data.service_charge_virtual!,
                        service_name: data.service_name,
                        service_provider_email: data.service_provider_details['email'],
                        service_provider_name: data.service_provider_details['displayName'], 
                        service_id: data.serviceId,
                      ));
                                        
                      /*Get.toNamed(
                        RequestQuoteRoute,
                        arguments: {
                          'service_charge_inperson': data[index].service_charge_in_person!,
                          'service_charge_virtual': data[index].service_charge_virtual!,
                          'service_name': data[index].service_name,
                          'service_provider_email': data[index].service_provider_details['email'],
                          'service_provider_name': data[index].service_provider_details['displayName'], 
                          'service_id': data[index].serviceId,
                        },
                      );*/
                    },
                    child: Text(
                      "Request Quote",
                      style: GoogleFonts.inter(
                        color: index.isEven ? AppColor.yellowStar : AppColor.limeGreen,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                        decorationColor: index.isEven ? AppColor.yellowStar : AppColor.limeGreen,
                      ),
                    ),
                  ),
                ]
              ),
              
              SizedBox(height: 30.h,),
                                
              //bookings button here
              ReusableButton(
                onPressed: () {
                  Get.to(() => BookAppointmentScreen(
                    service_provider_id: data.service_provider_details['userId'],
                    avail_time: data.available_time,
                    serviceId: data.serviceId,
                    service_name: data.service_name,
                    date: data.date,
                    time: data.time,
                    duration: data.duration!,
                    service_charge_virtual: data.service_charge_virtual!,
                    service_charge_in_person: data.service_charge_in_person!,
                  ));
              
                  /*Get.toNamed(
                    BookingsRoute,
                    arguments: {
                      'service_provider_id': data.service_provider_details['userId'],
                      'avail_time': data.available_time,
                      'serviceId': data.serviceId,
                      'service_name': data.service_name,
                      'date': data.date,
                      'time': data.time,
                      'duration': data.duration!,
                      'service_charge_virtual': data.service_charge_virtual!,
                      'service_charge_in_person': data.service_charge_in_person!,
                    },
                  );*/      
                },
                color: index.isEven ? AppColor.darkMainColor : AppColor.navyBlue,
                text: "Book Now",
              ),

            ]
          )
        );
      }
    );
  }
}