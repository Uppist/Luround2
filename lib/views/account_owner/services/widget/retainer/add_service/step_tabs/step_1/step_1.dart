import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services/retainer/retainer_service_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import 'package:luround/utils/components/reusable_custom_textfield.dart';
import 'package:luround/views/account_owner/services/widget/one-off/add_service/step_tabs/step_1/textfields/description_textfield.dart';








class Step1PagePackageService extends StatefulWidget {
  const Step1PagePackageService({super.key, required this.onNext});
  final VoidCallback onNext;

  @override
  State<Step1PagePackageService> createState() => _Step1PagePackageServiceState();
}

class _Step1PagePackageServiceState extends State<Step1PagePackageService> {


  var controller = Get.put(PackageServiceController());

  @override
  void initState() {
    // TODO: implement initState
    controller.serviceNameController.addListener(() {
      setState(() {
        controller.isServiceNameTapped.value = controller.serviceNameController.text.isNotEmpty;
      });
    });
    //listener
    controller.coreFeaturesController.addListener((){
      setState(() {
        controller.isFeaturesTapped.value = controller.coreFeaturesController.text.isNotEmpty;
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
                fontSize: 14.sp,
                fontWeight: FontWeight.w500
              ),
            ),
          ],
        ),
        SizedBox(height: 40.h),
        Text(
          "Features included in Retainer",
          style: GoogleFonts.inter(
            color: AppColor.blackColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500
          ), 
        ),
        SizedBox(height: 20.h),
        Obx(
          () {
            return ReusableTextField4(  
              onFieldSubmitted: (val) {
                if(val.isNotEmpty) {
                  controller.addInput(val).whenComplete(
                    () {
                      controller.coreFeaturesController.clear();
                    }
                  );
                }
              },
              hintText: "List out the core features of this service",
              keyboardType: TextInputType.name,
              textInputAction: TextInputAction.done,
              textController: controller.coreFeaturesController,
              isTapped: controller.isFeaturesTapped.value,
              suffixIcon: InkWell(
                onTap: () {
                  controller.addInput(controller.coreFeaturesController.text).whenComplete(
                    () {
                      controller.coreFeaturesController.clear();
                    }
                  );
                },
                child: Icon(
                  size: 24.r,
                  color: AppColor.darkGreen,
                  CupertinoIcons.check_mark_circled
                )
              ),
            );
          }
        ),
        SizedBox(height: 40.h),
        Obx(() {
          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: controller.inputs.length,
            separatorBuilder: (context, index) => SizedBox(height: 15.h,),
            itemBuilder: (context, index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    color: AppColor.blackColor,
                    size: 15.r,
                    CupertinoIcons.circle_fill
                  ),
                  SizedBox(width: 5.w,),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          controller.inputs[index],
                          style: GoogleFonts.inter(
                            color: AppColor.blackColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            controller.removeInput(index);
                          },
                          child: Icon(
                            color: AppColor.blackColor,
                            size: 24.r,
                            CupertinoIcons.delete
                          ),
                        )
        
                      ],
                    )
                  )
                ],
              );
            },
          );
        }),

        SizedBox(height: MediaQuery.of(context).size.height * 0.20),

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
        SizedBox(height: 10.h,),


      ]
    );
  }
}