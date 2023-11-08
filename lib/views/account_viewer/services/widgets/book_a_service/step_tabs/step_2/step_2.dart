import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_viewer/services_controller.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import '../../../../../../../utils/colors/app_theme.dart';








class Step2Screen extends StatefulWidget {
  Step2Screen({super.key, required this.onCancel, required this.onApply, required this.onSubmit});
  final VoidCallback onCancel;
  final VoidCallback onApply;
  final VoidCallback onSubmit;

  @override
  State<Step2Screen> createState() => _Step2ScreenState();
}

class _Step2ScreenState extends State<Step2Screen> {

  var controller = Get.put(AccViewerServicesController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Select day",
            style: GoogleFonts.inter(
              color: AppColor.blackColor,
              fontSize: 16,
              fontWeight: FontWeight.w500
            ),
          ),
          SizedBox(height: 20,),
          CalendarDatePicker2(
            /*config: CalendarDatePicker2Config(
              calendarType: CalendarDatePicker2Type.range,
            ),*/
            config: CalendarDatePicker2Config(           
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
            value: controller.dates,
            onValueChanged: (dates) {
              setState(() {
                controller.isButtonEnabled3.value = true;
              });
              controller.dates = dates;
              debugPrint("${controller.dates}");
              debugPrint("splitted date: ${controller.getDate()}");
            },
          ),
          //SizedBox(height: 20,),
          Divider(color: AppColor.textGreyColor, thickness: 0.2,),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: widget.onCancel,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  alignment: Alignment.center,
                  height: 50,
                  width: 150,
                  decoration: BoxDecoration(
                    color: AppColor.bgColor,
                    borderRadius: BorderRadius.circular(15),
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
                        fontSize: 16,
                        //fontWeight: FontWeight.w500
                      )
                    )
                  ),
                )
              ),
              InkWell(
                onTap: widget.onApply,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  alignment: Alignment.center,
                  height: 50,
                  width: 150,
                  decoration: BoxDecoration(
                    color: AppColor.mainColor,
                    borderRadius: BorderRadius.circular(15),
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
                        fontSize: 16,
                        //fontWeight: FontWeight.w500
                      )
                    )
                  ),
                )
              ),
            ],
          ),
          //
          SizedBox(height: 80,),
          RebrandedReusableButton(
            textColor: controller.isButtonEnabled3.value ? AppColor.bgColor : AppColor.darkGreyColor,
            color: controller.isButtonEnabled3.value ? AppColor.mainColor : AppColor.lightPurple, 
            text: "Next", 
            onPressed: controller.isButtonEnabled3.value ? 
            widget.onSubmit
            : () {
              print('nothing');
            },
          ),
          SizedBox(height: 20,),
        ],
      ),
    );
  }
}