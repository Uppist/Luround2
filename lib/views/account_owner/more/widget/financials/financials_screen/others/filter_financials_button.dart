import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/financials_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';







class FilterFinancialsButton extends StatelessWidget {
  FilterFinancialsButton({super.key,});

  var controller = Get.put(FinancialsController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 50,
              width: 200,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              decoration: BoxDecoration(
                color: AppColor.bgColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColor.textGreyColor
                )
              ),
              child: DropdownButton<String>(
                style: GoogleFonts.inter(
                  color: AppColor.textGreyColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w500
                ),
                elevation: 3,
                dropdownColor: AppColor.bgColor,
                underline: const SizedBox(),
                borderRadius: BorderRadius.circular(5),
                iconEnabledColor: AppColor.blackColor,
                icon: SvgPicture.asset("assets/svg/calendar_icon.svg"),
                //iconSize: 20,
                enableFeedback: true,
                padding: EdgeInsets.symmetric(horizontal: 10),
                value: controller.selectedValue.value,
                onChanged: (newValue) {
                  // When the user selects an option, update the selectedValue
                  controller.filterList(newValue);
                },
                items: controller.items.map((item) {
                  return DropdownMenuItem(
                    onTap: () {
                      debugPrint("drop down menu tapped!!");
                    },                    
                    value: item,
                    child: Text(item),
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