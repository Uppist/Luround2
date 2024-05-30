import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services/one-off/oneoff_service_controller.dart';
import 'package:luround/main.dart';
import 'package:luround/models/account_owner/user_services/user_service_response_model.dart';
import 'package:luround/services/account_owner/services/user_services_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/views/account_owner/services/widget/screen_widget/popup_menu/popup_menu.dart';
import 'package:luround/views/account_owner/services/widget/screen_widget/toggle_service_price_container/toggle_price_regular.dart';











class RegularServiceList extends StatefulWidget {
  const RegularServiceList({super.key});

  @override
  State<RegularServiceList> createState() => _RegularServiceListState();
}

class _RegularServiceListState extends State<RegularServiceList> {

  final controller = Get.put(ServicesController());
  final AccOwnerServicePageService userService = Get.put(AccOwnerServicePageService());
  
  //GlobalKey for RefreshIndicator
  final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();
  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 1));
    // Fetch new data here
    final List<UserServiceModel>  newData = await userService.getUserOneOffServices();
    // Update the UI with the new data
    userService.filterSearchServicesList.clear();
    userService.filterSearchServicesList.addAll(newData);
    print('refreshed regular service list: ${userService.filterSearchServicesList}');
  }

  @override
  void initState() {
    super.initState();
    //one-off services
    userService.getUserOneOffServices().then(
      (value) {
        // Update the UI with the new data
        userService.filterSearchServicesList.clear();
        userService.filterSearchServicesList.addAll(value);
        print('updated one-off service list: ${userService.filterSearchServicesList}');
      }
    );
    
  }

  //ztester
  final List<Map<String, dynamic>> popuplist = [
    {
      "duration": "30 mins",
      "virtual_price": "20000",
      "inperson_price": "30000"
    },
    {
      "duration": "10 mins",
      "virtual_price": "2000",
      "inperson_price": "40000"
    },
    {
      "duration": "20 mins",
      "virtual_price": "70000",
      "inperson_price": "40000"
    },
  ];
  
  //PUT IN THE CONTROLLER
  RxInt selectedDurationIndex = 0.obs;
  RxString selectedPriceType = 'virtual_price'.obs;


  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return 

        /*userService.filterSearchServicesList.isEmpty
        ?ServiceEmptyState(
          onPressed: () {
            Get.to(() => AddServiceScreen());
          },
        ):*/

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
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0.h), //external paddin
            itemCount: 1, //userService.filterSearchServicesList.length,
            separatorBuilder: (context, index) => SizedBox(height: 25.h,),
            itemBuilder: (context, index) {
              
              //run even and odd checks for dynamism

              //final data = userService.filterSearchServicesList[index];
          
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
                          'Personal Training', //data.service_name,
                          style: GoogleFonts.inter(
                            color: AppColor.bgColor,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w800
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            /*editServiceDialogueBox(
                              //service_link: data.service_link,
                              service: userService,
                              context: context, 
                              userId: data.service_provider_details['userId'],
                              email: data.service_provider_details['email'],
                              displayName: data.service_provider_details['displayName'],
                              serviceId: data.serviceId,
                              service_name: data.service_name,
                              description: data.description,
                              virtual_meeting_link: data.virtual_meeting_link,
                              service_charge_in_person: data.service_charge_in_person,
                              service_charge_virtual: data.service_charge_virtual,
                              duration: data.duration,
                              date: data.date,
                              time: data.time,
                              available_days: '',
                            );*/
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
                            text: 'one-off',
                            style: GoogleFonts.inter(
                              color: AppColor.bgColor,
                              fontSize: 12..sp,
                              fontWeight: FontWeight.w500
                            ),
                          )
                        ]
                      )
                    ),
          
                    SizedBox(height: 25.h,),
          
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
                      itemCount: 2, //data.available_schedule.length,
                      separatorBuilder: (context, index) => SizedBox(height: 10.h,),
                      itemBuilder: (context, index) {
                        return RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Monday:  ',
                                style: GoogleFonts.inter(
                                  color: AppColor.bgColor,
                                  fontSize: 12..sp,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                              TextSpan(
                                text: '10:00 AM  - 12:00 PM',
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

                    SizedBox(height: 30.h,),
                    
                    //PRICING SECTION
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //time allocation pop_up_menu
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Pricing:',
                              style: GoogleFonts.inter(
                                color: AppColor.whiteTextColor,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(width: 3.w,),
                            PopupMenuFilterInt(
                              index: index, //selectedDurationIndex.value,
                              selectedValue: selectedDurationIndex,
                              onChanged: (p0) {
                                setState(() {
                                  selectedDurationIndex.value = p0!;                       
                                });
                              },
                              items: List.generate(
                                popuplist.length, 
                                (index) {
                                  return DropdownMenuItem<int>(
                                    value: index,
                                    child: Text(
                                      popuplist[index]['duration'],
                                      style: GoogleFonts.inter(
                                        color: AppColor.blueColor,
                                        fontSize: 14.sp,
                                        //fontWeight: FontWeight.w500
                                      ),
                                    ),
                                  );
                                }
                              )
                            )
                          ],
                        ),
                        
                        //pop up menu button
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            //pop up menu button for toggling in-between price,          
                            PopupMenuFilterStr(
                              //hint: Text('Select Price Type'),
                              index: selectedDurationIndex.value,
                              selectedValue: selectedPriceType,
                              onChanged: (String? priceType) {
                                setState(() {
                                  selectedPriceType.value = priceType!;
                                });
                              },
                              items: [
                                DropdownMenuItem<String>(
                                  value: 'virtual_price',
                                  child: Text(
                                    'virtual',
                                    style: GoogleFonts.inter(
                                      color: AppColor.blueColor,
                                      fontSize: 14.sp,
                                      //fontWeight: FontWeight.w500
                                    ),
                                  ),
                                ),
                                DropdownMenuItem<String>(
                                  value: 'inperson_price',
                                  child: Text(
                                    'in-person',
                                    style: GoogleFonts.inter(
                                      color: AppColor.blueColor,
                                      fontSize: 14.sp,
                                      //fontWeight: FontWeight.w500
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            //SizedBox(height: 10.h,),

                            //wrap with obx
                            //if (selectedDurationIndex != null)
                            Text(
                              "${currency(context).currencySymbol}${popuplist[selectedDurationIndex.value][selectedPriceType]}",
                              
                              //key: Key('price_text_$index'),
                              //controller.isVirtual.value && controller.selectedIndex.value == index 
                              //? data.service_charge_virtual.isNotEmpty ? "${currency(context).currencySymbol}${data.service_charge_virtual}" : "FREE"
                              //: data.service_charge_in_person.isNotEmpty ? "${currency(context).currencySymbol}${data.service_charge_in_person}" : "FREE",
                              style: GoogleFonts.inter(
                                color: AppColor.bgColor,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 5.h,),
                            Text(
                              "for ${popuplist[selectedDurationIndex.value]['duration']} session",
                              style: GoogleFonts.inter(
                                color: AppColor.whiteTextColor,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w500
                              ),
                                    ),
                            /*Text(
                              'for 15 mins session', 
                              style: GoogleFonts.inter(
                                color: AppColor.whiteTextColor,
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w500
                              ),
                            ),*/
                          ],
                        )
                      ],
                    ),
          
                    SizedBox(height: 40.h,),
          
                    Text(
                      'hfghfghfgchcgjghjhjkvhjvhjkhcjhjxhcgghjgggggggggggggggggggggggggggggggggg',//data.description,
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