import 'package:luround/utils/components/loader.dart';
import 'package:luround/views/account_owner/more/widget/calendar/fetch_data_source_service.dart';
import 'package:luround/views/account_owner/more/widget/calendar/meeting_data_source.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';







class SyncFusionCalendar extends StatelessWidget {
  SyncFusionCalendar({super.key});
  
  final controller = Get.put(CalendarService());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 10.h,),
            /////////////
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 7.w),
              child: Row(
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
                  SizedBox(width: 3.w,),
                  Text(
                    "Calendar",
                    style: GoogleFonts.inter(
                      color: AppColor.blackColor,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10.h),
            Container(
              color: AppColor.greyColor,
              width: double.infinity,
              height: 7.h,
            ),        
            SizedBox(height: 10.h,),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.h),
                      //1
                      Text(
                        "Track your bookings with ease on your calendar",
                        style: GoogleFonts.inter(
                          color: AppColor.darkGreyColor, //semiDarkGreyColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      
                      SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                      
                      //SYNCFUSION CALENDAR
                      FutureBuilder(
                        future: controller.getDataFromWeb(),
                        builder: (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Loader2();
                          }

                          if (snapshot.hasError) {
                            print(snapshot.error);
                            return Text(
                              "failed to fetch calendar",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                color: AppColor.darkGreyColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500
                              ),
                            );
                          }
                
                          if (!snapshot.hasData) {
                            print("sn-trace: ${snapshot.stackTrace}");
                            print("sn-error: ${snapshot.error}");
                            return Text(
                              "no data found",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                color: AppColor.darkGreyColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500
                              ),
                            );
                          }
                     
                          if (snapshot.hasData) {
                        
                            return SizedBox(
                              height: MediaQuery.of(context).size.height * 0.70,
                              child: SfCalendar(
                                cellEndPadding: 5,
                                cellBorderColor: Colors.transparent,
                                todayHighlightColor: AppColor.navyBlue,
                                backgroundColor: AppColor.bgColor,
                                view: CalendarView.month, //.month .timelineMonth
                                dataSource: MeetingDataSource(snapshot.data),
                                showNavigationArrow: true,
                                initialDisplayDate: DateTime.now(),
                                initialSelectedDate: DateTime.now(),
                                //
                                /*monthViewSettings: const MonthViewSettings(
                                  appointmentDisplayMode: MonthAppointmentDisplayMode.appointment
                                ),*/
                                selectionDecoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border.all(color: AppColor.mainColor, width: 2),
                                  borderRadius: BorderRadius.all(Radius.circular(5.r)),
                                  shape: BoxShape.rectangle,
                                ),
                                //onViewChanged: (viewChangedDetails) {},
                                onTap: (calendarTapDetails) {
                                  controller.setDate(calendarTapDetails.date!);
                                  controller.showAppointmentDetailBottomsheet(context: context);
                                },
                              
                              ),
                            );
                          } 
          
                          return Text(
                            "error: ${snapshot.error}",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              color: AppColor.darkGreyColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500
                            ),
                          );
  
                        },
                      ),
                        
                    ],
                  ),
                ),
              ),
            ),            
          ]
        ),
      )    
    );
  }
}





