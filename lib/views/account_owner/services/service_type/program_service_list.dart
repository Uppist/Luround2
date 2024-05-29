import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services/program_service/program_service_controller.dart';
import 'package:luround/main.dart';
import 'package:luround/models/account_owner/user_services/user_service_response_model.dart';
import 'package:luround/services/account_owner/services/user_services._service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/views/account_owner/services/screen/service_empty_state.dart';
import 'package:luround/views/account_owner/services/widget/program/add_service/screen/add_service_screen.dart';
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
        return userService.filterSearchServicesList.isNotEmpty ? RefreshIndicator.adaptive(
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
                              max_number_of_participants: data.max_number_of_participants,
                              service: userService,
                              context: context, 
                              userId: data.service_provider_details['userId'],
                              email: data.service_provider_details['email'],
                              displayName: data.service_provider_details['displayName'],
                              serviceId: data.serviceId,
                              service_name: data.service_name,
                              description: data.description,
                              links: data.links ?? [],
                              service_charge_in_person: data.service_charge_in_person ?? '',
                              service_charge_virtual: data.service_charge_virtual ?? '',
                              duration: data.duration ?? '',
                              date: data.date ?? '',
                              time: data.time ?? '',
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
          
                    SizedBox(height: 30.h,),
                    
                    //ALL SUBSEQUENT INFORMATION COMES HERE
                    Text(
                      data.service_name,
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
                          data.service_type,
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
                          '',
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
                            "${data.service_recurrence}",
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
                          "${data.duration} per session",
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
                          "${data.max_number_of_participants}",
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
                          data.start_date,
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
                              data.end_date,
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
                              "${data.start_time} - ${data.end_time}",
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
                          '',
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
        )
        :ServiceEmptyState(
          onPressed: () {
            Get.to(() => AddProgramServiceScreen());
          },
        );
      }
    );
  }
}