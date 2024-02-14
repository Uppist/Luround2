import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/bookings/bookings_controller.dart';
import 'package:luround/services/account_owner/bookings_service/user_bookings_services.dart';
import 'package:luround/utils/colors/app_theme.dart';






class FilterContainer extends StatelessWidget {
  FilterContainer({super.key,});

  var controller = Get.put(BookingsController());
  var service = Get.put(AccOwnerBookingService());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Row(

          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 50.h,
              //width: 150,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: AppColor.bgColor,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(
                  color: Colors.grey.withOpacity(0.3)
                )
              ),
              child: DropdownButton<String>(
                style: GoogleFonts.inter(
                  color: AppColor.textGreyColor,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500
                ),
                elevation: 3,
                dropdownColor: AppColor.bgColor,
                underline: SizedBox(),
                borderRadius: BorderRadius.circular(5.r),
                iconEnabledColor: AppColor.blackColor,
                icon: Icon(CupertinoIcons.chevron_down),
                iconSize: 20,
                enableFeedback: true,
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                value: controller.selectedValue.value,
                onChanged: (newValue) { 
                  // When the user selects an option, update the selectedValue
                  controller.filterList(newValue);
                },
                items: controller.items.map((item) {
                  return DropdownMenuItem(
                    onTap: () {
                      
                      debugPrint("drop down menu tapped!!");
                      if(controller.selectedValue.value == 'All time    ') {
                        service.filterTrxByPastDate();
                      }
                      if(controller.selectedValue.value == 'Today    ') {
                        service.filterListByToday();
                      }
                      if(controller.selectedValue.value == 'Yesterday    ') {
                        service.filterListByYesterday();
                      }
                      if (controller.selectedValue.value == 'Last 7 days    ') {
                        service.filterListByLastSevenDays();
                      }
                      if(controller.selectedValue.value == "Last 30 days    ") {
                        service.filterListByLastThirtyDays();
                      }
  
                    },                    
                    value: item,
                    child: Text(
                      item,
                      style: GoogleFonts.inter(
                        color: AppColor.textGreyColor,
                        fontSize: 14.sp,
                        //fontWeight: FontWeight.w500
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        );
      }
    );
  }
}