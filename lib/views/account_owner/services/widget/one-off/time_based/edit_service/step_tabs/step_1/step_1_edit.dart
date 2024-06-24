import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services/one-off/oneoff_service_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import 'package:luround/views/account_owner/services/widget/one-off/time_based/edit_service/step_tabs/step_1/textfields/description_textfield_edit.dart';
import 'package:luround/views/account_owner/services/widget/one-off/time_based/edit_service/step_tabs/step_1/textfields/edit_normal_textfield.dart';










class Step1PageEdit extends StatefulWidget {
  const Step1PageEdit({super.key, required this.onNext, required this.serviceId, required this.service_name, required this.description, required this.service_charge_in_person, required this.service_charge_virtual,});
  final VoidCallback onNext;
  final String serviceId;
  final String service_name;
  final String description;
  final String service_charge_in_person;
  final String service_charge_virtual;

  @override
  State<Step1PageEdit> createState() => _Step1PageEditState();
}

class _Step1PageEditState extends State<Step1PageEdit> {
  
  var controller = Get.put(ServicesController());

  @override
  void initState() {
    // TODO: implement initState
    /*controller.serviceNameControllerEdit.addListener(() {
      setState(() {
        controller.isServiceNameTappedEdit.value = controller.serviceNameControllerEdit.text.isNotEmpty;
      });
    });*/
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Service name",
          style: GoogleFonts.inter(
            color: AppColor.blackColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500
          ),
        ),
        SizedBox(height: 20.h),
        ReusableEditTextField(  
          onChanged: (val) {
            setState(() {
              controller.serviceNameControllerEdit.text = val;
            });
          },
          hintText: "Service name",
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          initialValue: widget.service_name,
        ),
        SizedBox(height: 40.h),
        Text(
          "Description",
          style: GoogleFonts.inter(
            color: AppColor.blackColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500
          ),
        ),
        SizedBox(height: 20.h),
        DescriptionTextFieldEdit(  
          onChanged: (val) {
            setState(() {
              // Check if character count exceeds the maximum
              if (val.length > controller.maxLengthEdit) {
                // Remove extra characters        
                controller.descriptionControllerEdit.text = val.substring(0, controller.maxLengthEdit);
                debugPrint("you have reached max length");
              } 
              controller.descriptionControllerEdit.text = val;
            });
          },
          hintText: "Write a brief descriptive summary of the service you provide.",
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.newline,
          initialValue: widget.description,
        ),
        SizedBox(height: 10.h,),
        //max length for message textfield
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "${controller.descriptionControllerEdit.text.length}/${controller.maxLengthEdit}",
              style: GoogleFonts.inter(
                color: AppColor.textGreyColor,
                fontSize: 15.sp,
                fontWeight: FontWeight.w500
              ),
            ),
          ],
        ),

        SizedBox(height: MediaQuery.of(context).size.height * 0.39),
        
        RebrandedReusableButton(
          textColor:AppColor.bgColor,
          color: AppColor.mainColor, 
          text: "Next", 
          onPressed: widget.onNext,
        ),
        //SizedBox(height: 20.h,),

      ]
    );
  }
}