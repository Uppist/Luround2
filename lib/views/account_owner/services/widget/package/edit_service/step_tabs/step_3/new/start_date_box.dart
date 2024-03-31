import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services/package_service/package_service_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/views/account_owner/services/widget/package/edit_service/step_tabs/step_2/selectors/date_range_bottomsheet_edit.dart';






class StartDateBoxPackageEdit extends StatelessWidget {
  StartDateBoxPackageEdit({super.key});

  final controller = Get.put(PackageServiceController());

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
      child: Container(
        alignment: Alignment.center,
        height: 45.h,
        width: 150.w,
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
                      fontWeight: FontWeight.w400
                    )
                  )
                );
              }
            ),
            //SizedBox(width: 5.w,),
            Icon(
              CupertinoIcons.calendar,
              size: 24.r,
              color: AppColor.textGreyColor,
            )
          ],
        )
      ),
    );
  }
}