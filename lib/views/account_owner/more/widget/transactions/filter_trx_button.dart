import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:luround/controllers/account_owner/transactions_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';







class FilterTrxButton extends StatelessWidget {
  FilterTrxButton({super.key,});

  var controller = Get.put(TransactionsController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 50,
              width: 150,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                color: AppColor.bgColor,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: AppColor.textGreyColor
                )
              ),
              child: DropdownButton<String>(
                elevation: 0,
                dropdownColor: AppColor.bgColor,
                underline: const SizedBox(),
                borderRadius: BorderRadius.circular(5),
                iconEnabledColor: AppColor.blackColor,
                icon: Icon(CupertinoIcons.chevron_down),
                iconSize: 20,
                value: controller.selectedValue.value,
                onChanged: (newValue) {
                  // When the user selects an option, update the selectedValue
                  controller.filterList(newValue);
                },
                items: controller.items.map((item) {
                  return DropdownMenuItem(
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