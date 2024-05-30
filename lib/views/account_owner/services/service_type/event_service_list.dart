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
import 'package:luround/views/account_owner/services/widget/screen_widget/toggle_service_price_container/toggle_price_program.dart';








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
    print('refreshed program service list: ${userService.filterSearchServicesList}');
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
    return Builder(
      builder: (context) {
        return 
        
        /*userService.filterSearchServicesList.isEmpty
        ?ServiceEmptyState(
          onPressed: () {
            Get.to(() => AddEventScreen());
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
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0),
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
                            /*editEventDialogueBox(
                              //service_link: data.service_link,
                              service: userService,
                              context: context, 
                              userId: data.service_provider_details['userId'],
                              email: data.service_provider_details['email'],
                              displayName: data.service_provider_details['displayName'],
                              serviceId: data.serviceId,
                              service_name: data.service_name,
                              description: data.description,
                              meetingLink: data.virtual_meeting_link,
                              location: data.physical_location_address,
                              inPersonFee: data.service_charge_in_person,
                              virtualFee: data.service_charge_virtual,
                              service_charge_in_person: data.service_charge_in_person,
                              service_charge_virtual: data.service_charge_virtual,
                              
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
                            text: 'Service type: ',
                            style: GoogleFonts.inter(
                              color: AppColor.whiteTextColor,
                              fontSize: 12..sp,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          TextSpan(
                            text: 'event',
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
                        //event_type == "Multiple dates"
                        //Single date widget
                        Column(
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
                              "19 June, 2024",
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
                                    text: '10:30 AM',
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
                                    text: '11:30 AM',
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
                        ),
                        
                        
                        /*Expanded(
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
                                  itemCount: 2, //data.available_schedule.length,
                                  separatorBuilder: (context, index) => SizedBox(height: 10.h,),
                                  itemBuilder: (context, index) {
                                    return RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text: '20/05/2023:  ',
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
                            ]
                          ),
                        ),*/





                        //price
                        /*Obx(
                          () {
                            return Text(
                              //key: Key('price_text_$index'),
                              controller.isVirtual.value && controller.selectedIndex.value == index 
                              ? data.service_charge_virtual.isNotEmpty ? "${currency(context).currencySymbol}${data.service_charge_virtual}" : "FREE"
                              : data.service_charge_in_person.isNotEmpty ? "${currency(context).currencySymbol}${data.service_charge_in_person}" : "FREE",
                              style: GoogleFonts.inter(
                                color: AppColor.bgColor,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600
                              ),
                              overflow: TextOverflow.ellipsis,
                            );
                          }
                        )*/
                        //pop up menu button
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          //mainAxisAlignment: MainAxisAlignment.start,
                          children: [

                            //pop up menu button for toggling in-between price,          
                            PopupMenuFilterStr(
                              //hint: Text('Select Price Type'),
                              index: index, //selectedDurationIndex.value,
                              selectedValue: selectedPriceType,
                              onChanged: (String? priceType) {
                                setState(() {
                                  selectedPriceType.value = priceType!;
                                  //selectedPriceTypes[index] = priceType!;
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
                            if (selectedDurationIndex != null)
                            Text(
                              key: Key('price_text_$index'),
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
        
                          ],
                        )

                      ],
                    ),
                    
                         
                    SizedBox(height: 40.h,),
          
                    Text(
                      'fffffffffffffyjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjjj', //data.description,
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