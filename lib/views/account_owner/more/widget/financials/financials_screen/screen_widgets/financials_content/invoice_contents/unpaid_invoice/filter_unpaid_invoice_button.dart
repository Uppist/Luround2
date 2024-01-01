import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/financials/invoice/unpaid/unpaid_invoice_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/screen_widgets/financials_content/invoice_contents/unpaid_invoice/filter_by_date_bottomsheet.dart';






class FilterUnpaidInvoiceButton extends StatelessWidget {
  FilterUnpaidInvoiceButton({super.key,});

  var controller = Get.put(UnpaidInvoiceController());

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        unpaiddateBottomSheet(
          controller: controller,
          context: context,
          onCancel: () {
            Get.back();
          },
          onApply: () {
            Get.back();
          },
        );
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 50.h,
            //width: 200,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: AppColor.bgColor,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: AppColor.textGreyColor
              )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(
                  () {
                    return Text(
                      "${controller.startDate()}  -  ${controller.endDate()}",
                      style: GoogleFonts.inter(
                        color: AppColor.textGreyColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400
                      ),
                    );
                  }
                ),
                SizedBox(width: 20.w), 
                SvgPicture.asset("assets/svg/calendar_icon.svg"),
              ],
            )       
          ),
        ],
      ),
    );
    
  }
}



