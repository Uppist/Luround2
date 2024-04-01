import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services/package_service/package_service_controller.dart';
import 'package:luround/services/account_owner/services/user_services._service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/views/account_owner/services/widget/package/edit_service/screen/edit_service_bottomsheet.dart';
import 'package:luround/views/account_owner/services/widget/screen_widget/toggle_service_price_container/toggle_price_package.dart';







class PackageServiceList extends StatefulWidget {
  const PackageServiceList({super.key});

  @override
  State<PackageServiceList> createState() => _PackageServiceListState();
}

class _PackageServiceListState extends State<PackageServiceList> {

  final controller = Get.put(PackageServiceController());
  final AccOwnerServicePageService userService = Get.put(AccOwnerServicePageService());

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0),
      itemCount: 3, //userService.filterSearchServicesList.length,
      separatorBuilder: (context, index) => SizedBox(height: 25.h,),
      itemBuilder: (context, index) {
        
        //run even and odd checks for dynamism

        return Container(
          //height: 500,
          width: double.infinity,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          decoration: BoxDecoration(
            color: index.isEven ? AppColor.darkMainColor : AppColor.navyBlue,
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //toggle price button
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //check if the account owner selected in-person or virtual
                  TogglePriceContainerPackageService(index: index,),
                  InkWell(
                    onTap: () {
                      editPackageServiceDialogueBox(
                        service_link: userService.filterSearchServicesList[index].service_link,
                        context: context, 
                        userId: userService.filterSearchServicesList[index].service_provider_details['userId'],
                        email: userService.filterSearchServicesList[index].service_provider_details['email'],
                        displayName: userService.filterSearchServicesList[index].service_provider_details['displayName'],
                        serviceId: userService.filterSearchServicesList[index].serviceId,
                        service_name: userService.filterSearchServicesList[index].service_name,
                        description: userService.filterSearchServicesList[index].description!,
                        links: userService.filterSearchServicesList[index].links,
                        service_charge_in_person: userService.filterSearchServicesList[index].service_charge_in_person!,
                        service_charge_virtual: userService.filterSearchServicesList[index].service_charge_virtual!,
                        duration: userService.filterSearchServicesList[index].duration!,
                        date: userService.filterSearchServicesList[index].date,
                        time: userService.filterSearchServicesList[index].time,
                        available_days: userService.filterSearchServicesList[index].available_days
                      );
                    },
                    child: Icon(
                      Icons.more_vert_rounded,
                      color: AppColor.bgColor,
                      size: 30.r,
                    ),
                  ),                                   
                ],
              ),

              SizedBox(height: 20.h,),
              
              //ALL SUBSEQUENT INFORMATION COMES HERE
              Text(
                "Personal Training",
                style: GoogleFonts.inter(
                  color: AppColor.bgColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600
                ),
              ),


            ]
          )
        );
      }
    );
  }
}