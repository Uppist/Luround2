import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import 'package:luround/views/account_owner/services/widget/description_textfield.dart';









class Step2Page extends StatefulWidget {
  Step2Page({super.key, required this.onNext});
  final VoidCallback onNext;

  @override
  State<Step2Page> createState() => _Step2PageState();
}

class _Step2PageState extends State<Step2Page> {
  var controller = Get.put(ServicesController());

  @override
  void initState() {
    // TODO: implement initState
    controller.virtualController.addListener(() {
      setState(() {
        controller.ispriceButtonEnabled.value = controller.virtualController.text.isNotEmpty;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.formKey2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Service duration*",
            style: GoogleFonts.poppins(
              color: AppColor.blackColor,
              fontSize: 16,
              fontWeight: FontWeight.w500
            ),
          ),
          SizedBox(height: 30),
          DescriptionTextField(  
            onChanged: (val) {
              // Check if character count exceeds the maximum
              if (val.length > controller.maxLength) {
                // Remove extra characters        
                controller.descriptionController.text = val.substring(0, controller.maxLength);
                debugPrint("you have reached max length");
              } 
              setState(() {}); // Update the UI
            },
            hintText: "Write a brief descriptive summary of the service you provide.",
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            textController: controller.descriptionController,
          ),
          SizedBox(height: 10,),
          
          SizedBox(height: 80,),
          RebrandedReusableButton(
            textColor: controller.ispriceButtonEnabled.value ? AppColor.bgColor : AppColor.darkGreyColor,
            color: controller.ispriceButtonEnabled.value ? AppColor.mainColor : AppColor.lightPurple, 
            text: "Next", 
            onPressed: controller.ispriceButtonEnabled.value ? 
            widget.onNext
            : () {
              print('nothing');
            },
          ),
          SizedBox(height: 20,),


        ]
      )
    );
  }
}