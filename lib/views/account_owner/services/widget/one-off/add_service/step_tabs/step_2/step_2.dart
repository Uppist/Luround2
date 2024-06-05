import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services/one-off/oneoff_service_controller.dart';
import 'package:luround/main.dart';
import 'package:luround/models/account_owner/ui/textcontroller_model.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/rebranded_reusable_button.dart';
import 'package:luround/utils/components/reusable_custom_textfield.dart';
import 'package:luround/utils/components/utils_textfield.dart';
import 'package:luround/views/account_owner/services/widget/one-off/add_service/step_tabs/step_2/one-off_widgets/textfield.dart';

import '../../../../program/add_service/step_tabs/step_1/new/custom_checkbox_listtile.dart';









class Step2Page extends StatefulWidget {
  const Step2Page({super.key, required this.onNext});
  final VoidCallback onNext;

  @override
  State<Step2Page> createState() => _Step2PageState();
}

class _Step2PageState extends State<Step2Page> {
  
  final controller = Get.put(ServicesController());
  
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
              child: SizedBox(width: 10.w,),
            ),
            SizedBox(width: 60.w,),
            Expanded(
              child: Text(
                "Virtual",
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
                "In-person",
                style: GoogleFonts.inter(
                  color: AppColor.darkGreyColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400
                ),
              ),
            ),
          ],
        ),

        //2           
        //growable list that displays textfields that was added
        /*ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(), //const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: controller.controllers.length, //certified (working)
          //padding: EdgeInsets.symmetric(vertical: 10.h),
          separatorBuilder: (context, index) => SizedBox(height: 20.h,),
          itemBuilder: (context, index) {  //certified (working)
                  
            ServiceControllerSett controllerSet = controller.controllers[index];
        
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: buildAdditionalTextField(
                    '', 
                    controllerSet.durationController, 
                    TextInputType.number, 
                    Icon(CupertinoIcons.clock, size: 22.r, color: AppColor.textGreyColor,), 
                    0.w,
                    Text(
                      "Min.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        color: AppColor.textGreyColor,
                        fontSize: 10.sp, //12.sp
                        fontWeight: FontWeight.w400
                      ),
                      overflow: TextOverflow.ellipsis,
                    ), 
                  ),
                ),
                SizedBox(width: 10.w,),
                Expanded(
                  child: buildAdditionalTextField(
                    '', 
                    controllerSet.virtualPriceController, 
                    TextInputType.number, 
                    Text(
                      currency(context).currencySymbol,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        color: AppColor.textGreyColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    //SvgPicture.asset("assets/svg/naira.svg"),
                    150.w
                  ),
                ),
                SizedBox(width: 10.w,),
                Expanded(
                  child: buildAdditionalTextField(
                    '', 
                    controllerSet.inpersonPriceController, 
                    TextInputType.number, 
                    Text(
                      currency(context).currencySymbol,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        color: AppColor.textGreyColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    //SvgPicture.asset("assets/svg/naira.svg"),
                    150.w
                  ),
                ),
                SizedBox(width: 10.w),
                InkWell(
                  onTap: () {
                    setState(() {
                      //profileController.textFields.removeAt(index);
                      controller.controllers.removeAt(index);
                      print("controller_list: ${controller.controllers}");
                      print("controller_list_length: ${controller.controllers.length}");
                    });
                  },
                  child: Icon(CupertinoIcons.delete, size: 24.r, color: AppColor.textGreyColor,),
                )
                
              ],
            );
                        
          },
        
        ),*/

        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
        //available days list
        ListView.separated(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (context, index) => SizedBox(height: 20.h,),
          itemCount: controller.priceSlot.length,
          itemBuilder: (context, index) {
    
            return Obx(
              () {
                //
                ServiceControllerSett controllerSet = controller.controllers[index];
                //
                String time = controller.priceSlot[index]['time'];
                //
                bool isSelected = controller.priceSlot[index]['isSelected'];
                //
                String virtualPrice = controller.getTimeSelection(time)?.virtual_pricing ?? "";
                //
                String inpersonPrice = controller.getTimeSelection(time)?.in_person_pricing ?? "";
                
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
                        /*if(time == "Custom") {
                          controller.isCustomTextFieldActivated.value = !controller.isCustomTextFieldActivated.value;
                        }*/

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
                            //
                            controller.updateVirtualPrice(time, val)
                            .whenComplete(() {
                              log("${controller.selectedTimeSlot}");
                              log(controllerSet.virtualPriceController.text);

                            });
                          },
                          onFieldSubmitted: (val) {
                            
                          },
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.none,
                          textController: controllerSet.virtualPriceController,
                          //initialValue: virtualPrice,
                          hintText: '${currency(context).currencySymbol} 0.00',
                        ),
                      ),

                      SizedBox(width: 10.w,),

                      //Inperson Price TextField
                      Expanded(
                        child: UtilsTextField4(
                          onChanged: (val) {
                            controllerSet.inpersonPriceController.text = val;
                            //
                            controller.updateInpersonPrice(time, val)
                            .whenComplete(() {
                              log("${controller.selectedTimeSlot}");
                              log(controllerSet.inpersonPriceController.text);
                            });
                          },
                          onFieldSubmitted: (val) {
                            
                          },
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.none,
                          textController: controllerSet.inpersonPriceController,
                          //initialValue: inpersonPrice,
                          hintText: '${currency(context).currencySymbol} 0.00',
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

        /*SizedBox(height: MediaQuery.of(context).size.height * 0.02),

        Obx(
          () {
            return controller.isCustomTextFieldActivated.value ? Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: UtilsTextField3(
                onChanged: (val) {
                  controller.customTimeSlotController.text = val;
                },
                onFieldSubmitted: (val) {
                  controller.updateCustomDuration(val);
                },
                hintText: "Type it here",
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                textController: controller.customTimeSlotController,
                              
              ),
            ) : const SizedBox();
          }
        ),*/      
            
        SizedBox(height: MediaQuery.of(context).size.height * 0.05),
    
        /*InkWell(
          onTap: () {           
            setState(() {
              ServiceControllerSett controllerSet = ServiceControllerSett();
              //controller.textFields.add(buildTextField(controllerSet));
              controller.controllers.add(controllerSet);
              print("controller_list: ${controller.controllers}");
              print("controller_list_length: ${controller.controllers.length}");
              // Access your controllers through the list of ControllerSet instances
              for (ServiceControllerSett controllerSet in controller.controllers) {
                print("duration: ${controllerSet.durationController.text}");
                print("virtual price: ${controllerSet.virtualPriceController.text}");
                print("in-person price: ${controllerSet.inpersonPriceController.text}");
              }

            });    
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                CupertinoIcons.add_circled, 
                size: 24.r, 
                color: AppColor.textGreyColor,
              ),
              SizedBox(width: 10.w,),
              Text(
                'Add time slot',
                style: GoogleFonts.inter(
                  color: AppColor.textGreyColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400
                )
              ),
              
            ],
          ),
        ),

        SizedBox(height: MediaQuery.of(context).size.height * 0.04,),*/

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
          textInputAction: TextInputAction.next,
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
        
        
        SizedBox(height: 10.h,),
    
    
      ]
    );
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
  