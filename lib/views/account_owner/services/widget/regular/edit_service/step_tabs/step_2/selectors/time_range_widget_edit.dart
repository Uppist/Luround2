import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services/regular_service/regular_service_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/views/account_owner/services/widget/regular/edit_service/step_tabs/step_2/selectors/date_range_bottomsheet_edit.dart';









//DATE RANGE PICKER
class TimeRangePickerWidgetEdit extends StatefulWidget {
  TimeRangePickerWidgetEdit({super.key});

  @override
  State<TimeRangePickerWidgetEdit> createState() => _TimeRangePickerWidgetEditState();
}

class _TimeRangePickerWidgetEditState extends State<TimeRangePickerWidgetEdit> {
  
  var controller = Get.put(ServicesController());

  

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        selectDateRangeBottomSheetEdit(
          context: context, 
          onCancel: () {
            Get.back();
          }, 
          onApply: () {
            Get.back();
          }
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 50.w),
        child: Container(
          color: AppColor.bgColor,
          width: double.infinity,
          //onTap: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //from container
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  height: 40.h,
                  width: 90.w,
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                  decoration: BoxDecoration(
                    color: AppColor.bgColor,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      color: AppColor.textGreyColor,
                      width: 1.0, //2
                    )
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(
                        () {
                          return Text(
                            controller.startDateEdit(),
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                color: AppColor.textGreyColor,
                                fontSize: 14.sp,
                                //fontWeight: FontWeight.w500
                              )
                            )
                          );
                        }
                      ),
                      //SizedBox(width: 5.w,),
                      //SvgPicture.asset("assets/svg/calendar_icon.svg")
                    ],
                  ),
                ),
              ),
              SizedBox(width: 10.w,),
    
              Text(
                "-",
                style: GoogleFonts.inter(
                  textStyle: TextStyle(
                    color: AppColor.textGreyColor,
                    fontSize: 16.sp,
                    //fontWeight: FontWeight.w500
                  )
                )
              ),

              SizedBox(width: 10.w,),
              //to container
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  height: 40.h,
                  width: 90.w,
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                  decoration: BoxDecoration(
                    color: AppColor.bgColor,
                    borderRadius: BorderRadius.circular(10.r),
                    border: Border.all(
                      color: AppColor.textGreyColor,
                      width: 1.0, //2
                    )
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(
                        () {
                          return Text(
                            controller.endDateEdit(),
                            style: GoogleFonts.inter(
                              textStyle: TextStyle(
                                color: AppColor.textGreyColor,
                                fontSize: 14.sp,
                                //fontWeight: FontWeight.w500
                              )
                            )
                          );
                        }
                      ),
                      //SizedBox(width: 5.w,),
                      //SvgPicture.asset("assets/svg/calendar_icon.svg")
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}