import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/my_snackbar.dart';








class SyncFusionCalendar extends StatelessWidget {
  const SyncFusionCalendar({super.key});
  
  //final controller = Get.put(MoreController());

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
                        "Sync your calendar",
                        style: GoogleFonts.inter(
                          color: AppColor.blackColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                      //SYNCFUSION CALENDAR
                      SfCalendar(
                        cellEndPadding: 5,
                        view: CalendarView.month,
                        todayHighlightColor: AppColor.navyBlue,
                        backgroundColor: AppColor.bgColor,
                        cellBorderColor: AppColor.mainColor,
                        showNavigationArrow: true,
                        dataSource: MeetingDataSource(_getDataSource()),
                        monthViewSettings: const MonthViewSettings(
                          appointmentDisplayMode: MonthAppointmentDisplayMode.appointment
                        ),
                        initialDisplayDate: DateTime.now(),
                        selectionDecoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(color: AppColor.mainColor, width: 2),
                          borderRadius: BorderRadius.all(Radius.circular(4.r)),
                         shape: BoxShape.rectangle,
                        ),
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


//test data source
List<Meeting> _getDataSource() {
  final List<Meeting> meetings = <Meeting>[];
  final DateTime today = DateTime.now();
  final DateTime startTime = DateTime(today.year, today.month, today.day, 9, 0, 0);
  final DateTime endTime = startTime.add(const Duration(hours: 2));
    meetings.add(
      Meeting(
        'Conference', 
        startTime, 
        endTime,
        AppColor.mainColor, 
        false
      )
    );
    return meetings;
}


class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}