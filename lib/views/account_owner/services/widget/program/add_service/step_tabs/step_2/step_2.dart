import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services/program_service/program_service_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import 'package:luround/views/account_owner/services/widget/program/add_service/step_tabs/step_2/dropdows/recurrence_dropdown.dart';
import 'package:luround/views/account_owner/services/widget/program/add_service/step_tabs/step_2/dropdows/timeline_dropdown.dart';
import 'package:luround/views/account_owner/services/widget/program/add_service/step_tabs/step_3/new/date_range_bottomsheet.dart';
import 'package:luround/views/account_owner/services/widget/program/add_service/step_tabs/step_2/selectors/time_range_s2.dart';
import 'package:luround/views/account_owner/services/widget/program/add_service/step_tabs/step_3/new/custom_checkbox.dart';











class Step2PageProgramService  extends StatefulWidget {
  const Step2PageProgramService({super.key, required this.onNext});
  final VoidCallback onNext;

  @override
  State<Step2PageProgramService> createState() => _Step2PageProgramServiceState();
}

class _Step2PageProgramServiceState extends State<Step2PageProgramService > {
  
  var controller = Get.put(ProgramServiceController());
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(
          "Select days",
          style: GoogleFonts.inter(
            color: AppColor.blackColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500
          ),
        ),
        SizedBox(height: 30.h),

        ListView.separated(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) => SizedBox(height: 10.h,),
          itemCount: controller.daysOfTheWeekCheckBox.length,
          itemBuilder: (context, index) {

            return CustomCheckBox(
              checkbox: Checkbox.adaptive(
                checkColor: AppColor.bgColor,
                activeColor: AppColor.mainColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.r)
                ),
                value: controller.daysOfTheWeekCheckBox[index]["isChecked"],
                onChanged: (value) {   
                  setState(() {
                    controller.isCheckBoxActive.value = true;
                    controller.toggleCheckbox(index, value);
                    print("selectedDays: ${controller.selectedDays}");
                  });     
                  //print("$index, ${controller.daysOfTheWeekCheckBoxEdit[index]["day"]}");
                },
              ),
              title: Text(
                controller.daysOfTheWeekCheckBox[index]["day"],
                style: GoogleFonts.inter(
                  color: AppColor.blackColor,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500
                ),
              )
            );
                 
          }, 
        ),
        
        SizedBox(height: 100.h,), //280.h
    
        RebrandedReusableButton(
          textColor: AppColor.bgColor,
          color: AppColor.mainColor, 
          text: "Next", 
          onPressed: widget.onNext,
        ),
        SizedBox(height: 10.h,),
    
    
      ]
    );
  }
}


  