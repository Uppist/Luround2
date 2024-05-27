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
import 'package:luround/views/account_owner/services/widget/retainer/edit_service/step_tabs/step_1/textfields/description_textfield_edit.dart';
import 'package:luround/views/account_owner/services/widget/retainer/edit_service/step_tabs/step_1/textfields/edit_normal_textfield.dart';








class Step1PagePackageServiceEdit extends StatefulWidget {
  const Step1PagePackageServiceEdit({super.key, required this.onNext, required this.serviceId, required this.service_name, required this.description, required this.links, required this.service_charge_in_person, required this.service_charge_virtual,});
  final VoidCallback onNext;
  final String serviceId;
  final String service_name;
  final String description;
  final List<dynamic> links;
  final String service_charge_in_person;
  final String service_charge_virtual;

  @override
  State<Step1PagePackageServiceEdit> createState() => _Step1PagePackageServiceEditState();
}

class _Step1PagePackageServiceEditState extends State<Step1PagePackageServiceEdit> {
  
  var controller = Get.put(PackageServiceController());

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
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
          initialValue: widget.service_name,
        ),
        SizedBox(height: 30.h),
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
        SizedBox(height: 10.h,),
        //max length for message textfield
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "${controller.descriptionControllerEdit.text.length}/${controller.maxLengthEdit}",
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
          "Services included in Retainer",
          style: GoogleFonts.inter(
            color: AppColor.blackColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500
          ),
        ),
        SizedBox(height: 20.h),
        ReusableTextField3(  
          onFieldSubmitted: (val) {
            controller.addInputEdit(val).whenComplete(
              () {
                controller.coreFeaturesControllerEdit.clear();
              }
            );
          },
          hintText: "List out the core features of this service",
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
          textController: controller.coreFeaturesControllerEdit,
        ),
        SizedBox(height: 40.h),
        Obx(() {
          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            itemCount: controller.inputsEdit.length,
            separatorBuilder: (context, index) => SizedBox(height: 10.h,),
            itemBuilder: (context, index) {
              //Text(controller.inputs[index])
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
                          controller.inputsEdit[index],
                          style: GoogleFonts.inter(
                            color: AppColor.blackColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            controller.removeInputEdit(index);
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
          textColor: AppColor.bgColor,
          color: AppColor.mainColor, 
          text: "Next", 
          onPressed: widget.onNext
        ),
        //SizedBox(height: 20.h,),

      ]
    );
  }
}