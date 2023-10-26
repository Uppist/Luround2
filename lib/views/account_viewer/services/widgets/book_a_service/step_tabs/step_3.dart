import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_viewer/services_controller.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import '../../../../../../utils/colors/app_theme.dart';








class Step3Screen extends StatefulWidget {
  Step3Screen({super.key,required this.onTime, required this.onSubmit});
  final VoidCallback onTime;
  final VoidCallback onSubmit;

  @override
  State<Step3Screen> createState() => _Step3ScreenState();
}

class _Step3ScreenState extends State<Step3Screen> {

  var controller = Get.put(AccViewerServicesController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Select time",
            style: GoogleFonts.poppins(
              color: AppColor.blackColor,
              fontSize: 15,
              fontWeight: FontWeight.w500
            ),
          ),
          SizedBox(height: 20,),
          //time gridview        
          //
          SizedBox(height: 80,),
          RebrandedReusableButton(
            textColor: controller.isButtonEnabled.value ? AppColor.bgColor : AppColor.darkGreyColor,
            color: controller.isButtonEnabled.value ? AppColor.mainColor : AppColor.lightPurple, 
            text: "Next", 
            onPressed: controller.isButtonEnabled.value ? 
            widget.onSubmit
            : () {
              print('nothing');
            },
          ),
          SizedBox(height: 20,),
        ],
      ),
    );
  }
}