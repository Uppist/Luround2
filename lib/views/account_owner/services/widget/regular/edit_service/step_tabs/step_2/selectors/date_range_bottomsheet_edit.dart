import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services/regular_service/regular_service_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';








var controller = Get.put(ServicesController());

Future<void> selectDateRangeBottomSheetEdit({required BuildContext context, required VoidCallback onCancel, required VoidCallback onApply,}) async{
  showModalBottomSheet(
    isScrollControlled: true,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 2,
    isDismissible: true,
    useSafeArea: true,
    backgroundColor: AppColor.bgColor,
    //barrierColor: Theme.of(context).colorScheme.background,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(15)
      )
    ),
    context: context, 
    builder: (context) {
      return Wrap(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 30.h),
            decoration: BoxDecoration(
              //image: DecorationImage(image: AssetImage(''),),
              color: AppColor.bgColor,
              /*borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
              ),*/
            ),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20.h,),
                CalendarDatePicker2(
                  /*config: CalendarDatePicker2Config(
                    calendarType: CalendarDatePicker2Type.range,
                  ),*/
                  config: CalendarDatePicker2Config(  
                    calendarType: CalendarDatePicker2Type.range,         
                    weekdayLabelTextStyle:  GoogleFonts.inter(
                      color: AppColor.mainColor
                    ),
                    selectedYearTextStyle:  GoogleFonts.inter(
                      color: AppColor.bgColor
                    ),
                    selectedRangeDayTextStyle:  GoogleFonts.inter(
                      color: AppColor.bgColor
                    ),
                    selectedRangeHighlightColor: AppColor.mainColor.withOpacity(0.2),
                    selectedDayTextStyle:  GoogleFonts.inter(
                      color: AppColor.bgColor
                    ),
                    selectedDayHighlightColor: AppColor.mainColor,
                    //calendarViewMode: DatePickerMode.day
                  ),
                  value: controller.datesEdit,
                  onValueChanged: (dates) {
                    controller.selectedDateEdit(dates);
                    debugPrint("${controller.datesEdit}");
                  },
                ),
                SizedBox(height: 20.h,),

                //buttons row
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: onCancel,
                        child: Container(
                          //padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8),
                          alignment: Alignment.center,
                          height: 50.h,
                          width: 150.w,
                          decoration: BoxDecoration(
                            color: AppColor.bgColor,
                            borderRadius: BorderRadius.circular(15.r),
                            border: Border.all(
                              color: AppColor.textGreyColor,
                              width: 2.0,
                            )
                          ),
                          child: Text(
                            "Cancel",
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                color: AppColor.textGreyColor,
                                fontSize: 16.sp,
                                //fontWeight: FontWeight.w500
                              )
                            )
                          ),
                        )
                      ),
                      InkWell(
                        onTap: onApply,
                        child: Container(
                          //padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                          alignment: Alignment.center,
                          height: 50.h,
                          width: 150.w,
                          decoration: BoxDecoration(
                            color: AppColor.mainColor,
                            borderRadius: BorderRadius.circular(15.r),
                            border: Border.all(
                              color: AppColor.mainColor,
                              width: 2.0,
                            )
                          ),
                          child: Text(
                            "Apply",
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                color: AppColor.bgColor,
                                fontSize: 16.sp,
                                //fontWeight: FontWeight.w500
                              )
                            )
                          ),
                        )
                      ),
                    ],
                  ),
                ),
                //
              ],
            ),
          ),
        ],
      );
    }
  );
}