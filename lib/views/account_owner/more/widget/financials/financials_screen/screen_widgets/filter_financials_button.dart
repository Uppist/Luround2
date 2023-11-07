import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/financials_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/bottom_sheets/filter_by_date_bottomsheet.dart';







class FilterFinancialsButton extends StatelessWidget {
  FilterFinancialsButton({super.key,});

  var controller = Get.put(FinancialsController());

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        dateBottomSheet(
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
            height: 50,
            //width: 200,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              color: AppColor.bgColor,
              borderRadius: BorderRadius.circular(12),
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
                        fontSize: 15,
                        fontWeight: FontWeight.normal
                      ),
                    );
                  }
                ),
                SizedBox(width: 20), 
                SvgPicture.asset("assets/svg/calendar_icon.svg"),
              ],
            )       
          ),
        ],
      ),
    );
    
  }
}



