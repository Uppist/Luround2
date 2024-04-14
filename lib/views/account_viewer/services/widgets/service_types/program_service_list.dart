import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_viewer/services_controller.dart';
import 'package:luround/models/account_owner/user_services/user_service_response_model.dart';
import 'package:luround/services/account_viewer/services/get_user_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/my_snackbar.dart';
import 'package:luround/utils/components/reusable_button.dart';
import 'package:luround/views/account_owner/services/screen/service_empty_state.dart';
import 'package:luround/views/account_viewer/services/widgets/bookings/program_booking/screen/book_a_service.dart';
import 'package:luround/views/account_viewer/services/widgets/request_quote/request_quote_screen.dart';
import 'package:luround/views/account_viewer/services/widgets/toggle_price/toggle_price_program_accviewer.dart';







class ProgramServiceListWeb extends StatefulWidget {
  const ProgramServiceListWeb({super.key, required this.userName});
  final String userName;

  @override
  State<ProgramServiceListWeb> createState() => _ProgramServiceListWebState();
}

class _ProgramServiceListWebState extends State<ProgramServiceListWeb> {

  final controller = Get.put(AccViewerServicesController());
  final userService = Get.put(AccViewerService());

  //GlobalKey for RefreshIndicator
  final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();
  Future<void> _refresh() async {
    await Future.delayed(const Duration(seconds: 1));
    // Fetch new data here
    final List<UserServiceModel>  newData = await userService.getUserProgramServices(userName: widget.userName);
    // Update the UI with the new data
    userService.filterSearchServicesList.clear();
    userService.filterSearchServicesList.addAll(newData);
    print('refreshed program service list: ${userService.filterSearchServicesList}');
  }

  @override
  void initState() {
    super.initState();
    //regular services
    userService.getUserProgramServices(userName: widget.userName).then(
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
                    Center(
                      child: TogglePriceContainerAccViewerProgram(index: index)
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
                          data.service_timeline,
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
                            "${data.service_recurrence} (${data.timeline_days})",
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
                              controller.isVirtualProgram.value && controller.selectedIndexProgram.value == index 
                              ?"N${data.service_charge_virtual}" 
                              :"N${data.service_charge_in_person}",
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
                          'for ${data.service_timeline} timeline',
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
                              service_charge_inperson: data.service_charge_in_person,
                              service_charge_virtual: data.service_charge_virtual,
                              service_name: data.service_name,
                              service_provider_email: data.service_provider_details['email'],
                              service_provider_name: data.service_provider_details['displayName'], 
                              service_id: data.serviceId,
                            ),
                            transition: Transition.rightToLeft
                            );
                                              
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
                        Get.to(() => BookAppointmentScreenProgram(
                          service_provider_id: data.service_provider_details['userId'],
                          serviceId: data.serviceId,
                          service_name: data.service_name,
                          date: "${data.start_date} - ${data.end_date}",
                          time: "${data.start_time} - ${data.end_time}",
                          duration: data.duration,
                          service_charge_virtual: data.service_charge_virtual,
                          service_charge_in_person: data.service_charge_in_person,
                        ),
                        transition: Transition.rightToLeft
                        );
                    
                        /*Get.toNamed(
                          BookingsRoute,
                          arguments: {
                            'service_provider_id': data.service_provider_details['userId'],
                            'avail_time': data.available_time,
                            'serviceId': data.serviceId,
                            'service_name': data.service_name,
                            'date': "${data.start_date} - ${data.end_date}",
                            'time': "${data.start_time} - ${data.end_time}",
                            'duration': data.duration!,
                            'service_charge_virtual': data.service_charge_virtual!,
                            'service_charge_in_person': data.service_charge_in_person!,
                          },
                          transition: Transition.rightToLeft
                        );*/      
                      },
                      color: index.isEven ? AppColor.darkMainColor : AppColor.navyBlue,
                      text: "Book Now",
                    ),
          
                  ]
                )
              );
            }
          ),
        )
        :ServiceEmptyState2(
          onPressed: () {
            showMySnackBar(
              context: context, 
              message: "no service found. please try again later", 
              backgroundColor: AppColor.redColor
            );
          },
        );
      }
    );
  }
}