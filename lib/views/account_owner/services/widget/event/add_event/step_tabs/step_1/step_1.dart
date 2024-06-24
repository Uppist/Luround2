import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services/event/event_service_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import 'package:luround/views/account_owner/services/widget/one-off/time_based/add_service/step_tabs/step_1/textfields/description_textfield.dart';
import '../../../../../../../../../utils/components/reusable_custom_textfield.dart';










class Step1Page extends StatefulWidget {
  const Step1Page({super.key, required this.onNext});
  final VoidCallback onNext;

  @override
  State<Step1Page> createState() => _Step1PageState();
}

class _Step1PageState extends State<Step1Page> {


  final controller = Get.put(EventsController());

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
          "Event name",
          style: GoogleFonts.inter(
            color: AppColor.blackColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500
          ),
        ),
        SizedBox(height: 20.h),
        ReusableTextField(  
          onChanged: (val) {},
          hintText: "Ex: Grow your business masterclass",
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          textController: controller.serviceNameController
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
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.newline,
          textController: controller.descriptionController,
        ),
        SizedBox(height: 10.h,),
        //max length for message textfield
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "${controller.descriptionController.text.length}/${controller.maxLength}",
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
          textColor: controller.isServiceNameTapped.value ? AppColor.bgColor : AppColor.darkGreyColor,
          color: controller.isServiceNameTapped.value ? AppColor.mainColor : AppColor.lightPurple, 
          text: "Next", 
          onPressed: controller.isServiceNameTapped.value ? 
          widget.onNext
          : () {
            print('nothing');
          },
        ),
        //SizedBox(height: 20.h,),


      ]
    );
  }
}