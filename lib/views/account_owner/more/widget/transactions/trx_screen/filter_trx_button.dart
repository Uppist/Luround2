import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/more/transactions_controller.dart';
import 'package:luround/services/account_owner/more/transactions/withdrawal_service.dart';
import 'package:luround/utils/colors/app_theme.dart';







class FilterTrxButton extends StatelessWidget {
  FilterTrxButton({super.key,});

  var controller = Get.put(TransactionsController());
  var service = Get.put(WithdrawalService());

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
                borderRadius: BorderRadius.circular(5.r),
                border: Border.all(
                  color: AppColor.greyColor
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
                      if(item == 'All time    ') {
                        service.filterTrxByPastDate();
                      }
                      else if(item == 'Today    ') {
                        service.filterListByToday();
                      }
                      else if(item == 'Yesterday    ') {
                        service.filterListByYesterday();
                      }
                      else if (item == 'Last 7 days    ') {
                        service.filterListByLastSevenDays();
                      }
                      else if(item == "Last 30 days    ") {
                        service.filterListByLastThirtyDays();
                      }
                      else {
                        print("nothing else");
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