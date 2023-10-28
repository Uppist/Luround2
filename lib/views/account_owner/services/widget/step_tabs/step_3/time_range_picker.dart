import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';






class TimeRangeSelector extends StatefulWidget {
  TimeRangeSelector({super.key});

  @override
  State<TimeRangeSelector> createState() => _TimeRangeSelectorState();
}

class _TimeRangeSelectorState extends State<TimeRangeSelector> {
  
  var controller = Get.put(ServicesController());

  
  //to calendar to select date range
  Future<void> showRangeCalendar({required BuildContext context}) async{
    var results = await showCalendarDatePicker2Dialog(
      context: context,
      config: CalendarDatePicker2WithActionButtonsConfig (
        calendarType: CalendarDatePicker2Type.range,
        cancelButtonTextStyle: GoogleFonts.poppins(
          color: AppColor.mainColor
        ),
        okButtonTextStyle: GoogleFonts.poppins(
          color: AppColor.mainColor
        ),
        weekdayLabelTextStyle:  GoogleFonts.poppins(
          color: AppColor.mainColor
        ),
        selectedYearTextStyle:  GoogleFonts.poppins(
          color: AppColor.mainColor
        ),
        selectedRangeDayTextStyle:  GoogleFonts.poppins(
          color: AppColor.bgColor
        ),
        selectedRangeHighlightColor: AppColor.mainColor.withOpacity(0.2),
        selectedDayTextStyle:  GoogleFonts.poppins(
          color: AppColor.bgColor
        ),
        selectedDayHighlightColor: AppColor.mainColor,
        //calendarViewMode: DatePickerMode.day
      ),
      dialogSize: const Size(325, 400),
      value: controller.dates,
      borderRadius: BorderRadius.circular(15),
    );
    //set the empty list to equate the result
    setState(() {
      controller.dates = results!;
    });
    debugPrint("date range: ${controller.dates}");
    print("start date: ${controller.startDate()}");
    print("end date: ${controller.endDate()}");
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //controller.showRangeCalendar(context: context);
        showRangeCalendar(context: context);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          color: AppColor.bgColor,
          width: double.infinity,
          //onTap: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //from container
              Container(
                alignment: Alignment.center,
                height: 40,
                //width: 80,
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColor.bgColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: AppColor.textGreyColor,
                    width: 1.0, //2
                  )
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      controller.startDate(),
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: AppColor.textGreyColor,
                          fontSize: 16,
                          //fontWeight: FontWeight.w500
                        )
                      )
                    ),
                    SizedBox(width: 20,),
                    SvgPicture.asset("assets/svg/calendar_icon.svg")
                  ],
                ),
              ),
    
              Text(
                "-",
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    color: AppColor.textGreyColor,
                    fontSize: 16,
                    //fontWeight: FontWeight.w500
                  )
                )
              ),
    
              //to container
              Container(
                alignment: Alignment.center,
                height: 40,
                //width: 80,
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                decoration: BoxDecoration(
                  color: AppColor.bgColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: AppColor.textGreyColor,
                    width: 1.0, //2
                  )
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      controller.endDate(),
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: AppColor.textGreyColor,
                          fontSize: 16,
                          //fontWeight: FontWeight.w500
                        )
                      )
                    ),
                    SizedBox(width: 20,),
                    SvgPicture.asset("assets/svg/calendar_icon.svg")
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}