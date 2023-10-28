import 'package:from_to_time_picker/from_to_time_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';










class Step3Page extends StatefulWidget {
  Step3Page({super.key, required this.onNext});
  final VoidCallback onNext;

  @override
  State<Step3Page> createState() => _Step3PageState();
}

class _Step3PageState extends State<Step3Page> {

  var controller = Get.put(ServicesController());

  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Day and Time availability*",
          style: GoogleFonts.poppins(
            color: AppColor.blackColor,
            fontSize: 16,
            fontWeight: FontWeight.w500
          ),
        ),
        SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.circle_outlined,
              color: AppColor.mainColor,
            )
          ],
        )
      ]
    );
  }
}