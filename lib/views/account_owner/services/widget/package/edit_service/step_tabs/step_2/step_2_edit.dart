import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services/package_service/package_service_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import 'package:luround/views/account_owner/services/widget/package/edit_service/step_tabs/step_3/new/custom_checkbox_edit.dart';












class Step2PagePackageServiceEdit  extends StatefulWidget {
  const Step2PagePackageServiceEdit({super.key, required this.onNext});
  final VoidCallback onNext;

  @override
  State<Step2PagePackageServiceEdit> createState() => _Step2PagePackageServiceEditState();
}

class _Step2PagePackageServiceEditState extends State<Step2PagePackageServiceEdit> {
  
  var controller = Get.put(PackageServiceController());
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Select days",
          style: GoogleFonts.inter(
            color: AppColor.blackColor,
            fontSize: 15.sp,
            fontWeight: FontWeight.w500
          ),
        ),
        SizedBox(height: 20.h),
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
                  //print("$index, ${controller.daysOfTheWeekCheckBoxEdit[index]["day"]}");
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
        
        SizedBox(height: MediaQuery.of(context).size.height * 0.19),
    
        RebrandedReusableButton(
          textColor: AppColor.bgColor,
          color: AppColor.mainColor, 
          text: "Next", 
          onPressed: widget.onNext,
        ),
        //SizedBox(height: 10.h,),
    
    
      ]
    );
  }
}


  