import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import 'package:luround/views/account_owner/services/widget/step_tabs/step_2/radio_section.dart';









class Step2Page extends StatefulWidget {
  Step2Page({super.key, required this.onNext});
  final VoidCallback onNext;

  @override
  State<Step2Page> createState() => _Step2PageState();
}

class _Step2PageState extends State<Step2Page> {
  var controller = Get.put(ServicesController());

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
          InkWell(
            onTap: () async{
              var resultingDuration = await showDurationPicker(
                decoration: BoxDecoration(
                  color: AppColor.bgColor,
                  borderRadius: BorderRadius.circular(20)
                ),
                context: context,
                initialTime: controller.duration,
              );
              setState(() {
                controller.duration = resultingDuration!;
                controller.ispriceButtonEnabled.value = true;
              });
              //debugPrint("duartion: ${resultingDuration}");
              debugPrint("duration: ${controller.duration}");              
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              alignment: Alignment.centerLeft,
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColor.bgColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: AppColor.textGreyColor,
                  width: 1.0, //2
                )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${controller.duration}".substring(0, 7),
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: AppColor.textGreyColor,
                        fontSize: 16,
                        //fontWeight: FontWeight.w500
                      )
                    )
                  ),
                  Icon(
                    CupertinoIcons.time,
                    color: AppColor.textGreyColor,
                  ),
                ],
              ),
            )
          ),
          SizedBox(height: 30,),
          Text(
            "This service can be scheduled...",
            style: GoogleFonts.poppins(
              color: AppColor.blackColor,
              fontSize: 14,
              fontWeight: FontWeight.w500
            ),
          ),

          SizedBox(height: 20,),

          //schedule radio section
          ScheduleRadioWidget(),
          
          SizedBox(height: 220,),
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


  