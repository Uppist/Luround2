import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services_controller.dart';
import 'package:luround/models/account_owner/user_services/user_service_model.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/loader.dart';
import 'package:luround/views/account_owner/profile/widget/notifications/notifications_page.dart';
import 'package:luround/views/account_owner/services/screen/service_empty_state.dart';
import 'package:luround/views/account_owner/services/widget/add_service_stepper.dart';
import 'package:luround/views/account_owner/services/widget/edit_service_bottomsheet.dart';
import 'package:luround/views/account_owner/services/widget/toggle_service_price_container/toggle_price.dart';








class ServicesPage extends StatelessWidget {
  ServicesPage({super.key});

  var controller = Get.put(ServicesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.greyColor, //controller.isServicePresent.value ? AppColor.bgColor : AppColor.greyColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ///Header Section
            Container(
              color: AppColor.bgColor,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset('assets/images/luround_logo.png'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.to(() => NotificationsPage());
                            },
                            child: SvgPicture.asset("assets/svg/notify_active.svg"),
                          ),
                          SizedBox(width: 20.w,),
                          InkWell(
                            onTap: () async{
                              Get.to(() => AddServiceScreen());
                            },
                            child: SvgPicture.asset("assets/svg/add_service.svg"),
                          ),
                        ],
                      )
                    ]
                  ),
                  SizedBox(height: 30.h,),
                  Center(
                    child: Text(
                      "Services",
                      style: GoogleFonts.inter(
                        color: AppColor.blackColor,
                        fontSize: 19.sp,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                  ),
                ],
              ),
            ),         
            

            SizedBox(height: 20.h,),


            //Futurebuilder will start from here (will wrap this listview)
            FutureBuilder<UserServiceModel>(
              future: null,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Loader();
                }
                if (snapshot.hasError) {
                  print(snapshot.error);
                }
                if (!snapshot.hasData) {
                  print("sn-trace: ${snapshot.stackTrace}");
                  print("sn-data: ${snapshot.data}");
                  return ServiceEmptyState(
                    onPressed: () {
                      Get.to(() => AddServiceScreen());
                    },
                  );
                }

                var data = snapshot.data!;

                return Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0), //external paddin
                    itemCount: 8,
                    separatorBuilder: (context, index) => SizedBox(height: 25.h,),
                    itemBuilder: (context, index) {
                      return Container(
                        //height: 500,
                        width: double.infinity,
                        color: index.isEven ? AppColor.lightRed : AppColor.lightPurple,
                        alignment: Alignment.center,
                        //padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          editServiceDialogueBox(
                                            context: context, 
                                            serviceName: data.service_name,
                                            serviceId: data.serviceId,
                                          );
                                        },
                                        child: Icon(
                                          Icons.more_vert_rounded,
                                          color: AppColor.darkGreyColor,
                                          size: 30,
                                        ),
                                      ),
                                      
                                    ],
                                  ),
                                  SizedBox(height: 20.h,),
                                  //check if the account owner selected in-person or virtual
                                  //VirtualContainer()  //InpersonContainer()
                                  Center(
                                    child: TogglePriceContainer(index: index,),
                                  ),
                                  SizedBox(height: 40.h,),
                                  Text(
                                    data.service_name,
                                    style: GoogleFonts.inter(
                                      color: AppColor.blackColor,
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.w500
                                    ),
                                  ),
                                  SizedBox(height: 20.sp,),
                                  Text(
                                    "${data.available_days} . ${data.time}",
                                    style: GoogleFonts.inter(
                                      color: AppColor.textGreyColor,
                                      fontSize: 16.sp,
                                      //fontWeight: FontWeight.w500
                                    ),
                                  ),
                                  SizedBox(height: 20.h,),
                                  Text(
                                    data.description,
                                    style: GoogleFonts.inter(
                                      color: AppColor.darkGreyColor,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w500
                                    ),
                                  ),
                                  SizedBox(height: 20.h,),
                                  //link 1
                                  InkWell(
                                    onTap: () {},
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        SvgPicture.asset("assets/svg/link_icon.svg"),
                                        SizedBox(width: 10.w,),
                                        Text(
                                          data.links[0],
                                          style: GoogleFonts.inter(
                                            color: AppColor.blueColor,
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w500
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  /*SizedBox(height: 20.h,),
                                  //link 1
                                  InkWell(
                                    onTap: () {},
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        SvgPicture.asset("assets/svg/link_icon.svg"),
                                        SizedBox(width: 10.w,),
                                        Text(
                                          "https://www.link.com",
                                          style: GoogleFonts.inter(
                                            color: AppColor.blueColor,
                                            fontSize: 15.sp,
                                            fontWeight: FontWeight.w500
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),*/
                                  SizedBox(height: 30.h,),
                                  //price/session
                                  Obx(
                                    () {
                                      return RichText(
                                        text: TextSpan(
                                          children: [
                                            //price
                                            TextSpan(
                                              text: controller.isVirtual.value && controller.selectedIndex.value == index ? data.service_charge_virtual : data.service_charge_in_person,
                                              style: GoogleFonts.inter(
                                                color: AppColor.blackColor,
                                                fontSize: 22.sp,
                                                fontWeight: FontWeight.bold
                                              ),
                                            ),
                                            //time
                                            data.duration == 0 ?
                                            TextSpan():
                                            data.duration > 0 && data.duration <= 59 ?
                                            TextSpan(
                                              text: "/${data.duration}mins",
                                              style: GoogleFonts.inter(
                                                color: AppColor.darkGreyColor,
                                                fontSize: 19.sp,
                                                fontWeight: FontWeight.w500
                                              ),
                                            )
                                            :TextSpan(
                                              text: "/${data.duration}hr", 
                                              style: GoogleFonts.inter(
                                                color: AppColor.darkGreyColor,
                                                fontSize: 19.sp,
                                                fontWeight: FontWeight.w500
                                              ),
                                            ),
                                            //session
                                            data.duration == 0 ? 
                                            const TextSpan()
                                            :TextSpan(
                                              text: " per session",
                                              style: GoogleFonts.inter(
                                                color: AppColor.textGreyColor,
                                                fontSize: 17.sp,
                                                fontWeight: FontWeight.w500
                                              ),
                                            )
                                          ]
                                        ),
                                      );
                                    }
                                  ),
                                  SizedBox(height: 30.h,),
                                ]
                              )
                            )
                          ]                           
                          
                        ),
                      );
                    }
                  ),
                );
              }
            ),           
          
          ]
        )
      )
    );
  }
}