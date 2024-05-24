import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services/regular_service/regular_service_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';








class Step2PageEdit extends GetView<ServicesController> {
  Step2PageEdit({super.key, required this.onNext});
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Service model",
          style: GoogleFonts.inter(
            color: AppColor.blackColor,
            fontSize: 15.sp,
            fontWeight: FontWeight.w500
          ),
        ),

  
        
        SizedBox(height: MediaQuery.of(context).size.height * 0.43),
    
        Obx(
          () {
            return RebrandedReusableButton(
              textColor: AppColor.bgColor,
              color: AppColor.mainColor, 
              text: "Next", 
              onPressed: //controller.selectServiceModelEdit.value.isNotEmpty ? 
              onNext
              /*: () {
                print('nothing');
              },*/
            );
          }
        ),
        SizedBox(height: 10.h,),
    
    
      ]
    );
  }
}


  