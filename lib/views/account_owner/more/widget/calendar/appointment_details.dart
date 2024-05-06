import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/views/account_owner/more/widget/calendar/fetch_data_source_service.dart';
import 'package:luround/views/account_owner/more/widget/calendar/meeting_data_source.dart';
import 'package:luround/views/account_owner/more/widget/calendar/meeting_model.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';





class AppointmentDetailsPage extends StatelessWidget {
  AppointmentDetailsPage({super.key});

  final controller = Get.put(CalendarService());

  @override
  Widget build(BuildContext context) {
    if(controller.eventsOfSelectedDate.isNotEmpty) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.50,
        child: SfCalendar(
          cellEndPadding: 5,
          //
          cellBorderColor: AppColor.darkGreyColor.withOpacity(0.2), //Colors.transparent,
          backgroundColor: AppColor.bgColor,
          view: CalendarView.timelineDay, //.timelineMonth,
          dataSource: MeetingDataSource(controller.eventsGetter),
          headerHeight: 0,
          /*monthViewSettings: const MonthViewSettings(
            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment
          ),*/
          //
          selectionDecoration: BoxDecoration(
            color: Colors.transparent
          ),
          initialDisplayDate: controller.selectedDate,
          appointmentBuilder: (context, calendarAppointmentDetails) {
            
            //quick hack around this 🧡
            final Meeting events = calendarAppointmentDetails.appointments.first;
        
            return Container(
              alignment: Alignment.center,
              height: calendarAppointmentDetails.bounds.height,
              width: calendarAppointmentDetails.bounds.width,
              //padding: EdgeInsets.symmetric(horizontal: 5.w),
              decoration: BoxDecoration(
                color: AppColor.mainColor,
                borderRadius: BorderRadius.circular(10.r)
              ),
              child: Text(
                events.clientName, //"${events['title']}" //"events['title']"
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  color: AppColor.bgColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500
                ),
              ),
            );
          },
          onTap: (calendarTapDetails) {
            //if(calendarTapDetails.appointments == null) return;
            //final events = calendarTapDetails.appointments!.first;
            //Get.to(() => EventViewPage(event: event));
          },
                                                          
        ),
      );
    }
    else {
      return Center(
        child: Text(
          "no event found",
          style: GoogleFonts.inter(
            color: AppColor.darkGreyColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500
          ),
        ),
      );
    }
  }
}