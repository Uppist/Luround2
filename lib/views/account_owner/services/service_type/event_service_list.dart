import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services/program_service/program_service_controller.dart';
import 'package:luround/main.dart';
import 'package:luround/models/account_owner/user_services/user_service_response_model.dart';
import 'package:luround/services/account_owner/services/user_services_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/views/account_owner/services/screen/service_empty_state.dart';
import 'package:luround/views/account_owner/services/widget/event/add_event/screen/add_event_screen.dart';
import 'package:luround/views/account_owner/services/widget/event/edit_event/screen/edit_event_bottomsheet.dart';
import 'package:luround/views/account_owner/services/widget/screen_widget/popup_menu/popup_menu.dart';








class EventServiceList extends StatefulWidget {
  const EventServiceList({super.key});

  @override
  State<EventServiceList> createState() => _EventServiceListState();
}

class _EventServiceListState extends State<EventServiceList> {


  final controller = Get.put(ProgramServiceController());
  final AccOwnerServicePageService userService = Get.put(AccOwnerServicePageService());

  //GlobalKey for RefreshIndicator
  final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();
  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 1));
    // Fetch new data here
    final List<UserServiceModel>  newData = await userService.getUserEventServices();
    // Update the UI with the new data
    userService.filterSearchServicesList.clear();
    userService.filterSearchServicesList.addAll(newData);
    print('refreshed event service list: ${userService.filterSearchServicesList}');
  }




  @override
  void initState() {
    super.initState();
    //regular services
    userService.getUserEventServices().then(
      (value) {
        // Update the UI with the new data
        userService.filterSearchServicesList.clear();
        userService.filterSearchServicesList.addAll(value);
        print('updated event service list: ${userService.filterSearchServicesList}');
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return 
        
        userService.filterSearchServicesList.isEmpty
        ?ServiceEmptyState(
          onPressed: () {
            Get.to(() => AddEventScreen());
          },
        ):
        
        RefreshIndicator.adaptive(
          color: AppColor.greyColor,
          backgroundColor: AppColor.mainColor,
          key: _refreshKey,
          onRefresh: () {
            return _refresh();
          },
          child: ListView.separated(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0),
            itemCount: userService.filterSearchServicesList.length,
            separatorBuilder: (context, index) => SizedBox(height: 25.h,),
            itemBuilder: (context, index) {
              
              //run even and odd checks for dynamism
              final data = userService.filterSearchServicesList[index];
              //selectedPriceType.value =  data.pricing[index].virtual_pricing;
          
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
                        Expanded(
                          child: Text(
                            data.serviceName,
                            style: GoogleFonts.inter(
                              color: AppColor.bgColor,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w800
                            ),
                            overflow: TextOverflow.clip,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            editEventDialogueBox(
                              //service_link: data.service_link,
                              service_status: data.serviceStatus,
                              service: userService,
                              context: context, 
                              userId: data.serviceProviderDetails.userId,
                              email: data.serviceProviderDetails.email,
                              displayName: data.serviceProviderDetails.displayName,
                              serviceId: data.serviceId,
                              service_name: data.serviceName,
                              description: data.description,
                              meetingLink: data.virtualMeetingLink,
                              location: data.physicalLocationAddress,
                              inPersonFee: data.serviceChargeInPerson,
                              virtualFee: data.serviceChargeVirtual,
                              service_charge_in_person: data.serviceChargeInPerson,
                              service_charge_virtual: data.serviceChargeVirtual,            
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
          
                    SizedBox(height: 20.h,),
                    
                    //ALL SUBSEQUENT INFORMATION COMES HERE
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Service type: ',
                            style: GoogleFonts.inter(
                              color: AppColor.whiteTextColor,
                              fontSize: 12..sp,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          TextSpan(
                            text: data.serviceType.capitalizeFirst,
                            style: GoogleFonts.inter(
                              color: AppColor.bgColor,
                              fontSize: 12..sp,
                              fontWeight: FontWeight.w500
                            ),
                          )
                        ]
                      )
                    ),
          
                    SizedBox(height: 20.h,),

                    //SizedBox(height: 10.h,),
          
                    
                    //2
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [

                        data.eventType == "Single date"

                        //Single date widget
                        ?Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          //mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Event schedule",
                              style: GoogleFonts.inter(
                                color: index.isEven ? AppColor.yellowStar : AppColor.limeGreen,  //AppColor.yellowStar,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500
                              ),
                            ), 
                            SizedBox(height: 10.h),
                            Text(
                              data.date,
                              style: GoogleFonts.inter(
                                color: AppColor.bgColor,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500
                              ),
                            ), 
                            SizedBox(height: 10.h,),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Start time:  ',
                                    style: GoogleFonts.inter(
                                      color: AppColor.whiteTextColor,
                                      fontSize: 10..sp,
                                      fontWeight: FontWeight.w500
                                    ),
                                  ),
                                  TextSpan(
                                    text: data.startTime,
                                    style: GoogleFonts.inter(
                                      color: AppColor.bgColor,
                                      fontSize: 12..sp,
                                      fontWeight: FontWeight.w500
                                    ),
                                  )
                                ]
                              )
                            ),
                            SizedBox(height: 5.h,),
                            RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Stop time:  ',
                                    style: GoogleFonts.inter(
                                      color: AppColor.whiteTextColor,
                                      fontSize: 10..sp,
                                      fontWeight: FontWeight.w500
                                    ),
                                  ),
                                  TextSpan(
                                    text: data.endDate,
                                    style: GoogleFonts.inter(
                                      color: AppColor.bgColor,
                                      fontSize: 12..sp,
                                      fontWeight: FontWeight.w500
                                    ),
                                  )
                                ]
                              )
                            ),
                          ],
                        )
                        
                        //Multiple date widget
                        :Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            //mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Event schedule",
                                style: GoogleFonts.inter(
                                  color: index.isEven ? AppColor.yellowStar : AppColor.limeGreen,  //AppColor.yellowStar,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500
                                ),
                              ), 
                              SizedBox(height: 10.h),
                              //available schedule list
                              ListView.separated(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                physics: const NeverScrollableScrollPhysics(),
                                //padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0.h), //external paddin
                                itemCount: data.eventSchedule.length,
                                separatorBuilder: (context, index) => SizedBox(height: 10.h,),
                                itemBuilder: (context, index) {

                                  final eventData = data.eventSchedule[index];

                                  return RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: '${eventData.date}:  ',
                                          style: GoogleFonts.inter(
                                            color: AppColor.bgColor,
                                            fontSize: 12..sp,
                                            fontWeight: FontWeight.w500
                                          ),
                                        ),
                                        TextSpan(
                                          text: '${eventData.time}  - ${eventData.end_time}',
                                          style: GoogleFonts.inter(
                                            color: AppColor.bgColor,
                                            fontSize: 12..sp,
                                            fontWeight: FontWeight.w500
                                          ),
                                        )
                                      ]
                                    )
                                  );
                                }
                              ),
                            ]
                          ),
                        ),


                        //pop up menu button
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          //mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                          
                            ////////////////////
                            PopupMenuFilterStr(
                              index: index,
                              selectedValue: controller.selectedFieldIndex,
                              onChanged: (p0) {
                                controller.selectedFieldIndex.value = p0!;
                                log(controller.selectedDurationIndex.value.toString());
                                log(controller.selectedFieldIndex.value);
                              },
                              items: <String>['Virtual', 'In-person']
                                .map<DropdownMenuItem<String>> ((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: GoogleFonts.inter(
                                      color: AppColor.bgColor,
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w500,
                                    )
                                  ),
                                );
                              }).toList(),
                            ),

                            SizedBox(height: 5.h,),

                            Obx(
                              () {
                                return Text(
                                  controller.selectedFieldIndex.value == 'Virtual' ? data.serviceChargeVirtual.isNotEmpty ? currency(context).currencySymbol + data.serviceChargeVirtual : 'FREE' : data.serviceChargeInPerson.isNotEmpty ? currency(context).currencySymbol + data.serviceChargeInPerson : 'FREE',
                                  //"${currency(context).currencySymbol}${data.pricing[index].virtual_pricing}"
                                  //:"${currency(context).currencySymbol}${data.pricing[index].in_person_pricing}",
                                  style: GoogleFonts.inter(
                                    color: AppColor.bgColor,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w600
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                );
                              }
                            ),
                            ///////////////////


        
                          ],
                        )

                      ],
                    ),
                         
                    SizedBox(height: 40.h,),
          
                    Text(
                      data.description,
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
          ),
        );
      
      }
    );
  }
}