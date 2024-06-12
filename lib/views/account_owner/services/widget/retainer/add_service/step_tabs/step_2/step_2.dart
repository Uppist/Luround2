import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services/retainer/retainer_service_controller.dart';
import 'package:luround/main.dart';
import 'package:luround/models/account_owner/ui/textcontroller_model.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/my_snackbar.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import 'package:luround/utils/components/reusable_custom_textfield.dart';
import 'package:luround/utils/components/utils_textfield.dart';
import 'package:luround/views/account_owner/services/widget/one-off/add_service/step_tabs/step_2/one-off_widgets/textfield.dart';
import 'package:luround/views/account_owner/services/widget/program/add_service/step_tabs/step_1/new/custom_checkbox_listtile.dart';









class Step2PagePackageService  extends StatefulWidget {
  const Step2PagePackageService({super.key, required this.onNext,});
  final VoidCallback onNext;

  @override
  State<Step2PagePackageService> createState() => _Step2PagePackageServiceState();
}

class _Step2PagePackageServiceState extends State<Step2PagePackageService > {
  
  final controller = Get.put(PackageServiceController());
  
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Pricing",
          style: GoogleFonts.inter(
            color: AppColor.blackColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500
          ),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.04),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: SizedBox(width: 150.w)
            ),
            SizedBox(width: 60.w,),
            Expanded(
              child: Text(
                "Virtual (${currency(context).currencySymbol})",
                style: GoogleFonts.inter(
                  color: AppColor.darkGreyColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400
                ),
              ),
            ),
            SizedBox(width: 10.w,),
            Expanded(
              child: Text(
                "In-person (${currency(context).currencySymbol})",
                style: GoogleFonts.inter(
                  color: AppColor.darkGreyColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400
                ),
              ),
            ),
          ],
        ),
        
      

        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
        //available days list
        ListView.separated(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) => SizedBox(height: 20.h,),
          itemCount: controller.priceSlot.length,
          itemBuilder: (context, index) {

            ServiceControllerSett controllerSet = controller.controllersInput[index];

            //
            String time = controller.priceSlot[index]['time'];
            //
            bool isSelected = controller.priceSlot[index]['isSelected'];
            //
            String virtualPrice = controller.getTimeSelection(time)?.virtual_pricing ?? "";
            //
            String inpersonPrice = controller.getTimeSelection(time)?.in_person_pricing ?? "";

            return Obx(
              () {
        
                return CustomCheckBoxListTile(
                  checkbox: Checkbox.adaptive(
                    checkColor: AppColor.bgColor,
                    activeColor: AppColor.mainColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.r)
                    ),
                    value: isSelected,
                    onChanged: (value) {   
                      // Toggle checkbox and update selection in the list
                      setState(() {
                        
                        controller.isCheckBoxActiveForPricing.value = true;
                        isSelected = value!;
                        //
                        controller.toggleTimeSlotSelection(
                          index, 
                          time, 
                          value, 
                          virtualPrice, 
                          inpersonPrice,
                        );
                        //checks for custom selection for mins
                        if(time == "Custom") {
                          controller.isCustomTextFieldActivated.value = !controller.isCustomTextFieldActivated.value;
                        } 

                      });
                    },
                  ),              
                  
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          time,
                          style: GoogleFonts.inter(
                            color: AppColor.blackColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                      ),

                      SizedBox(width: 5.w,),

                      //Virtual Price TextField
                      Expanded(
                        child: UtilsTextField4(
                          onChanged: (val) {
                            controllerSet.virtualPriceController.text = val;
                            controller.updateVirtualPrice(time, val)
                            .whenComplete(() {
                              log("${controller.selectedTimeSlot}");
                              log(controllerSet.virtualPriceController.text);
                            });
                          },
                          onFieldSubmitted: (val) {
                            
                          },
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          textController: controllerSet.virtualPriceController,
                          //initialValue: virtualPrice,
                          hintText: '0.00',
                        ),
                      ),

                      SizedBox(width: 10.w,),

                      //Inperson Price TextField
                      Expanded(
                        child: UtilsTextField4(
                          onChanged: (val) {
                            controllerSet.inpersonPriceController.text = val;
                            controller.updateInpersonPrice(time, val)
                            .whenComplete(() {
                              log("${controller.selectedTimeSlot}");
                              log(controllerSet.inpersonPriceController.text);
                            });
                          },
                          onFieldSubmitted: (val) {
                            
                          },
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.done,
                          textController: controllerSet.inpersonPriceController,
                          //initialValue: inpersonPrice,
                          hintText: '0.00',
                        ),
                      ),
                
                    ],
                  ),
                  subtitle: controller.isCheckBoxActiveForPricing.value ? const SizedBox() : const SizedBox()
                );
              }
            );
            
          }, 
        ),
            

        SizedBox(height: MediaQuery.of(context).size.height * 0.05,),
  

        Text(
          "Add meeting link for virtual bookings",
          style: GoogleFonts.inter(
            color: AppColor.blackColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500
          ),
        ),
        SizedBox(height: 20.h),
        //textfield
        ReusableTextField(  
          onChanged: (val) {},
          hintText: "Meeting link",
          keyboardType: TextInputType.url,
          textInputAction: TextInputAction.done,
          textController: controller.addLinksController
        ),

        
        SizedBox(height: MediaQuery.of(context).size.height * 0.04),
    
      
         Obx(
          () {
            return RebrandedReusableButton(
              textColor: controller.isCheckBoxActiveForPricing.value ? AppColor.bgColor : AppColor.darkGreyColor,
              color: controller.isCheckBoxActiveForPricing.value ? AppColor.mainColor : AppColor.lightPurple,
              text: "Next", 
              onPressed: controller.isCheckBoxActiveForPricing.value ? 
              widget.onNext
              : () {
                print('nothing');
                //controller.controllers.clear();
              },
            );
          }
        ),
      ]
    );
        
        
    //SizedBox(height: 10.h,),
    
    
    
  }
}


//subfields for duration, virtual and in-person price
Widget buildAdditionalTextField(String hintText, TextEditingController controller, TextInputType inputType, Widget prefixIcon, double width, [Widget? suffixIcon]) {
  return OneoffTextField(
    onFieldSubmitted: (p0) {},
    onFocusChanged: (p0) {},
    onChanged: (val) {},
    textController: controller,
    hintText: hintText,  
    keyboardType: inputType,
    textInputAction: TextInputAction.next,
    prefixIcon: prefixIcon,
    width: width,
    suffixIcon: suffixIcon,
  );
}