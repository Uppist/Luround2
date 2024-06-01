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
import 'package:luround/views/account_owner/services/widget/program/add_service/screen/add_service_screen.dart';
import 'package:luround/views/account_owner/services/widget/program/edit_service/screen/edit_service_bottomsheet.dart';
import 'package:luround/views/account_owner/services/widget/screen_widget/popup_menu/popup_menu.dart';








class ProgramServiceList extends StatefulWidget {
  const ProgramServiceList({super.key});

  @override
  State<ProgramServiceList> createState() => _ProgramServiceListState();
}

class _ProgramServiceListState extends State<ProgramServiceList> {

  final controller = Get.put(ProgramServiceController());
  final AccOwnerServicePageService userService = Get.put(AccOwnerServicePageService());

  //GlobalKey for RefreshIndicator
  final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();
  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 1));
    // Fetch new data here
    final List<UserServiceModel>  newData = await userService.getUserProgramServices();
    // Update the UI with the new data
    userService.filterSearchServicesList.clear();
    userService.filterSearchServicesList.addAll(newData);
    print('refreshed program service list: ${userService.filterSearchServicesList}');
  }

  @override
  void initState() {
    super.initState();
    //regular services
    userService.getUserProgramServices().then(
      (value) {
        // Update the UI with the new data
        userService.filterSearchServicesList.clear();
        userService.filterSearchServicesList.addAll(value);
        print('updated program service list: ${userService.filterSearchServicesList}');
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
            Get.to(() => const AddProgramServiceScreen());
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
                        
                        Text(
                          data.serviceName,
                          style: GoogleFonts.inter(
                            color: AppColor.bgColor,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w800
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            editProgramServiceDialogueBox(
                              service_status: data.serviceStatus,
                              max_number_of_participants: data.maxNumberOfParticipants,
                              service: userService,
                              context: context, 
                              userId: data.serviceProviderDetails.userId,
                              email: data.serviceProviderDetails.email,
                              displayName: data.serviceProviderDetails.displayName,
                              serviceId: data.serviceId,
                              service_name: data.serviceName,
                              description: data.description,
                              links: data.links,
                              service_charge_in_person: data.serviceChargeInPerson,
                              service_charge_virtual: data.serviceChargeVirtual,
                              duration: data.duration,
                              date: data.date,
                              time: data.time,
                              available_days: '',
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
                            text: 'Service type:  ',
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
          
                    SizedBox(height: 10.h,),
          
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Duration:  ',
                            style: GoogleFonts.inter(
                              color: AppColor.whiteTextColor,
                              fontSize: 12..sp,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          TextSpan(
                            text: data.duration,
                            style: GoogleFonts.inter(
                              color: AppColor.bgColor,
                              fontSize: 12..sp,
                              fontWeight: FontWeight.w500
                            ),
                          )
                        ]
                      )
                    ),

                    SizedBox(height: 10.h,),
          
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Recurrence:  ',
                            style: GoogleFonts.inter(
                              color: AppColor.whiteTextColor,
                              fontSize: 12..sp,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          TextSpan(
                            text: data.serviceRecurrence,
                            style: GoogleFonts.inter(
                              color: AppColor.bgColor,
                              fontSize: 12..sp,
                              fontWeight: FontWeight.w500
                            ),
                          )
                        ]
                      )
                    ),
          
                    SizedBox(height: 10.h,),
          
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Max no. of participants:  ',
                            style: GoogleFonts.inter(
                              color: AppColor.whiteTextColor,
                              fontSize: 12..sp,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          TextSpan(
                            text: data.maxNumberOfParticipants.toString(),
                            style: GoogleFonts.inter(
                              color: AppColor.bgColor,
                              fontSize: 12..sp,
                              fontWeight: FontWeight.w500
                            ),
                          )
                        ]
                      )
                    ),
          
                    SizedBox(height: 10.h,),
          
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Start date:  ',
                            style: GoogleFonts.inter(
                              color: AppColor.whiteTextColor,
                              fontSize: 12..sp,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          TextSpan(
                            text: data.startDate,
                            style: GoogleFonts.inter(
                              color: AppColor.bgColor,
                              fontSize: 12..sp,
                              fontWeight: FontWeight.w500
                            ),
                          )
                        ]
                      )
                    ),
          
                    SizedBox(height: 10.h,),
          
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'End date:  ',
                            style: GoogleFonts.inter(
                              color: AppColor.whiteTextColor,
                              fontSize: 12..sp,
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
          
                    SizedBox(height: 40.h,),
          
                    //PRICING SECTION
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //time allocation pop_up_menu
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            //mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Available on",
                                style: GoogleFonts.inter(
                                  color: index.isEven ? AppColor.yellowStar : AppColor.limeGreen,  //AppColor.yellowStar,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500
                                ),
                              ), 
                          
                              SizedBox(height: 20.h,),
                          
                              //available schedule list
                              ListView.separated(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                physics: const NeverScrollableScrollPhysics(),
                                //padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0.h), //external paddin
                                itemCount: data.availabilitySchedule.length,
                                separatorBuilder: (context, index) => SizedBox(height: 10.h,),
                                itemBuilder: (context, index) {

                                  final availData = data.availabilitySchedule[index];
                                  return RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: '${availData.availability_day}:  ',
                                          style: GoogleFonts.inter(
                                            color: AppColor.bgColor,
                                            fontSize: 12..sp,
                                            fontWeight: FontWeight.w500
                                          ),
                                        ),
                                        TextSpan(
                                          text: '${availData.from_time}  - ${availData.to_time}',
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
                          
                            ],
                          ),
                        ),
                        
                        //pop up menu button
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          //mainAxisAlignment: MainAxisAlignment.start,
                          children: [

                            //pop up menu button for toggling in-between price,          
                            PopupMenuFilterStr(
                              index: index,
                              selectedValue: controller.selectedFieldIndex,
                              onChanged: (p0) {
                                setState(() {
                                  controller.selectedFieldIndex.value = p0!;  
                                  controller.selectedDurationIndex.value = index;  
                                  log(controller.selectedFieldIndex.value);            
                                });
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
                                }
                              ).toList(),      
                            ),

                            //wrap with obx
                            Obx(
                              () {
                                //&& controller.selectedDurationIndex.value == index
                                return Text(
                                  controller.selectedFieldIndex.value == 'Virtual' ?
                                  'ff': 'gg',
                                  //"${currency(context).currencySymbol}${data.pricing[index].virtual_pricing}"
                                  //:"${currency(context).currencySymbol}${data.pricing[index].in_person_pricing}",
                                  
                                  //? data.service_charge_virtual.isNotEmpty ? "${currency(context).currencySymbol}${data.service_charge_virtual}" : "FREE"
                                  //: data.service_charge_in_person.isNotEmpty ? "${currency(context).currencySymbol}${data.service_charge_in_person}" : "FREE",
                                  style: GoogleFonts.inter(
                                    color: AppColor.bgColor,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w600
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                );
                              }
                            ),
                            SizedBox(height: 5.h,),
                            Text(
                              "for ${data.duration} duration",
                              style: GoogleFonts.inter(
                                color: AppColor.whiteTextColor,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w500
                              ),
                            ),
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