import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services/regular_service/regular_service_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';






class TogglePriceContainer extends StatefulWidget {
  TogglePriceContainer({super.key, required this.index,});
  final int index;

  @override
  State<TogglePriceContainer> createState() => _TogglePriceContainerState();
}

class _TogglePriceContainerState extends State<TogglePriceContainer> {
  var controller = Get.put(ServicesController());

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(),
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.h),
        alignment: Alignment.center,
        height: 50.h,
        width: 220.w, //250,
        decoration: BoxDecoration(
          color: AppColor.bgColor,
          borderRadius: BorderRadius.all(Radius.circular(50.r)),
          border: Border.all(
            color: AppColor.navyBlue,
            width: 2.0,
          )
        ),
        child: Obx(
          () {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    controller.handleTabTap(widget.index);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    //height: 70,
                    width: 100.w,
                    //padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: controller.isVirtual.value &&  controller.selectedIndex == widget.index ? AppColor.navyBlue : AppColor.bgColor,
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    child: Text(
                      'Virtual',
                      style: GoogleFonts.inter(
                        color: controller.isVirtual.value &&  controller.selectedIndex == widget.index ? AppColor.bgColor : AppColor.textGreyColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    controller.handleTabTap(widget.index);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    //height: 70,
                    width: 100.w,
                    //padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: controller.isVirtual.value &&  controller.selectedIndex == widget.index ? AppColor.bgColor : AppColor.navyBlue, //.redColor,
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    child: Text(
                      'In-person',
                      style: GoogleFonts.inter(
                        color: controller.isVirtual.value &&  controller.selectedIndex == widget.index ? AppColor.textGreyColor : AppColor.bgColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                ),
              ]
            );
          }
        )
    );
  }
}