import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services/program_service/program_service_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import 'package:luround/utils/components/reusable_custom_textfield.dart';
import 'package:luround/views/account_owner/services/widget/one-off/add_service/step_tabs/step_1/textfields/description_textfield.dart';
import 'package:luround/views/account_owner/services/widget/program/add_service/step_tabs/step_1/new/start_date_box.dart';
import 'package:luround/views/account_owner/services/widget/program/add_service/step_tabs/step_1/new/stop_date_box.dart';










class Step1PageProgramService extends StatefulWidget {
  const Step1PageProgramService({super.key, required this.onNext});
  final VoidCallback onNext;

  @override
  State<Step1PageProgramService> createState() => _Step1PageProgramServiceState();
}

class _Step1PageProgramServiceState extends State<Step1PageProgramService> {


  var controller = Get.put(ProgramServiceController());

  @override
  void initState() {
    // TODO: implement initState
    controller.serviceNameController.addListener(() {
      setState(() {
        controller.isServiceNameTapped.value = controller.serviceNameController.text.isNotEmpty;
      });
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
        ReusableTextField(  
          onChanged: (val) {},
          hintText: "Service name",
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          textController: controller.serviceNameController
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
        DescriptionTextField(  
          onChanged: (val) {
            //controller.handleTextChanged(val);
            // Check if character count exceeds the maximum
            setState(() {
              if (val.length > controller.maxLength) {
                //Remove extra characters      
                controller.descriptionController.text = val.substring(0, controller.maxLength);
                debugPrint("you have reached max length");
              } 
            });
            
          },
          hintText: "Write a brief descriptive summary of the service you provide.",
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          textController: controller.descriptionController,
        ),
        SizedBox(height: 20.h,),
        //max length for message textfield
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "${controller.descriptionController.text.length}/${controller.maxLength}",
              style: GoogleFonts.inter(
                color: AppColor.textGreyColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500
              ),
            ),
          ],
        ),
        
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
        StartDateBoxProgram(),

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
        StopDateBoxProgram(),


        SizedBox(height: MediaQuery.of(context).size.height * 0.10),
        RebrandedReusableButton(
          textColor: controller.isServiceNameTapped.value ? AppColor.bgColor : AppColor.darkGreyColor,
          color: controller.isServiceNameTapped.value ? AppColor.mainColor : AppColor.lightPurple, 
          text: "Next", 
          onPressed: controller.isServiceNameTapped.value ? 
          widget.onNext
          : () {
            print('nothing');
          },
        ),

      ]
    );
  }
}