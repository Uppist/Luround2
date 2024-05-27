import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services/program_service/program_service_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import 'package:luround/views/account_owner/services/widget/program/edit_service/step_tabs/step_1/new/start_date_box.dart';
import 'package:luround/views/account_owner/services/widget/program/edit_service/step_tabs/step_1/new/stop_date_box.dart';
import 'package:luround/views/account_owner/services/widget/program/edit_service/step_tabs/step_1/textfields/description_textfield_edit.dart';
import 'package:luround/views/account_owner/services/widget/program/edit_service/step_tabs/step_1/textfields/edit_normal_textfield.dart';









class Step1PageProgramServiceEdit extends StatefulWidget {
  const Step1PageProgramServiceEdit({super.key, required this.onNext, required this.serviceId, required this.service_name, required this.description, required this.links, required this.service_charge_in_person, required this.service_charge_virtual,});
  final VoidCallback onNext;
  final String serviceId;
  final String service_name;
  final String description;
  final List<dynamic> links;
  final String service_charge_in_person;
  final String service_charge_virtual;

  @override
  State<Step1PageProgramServiceEdit> createState() => _Step1PageProgramServiceEditState();
}

class _Step1PageProgramServiceEditState extends State<Step1PageProgramServiceEdit> {
  
  var controller = Get.put(ProgramServiceController());

  @override
  void initState() {
    // TODO: implement initState
    controller.serviceNameControllerEdit.addListener(() {
      /*setState(() {
        controller.i.value = controller.serviceNameControllerEdit.text.isNotEmpty;
      });*/
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Program name",
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
            fontSize: 15.sp,
            fontWeight: FontWeight.w500
          ),
        ),
        SizedBox(height: 10.h),
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
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          initialValue: widget.description,
        ),
        SizedBox(height: 20.h,),
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

      
        /*Text(
          "Service recurrence",
          style: GoogleFonts.inter(
            color: AppColor.blackColor,
            fontSize: 15.sp,
            fontWeight: FontWeight.w500
          ),
        ),
        //SizedBox(height: 20.h),
        ProgramServiceRecurrenceEdit(),*/
        
        SizedBox(height: 40.h),
        Text(
          "Start date",
          style: GoogleFonts.inter(
            color: AppColor.blackColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500
          ),
        ),
        SizedBox(height: 30.h),
        StartDateBoxProgramEdit(),

        SizedBox(height: 30.h),
        Text(
          "End date",
          style: GoogleFonts.inter(
            color: AppColor.blackColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500
          ),
        ),
        SizedBox(height: 30.h),
        StopDateBoxProgramEdit(),


        SizedBox(height: MediaQuery.of(context).size.height * 0.10),

        RebrandedReusableButton(
          textColor: AppColor.bgColor,
          color: AppColor.mainColor, 
          text: "Next", 
          onPressed: widget.onNext
        ),
  

      ]
    );
  }
}