import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/financials_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';








class SelectClientWidget extends StatelessWidget {
  SelectClientWidget({super.key});

  var controller = Get.put(FinancialsController());

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {},
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Select a client",
                style: GoogleFonts.inter(
                  color: AppColor.textGreyColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500
                ),
              ),
              Icon(
                CupertinoIcons.chevron_down,
                size: 20,
                color: AppColor.blackColor,
              )
            ],
          ),
        ),
        SizedBox(height: 3,),
        Divider(color: AppColor.textGreyColor, thickness: 0.5,)
      ],
    );
  }
}