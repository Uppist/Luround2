import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services/program_service/program_service_controller.dart';
import 'package:luround/services/account_owner/services/user_services_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/share_profile_link.dart';
import 'package:luround/views/account_owner/services/widget/program/edit_service/screen/edit_program_service.dart';
import 'package:luround/views/account_owner/services/widget/screen_widget/delete_service/delete_service_bottomsheet.dart';
import 'package:luround/views/account_owner/services/widget/screen_widget/service_insight/service_insight.dart';
import 'package:luround/views/account_owner/services/widget/screen_widget/switch_widget_suspend.dart';









///Alert Dialog
Future<void> editProgramServiceDialogueBox({
  required BuildContext context, 
  required String serviceId,
  required String service_name, 
  required String description, 
  required List<dynamic> links, 
  required String service_charge_in_person, 
  required String service_charge_virtual, 
  //required String service_link,
  required String duration, 
  required String time, 
  required String date, 
  required String available_days,
  //service_provider_details below
  required String userId,
  required String email,
  required String displayName,
  required int max_number_of_participants,
  required AccOwnerServicePageService service,
}) async {

  var controller = Get.put(ProgramServiceController());
  showModalBottomSheet(
    isScrollControlled: true,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 2,
    isDismissible: true,
    useSafeArea: true,
    backgroundColor: AppColor.bgColor,
    //barrierColor: Theme.of(context).colorScheme.background,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(15.r)
      )
    ),
    context: context, 
    builder: (context) {
      return Wrap(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
            decoration: BoxDecoration(
              //image: DecorationImage(image: AssetImage(''),),
              color: AppColor.bgColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
              ),
            ),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //1
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    Get.to(() => EditProgramServiceScreen(
                      serviceId: serviceId,
                      service_name: service_name,
                      description: description,
                      links: links,
                      service_charge_in_person: service_charge_in_person,
                      service_charge_virtual: service_charge_virtual,
                      duration: duration,
                      time: time,
                      date: date,
                      available_days: available_days,
                      max_number_of_participants: max_number_of_participants,
                    ));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset('assets/svg/pen_photo.svg'),
                      SizedBox(width: 20.w,),
                      Expanded(
                        child: Text(
                          'Edit',
                          style: GoogleFonts.inter(
                            color: AppColor.textGreyColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500
                          )
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.h,),

                //1
                InkWell(
                  onTap: () {
                    Get.back();
                    Get.to(() => const ServiceInsightPage());
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset('assets/svg/service_insight.svg'),
                      SizedBox(width: 20.w,),
                      Expanded(
                        child: Text(
                          'Service insight',
                          style: GoogleFonts.inter(
                            color: AppColor.textGreyColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500
                          )
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.h,),
                
                //SUSPEND/UNSUSPEND SERVICE
                Obx(
                  () {
                    return InkWell(
                      onTap: (){},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          controller.isToggled.value ? SvgPicture.asset('assets/svg/unsuspend_service.svg') : SvgPicture.asset('assets/svg/suspend_service.svg'),
                          SizedBox(width: 20.w,),
                          Expanded(
                            child: Text(
                              controller.isToggled.value ? 'Unsuspend service' : 'Suspend service',
                              style: GoogleFonts.inter(
                                color: AppColor.textGreyColor,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500
                              )
                            ),
                          ),
                          SwitchWidgetSuspend(
                            isToggled: controller.isToggled.value,
                            onChanged: (value) {           
                              controller.isToggled.value = value;
                              debugPrint("toggled: ${controller.isToggled.value}");
                              debugPrint("toggled val: $value");
                              if(value){
                                debugPrint("call the suspend api");
                                service.suspendUserService(
                                  context: context, 
                                  serviceId: serviceId
                                );
                              }
                              else{
                                debugPrint("call the unsuspend api");
                                service.suspendUserService(
                                  context: context, 
                                  serviceId: serviceId
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    );
                  }
                ),
                SizedBox(height: 30.h,),

                //2            
                InkWell(
                  onTap: () {
                    //Navigator.pop(context);
                    //shareServiceLink(link: service_link);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset('assets/svg/share_service.svg'),
                      SizedBox(width: 20.w,),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Share service link',
                              style: GoogleFonts.inter(
                                color: AppColor.textGreyColor,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500
                              )
                            ),

                            /////////COMING SOON//////////////
                            SizedBox(width: 20.w,),
                            Container(
                              //padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                              alignment: Alignment.center,
                              height: 30.h,
                              width: 90.w, //130.w
                              decoration: BoxDecoration(
                                color: AppColor.redColor,
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                              child: Text(
                                'coming soon',
                                style: GoogleFonts.inter(
                                  color: AppColor.bgColor,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w700
                                )
                              ),
                            ),
                            ////////////////////////////////////////
                        
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.h,),
                //1
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    deleteServiceDialogueBox(
                      userId: userId,
                      email: email,
                      displayName: displayName,
                      context: context, 
                      serviceName: service_name,
                      serviceId: serviceId,
                    );
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset('assets/svg/delete_photo.svg'),
                      SizedBox(width: 20.w,),
                      Expanded(
                        child: Text(
                          'Delete',
                          style: GoogleFonts.inter(
                            color: AppColor.textGreyColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500
                          )
                        ),
                      ),
                    ],
                  ),
                ),
                //SizedBox(height: 10,),
              ],
            ),
          ),
        ],
      );
    }
  );
}