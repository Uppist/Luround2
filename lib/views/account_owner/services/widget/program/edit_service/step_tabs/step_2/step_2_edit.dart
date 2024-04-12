import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services/program_service/program_service_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import 'package:luround/views/account_owner/services/widget/program/edit_service/step_tabs/step_3/new/custom_checkbox_edit.dart';











class Step2PageProgramServiceEdit  extends StatefulWidget {
  const Step2PageProgramServiceEdit({super.key, required this.onNext});
  final VoidCallback onNext;

  @override
  State<Step2PageProgramServiceEdit> createState() => _Step2PageProgramServiceEditState();
}

class _Step2PageProgramServiceEditState extends State<Step2PageProgramServiceEdit> {
  
  final controller = Get.put(ProgramServiceController());
  
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
            fontWeight: FontWeight.w400
          ),
        ),
        SizedBox(height: 30.h),

        ListView.separated(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) => SizedBox(height: 10.h,),
          itemCount: controller.daysOfTheWeekCheckBoxEdit.length,
          itemBuilder: (context, index) {

            return CustomCheckBox(
              checkbox: Checkbox.adaptive(
                checkColor: AppColor.bgColor,
                activeColor: AppColor.mainColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.r)
                ),
                value: controller.daysOfTheWeekCheckBoxEdit[index]["isChecked"],
                onChanged: (value) {   
                  setState(() {
                    controller.isCheckBoxActiveEdit.value = true;
                    controller.toggleCheckboxEdit(index, value);
                    print("selectedDays: ${controller.selectedDaysEdit}");
                  });     
                },
              ),
              title: Text(
                controller.daysOfTheWeekCheckBoxEdit[index]["day"],
                style: GoogleFonts.inter(
                  color: AppColor.blackColor,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500
                ),
              )
            ); 
          }, 
        ),
        
        SizedBox(height: MediaQuery.of(context).size.height * 0.18),
    
        RebrandedReusableButton(
          textColor: AppColor.bgColor,
          color: AppColor.mainColor, 
          text: "Next", 
          onPressed: widget.onNext,
        ),
    
    
      ]
    );
  }
}


  