import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/converters.dart';





class RowWidget extends StatefulWidget {
  final VoidCallback onDelete;
  final ValueChanged<String> onDateSelected;
  final ValueChanged<String> onStartTimeSelected;
  final ValueChanged<String> onStopTimeSelected;

  const RowWidget({
    required Key key,
    required this.onDelete,
    required this.onDateSelected,
    required this.onStartTimeSelected,
    required this.onStopTimeSelected,
  }) : super(key: key);

  @override
  _RowWidgetState createState() => _RowWidgetState();
}

class _RowWidgetState extends State<RowWidget> {
  String? selectedDate;
  String? selectedStartTime;
  String? selectedStopTime;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8.0.r),
      child: Row(
        children: [
          //First container for date picker
          Expanded(
            child: GestureDetector(
              onTap: () async {
                DateTime? date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (date != null) {
                  String formattedDate = formatDate(date); //DateFormat('d MMMM, yyyy').format(date);
                  setState(() {
                    selectedDate = formattedDate;
                  });
                  widget.onDateSelected(formattedDate);
                }
              },
              child: Container(
                height: 50.h,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColor.textGreyColor, width: 1.0),
                  borderRadius: BorderRadius.circular(10.r),
                  color: AppColor.bgColor
                ),
                child: Center(
                  child: Text(
                    selectedDate ?? '',
                    style: GoogleFonts.inter(
                      color: AppColor.textGreyColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 8.w),
          // Second container for start time picker
          Expanded(
            child: GestureDetector(
              onTap: () async {
                // Determine if the user prefers 24-hour format
                bool use24HourFormat = MediaQuery.of(context).alwaysUse24HourFormat;

                final TimeOfDay? time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                  builder: (BuildContext context, Widget? child) {
                    return MediaQuery(
                      data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: use24HourFormat),
                      child: child!,
                    );
                  },
                );
              
                if (time != null) {
                  String formattedTime = time.format(context);
                  setState(() {
                    selectedStartTime = formattedTime;
                  });
                  widget.onStartTimeSelected(formattedTime);
                }
              },
              child: Container(
                height: 50.h,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColor.textGreyColor, width: 1.0),
                  borderRadius: BorderRadius.circular(10.r),
                  color: AppColor.bgColor
                ),
                child: Center(
                  child: Text(
                    selectedStartTime ?? '',
                    style: GoogleFonts.inter(
                      color: AppColor.textGreyColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400
                    ),
                  ),
                ),
              ),
            ),
          ),

          SizedBox(width: 8.w),

          // Third container for stop time picker
          Expanded(
            child: GestureDetector(
              onTap: () async {
                TimeOfDay? time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (time != null) {
                  String formattedTime = time.format(context);
                  setState(() {
                    selectedStopTime = formattedTime;
                  });
                  widget.onStopTimeSelected(formattedTime);
                }
              },
              child: Container(
                height: 50.h,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColor.textGreyColor, width: 1.0),
                  borderRadius: BorderRadius.circular(10.r),
                  color: AppColor.bgColor
                ),
                child: Center(
                  child: Text(
                    selectedStopTime ?? '',
                    style: GoogleFonts.inter(
                      color: AppColor.textGreyColor,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 8),
          // Delete icon to remove the row
          InkWell(
            onTap: widget.onDelete,
            child: Icon(
              CupertinoIcons.delete, 
              size: 24.r,
              color: AppColor.textGreyColor,
            ),
          ),
        ],
      ),
    );
  }
}