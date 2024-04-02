import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services/program_service/program_service_controller.dart';
import 'package:luround/services/account_owner/services/user_services._service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/views/account_owner/services/widget/program/edit_service/screen/edit_service_bottomsheet.dart';
import 'package:luround/views/account_owner/services/widget/screen_widget/toggle_service_price_container/toggle_price_program.dart';








class ProgramServiceList extends StatefulWidget {
  const ProgramServiceList({super.key});

  @override
  State<ProgramServiceList> createState() => _ProgramServiceListState();
}

class _ProgramServiceListState extends State<ProgramServiceList> {

  final controller = Get.put(ProgramServiceController());
  final AccOwnerServicePageService userService = Get.put(AccOwnerServicePageService());

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0),
      itemCount: 1, //userService.filterSearchServicesList.length,
      separatorBuilder: (context, index) => SizedBox(height: 25.h,),
      itemBuilder: (context, index) {
        
        //run even and odd checks for dynamism

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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //check if the account owner selected in-person or virtual
                  TogglePriceContainerProgramService(index: index,),
                  InkWell(
                    onTap: () {
                      editProgramServiceDialogueBox(
                        service_link: userService.filterSearchServicesList[index].service_link,
                        context: context, 
                        userId: userService.filterSearchServicesList[index].service_provider_details['userId'],
                        email: userService.filterSearchServicesList[index].service_provider_details['email'],
                        displayName: userService.filterSearchServicesList[index].service_provider_details['displayName'],
                        serviceId: userService.filterSearchServicesList[index].serviceId,
                        service_name: userService.filterSearchServicesList[index].service_name,
                        description: userService.filterSearchServicesList[index].description!,
                        links: userService.filterSearchServicesList[index].links,
                        service_charge_in_person: userService.filterSearchServicesList[index].service_charge_in_person!,
                        service_charge_virtual: userService.filterSearchServicesList[index].service_charge_virtual!,
                        duration: userService.filterSearchServicesList[index].duration!,
                        date: userService.filterSearchServicesList[index].date,
                        time: userService.filterSearchServicesList[index].time,
                        available_days: userService.filterSearchServicesList[index].available_days
                      );
                    },
                    child: Icon(
                      Icons.more_vert_rounded,
                      color: AppColor.bgColor,
                      size: 30.r,
                    ),
                  ),                                   
                ],
              ),

              SizedBox(height: 30.h,),
              
              //ALL SUBSEQUENT INFORMATION COMES HERE
              Text(
                "Backend with Django",
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
                    "Program",
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
                    "6 months",
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
                    "Service recurrence:",
                    style: GoogleFonts.inter(
                      color: AppColor.whiteTextColor,
                      fontSize: 10..sp,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  SizedBox(width: 10.w,),
                  Expanded(
                    child: Text(
                      "Once a week (Thursday, Friday)",
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

              SizedBox(height: 5.h,),

              //5
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Max no. of participants:",
                    style: GoogleFonts.inter(
                      color: AppColor.whiteTextColor,
                      fontSize: 10..sp,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                  SizedBox(width: 10.w,),
                  Text(
                    "45",
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
                    "2024-05-02",
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
                        "2024-10-03",
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
                        //key: Key('price_text_$index'),
                        controller.isVirtual.value && controller.selectedIndex.value == index 
                        ?'N50,000'  //"N${userService.filterSearchServicesList[index].service_charge_virtual}" 
                        :'N80,000',  //"N${userService.filterSearchServicesList[index].service_charge_in_person}",
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
                        "10:00 AM - 12:30 PM",
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
                'This service aims at giving you the best coding experience with micro-services',
                style: GoogleFonts.inter(
                  color: AppColor.bgColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400
                ),
              ),

            ]
          )
        );
      }
    );
  }
}