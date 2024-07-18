import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services/one-off/oneoff_service_controller.dart';
import 'package:luround/main.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import 'package:luround/views/account_owner/services/widget/one-off/project_based/add_service/step_tabs/step_1/textfields/amount_textfield.dart';
import 'package:luround/views/account_owner/services/widget/one-off/time_based/add_service/step_tabs/step_1/textfields/description_textfield.dart';
import '../../../../../../../../../utils/components/reusable_custom_textfield.dart';










class Step1PageOPB extends StatefulWidget {
  const Step1PageOPB({super.key, required this.onNext});
  final VoidCallback onNext;

  @override
  State<Step1PageOPB> createState() => _Step1PageOPBState();
}

class _Step1PageOPBState extends State<Step1PageOPB> {


  final controller = Get.put(ServicesController());

  @override
  void initState() {
    // TODO: implement initState
    controller.serviceNameController.addListener(() {
      if(mounted) {
        setState(() {
          controller.isServiceNameTapped.value = controller.serviceNameController.text.isNotEmpty;
        });
      }
    });
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
        ReusableTextField(  
          onChanged: (val) {},
          hintText: "Ex: CV Writing",
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
              controller.descriptionController.text = val;
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

        SizedBox(height: 40.h),

        Text(
          "Pricing",
          style: GoogleFonts.inter(
            color: AppColor.blackColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500
          ),
        ),
        SizedBox(height: 20.h),

        AmountTextField(
          onChanged: (val) {
            controller.priceController.text = val;
          },
          hintText: "${currency(context).currencySymbol} 00.00",
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.done,
          textController: controller.priceController,

        ),
        
        SizedBox(height: MediaQuery.of(context).size.height * 0.21),
        
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