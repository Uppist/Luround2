import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_viewer/services_controller.dart';
import 'package:luround/models/account_owner/user_services/user_service_response_model.dart';
import 'package:luround/services/account_owner/data_service/local_storage/local_storage.dart';
import 'package:luround/services/account_viewer/services/get_user_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/loader.dart';
import 'package:luround/utils/components/reusable_button.dart';
import 'package:luround/views/account_owner/services/screen/service_empty_state.dart';
import 'package:luround/views/account_viewer/services/widgets/book_a_service/screen/book_a_service.dart';
import 'package:luround/views/account_viewer/services/widgets/request_quote/request_quote_screen.dart';
import 'package:luround/views/account_viewer/services/widgets/toggle_price/toggle_price_accviewer.dart';








class AccViewerServicesPage extends StatelessWidget {
  AccViewerServicesPage({super.key});

  var controller = Get.put(AccViewerServicesController());
  var service = Get.put(AccViewerService());
  final String userEmail = LocalStorage.getUseremail();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.greyColor,
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.asset('assets/images/luround_logo.png'),
                    ]
                  ),
                  SizedBox(height: 30.h,),
                  Center(
                    child: Text(
                      "Services",
                      style: GoogleFonts.inter(
                        color: AppColor.blackColor,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                  ),
                  //SizedBox(height: 10,),
                ],
              ),
            ),         
            /////////////////
      
            SizedBox(height: 20.h,),

            //Futurebuilder will start from here (will wrap this listview)
            FutureBuilder<List<UserServiceModel>>(
              future: service.getUserServices(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Loader();
                }
                if (snapshot.hasError) {
                  debugPrint("${snapshot.error}");
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  print("sn-trace: ${snapshot.stackTrace}");
                  print("sn-data: ${snapshot.data}");
                  return Loader2();
                } 
                     
                //[Do this if anything sups]//
                if (snapshot.hasData) {
      
                  var data = snapshot.data!;
              
                  return Expanded(
                    child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h), //external paddin
                    itemCount: data.length,
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

                                  //check if the account owner selected in-person or virtual                     
                                  Center(            
                                    child: TogglePriceContainerAccViewer(index: index,)
                                  ),
                                  SizedBox(height: 40.h,),
                                  Text(
                                    data[index].service_name,
                                    style: GoogleFonts.inter(
                                      color: AppColor.blackColor,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600
                                    ),
                                  ),
                                  SizedBox(height: 20.h,),
                                  Text(
                                    "${data[index].available_days} . ${data[index].time}",
                                    style: GoogleFonts.inter(
                                      color: AppColor.textGreyColor,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400
                                    ),
                                  ),
                                  SizedBox(height: 20.h,),
                                  Text(
                                    data[index].description,
                                    style: GoogleFonts.inter(
                                      color: AppColor.darkGreyColor,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400
                                    ),
                                  ),
                                  SizedBox(height: 20.h,),
                                  //link 1
                                  InkWell(
                                    onTap: () {
                                      service.launchUrlLink(link: data[index].links[0]);
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        SvgPicture.asset("assets/svg/link_icon.svg"),
                                        SizedBox(width: 10.w,),
                                        Text(
                                          data[index].links[0],
                                          style: GoogleFonts.inter(
                                            color: AppColor.blueColor,
                                            fontSize: 12.sp,
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
                                            fontSize: 12.sp,
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
                                              text: controller.isVirtual.value && controller.selectedIndex.value == index 
                                              ? "N${data[index].service_charge_virtual}" 
                                              : "N${data[index].service_charge_in_person}",
                                              style: GoogleFonts.inter(
                                                color: AppColor.blackColor,
                                                fontSize: 20.sp,
                                                fontWeight: FontWeight.w600
                                              ),
                                            ),
                                            //time
                                            data[index].duration.isEmpty ?
                                            TextSpan()
                                            :TextSpan(
                                              text: "/${data[index].duration}",
                                              style: GoogleFonts.inter(
                                                color: AppColor.darkGreyColor,
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.w500,
                                                //fontStyle: FontStyle.italic
                                              ),
                                            ),
                                            //session
                                            TextSpan(
                                              text: " per session",
                                              style: GoogleFonts.inter(
                                                color: AppColor.textGreyColor,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500
                                              ),
                                            )
                                          ]
                                        ),
                                      );
                                    }
                                  ),
                                  SizedBox(height: 20.h,),
                
                                  //request quote                        
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      //price
                                      Text(
                                        "Require a personalized touch?",
                                        style: GoogleFonts.inter(
                                          color: AppColor.textGreyColor,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w500
                                        ),
                                      ),
                                      //SizedBox(width: 5,),
                                      //time
                                      TextButton(
                                        onPressed: () {
                                          Get.to(() => RequestQuoteScreen());
                                        },
                                        child: Text(
                                          "Request Quote",
                                            style: GoogleFonts.inter(
                                            color: AppColor.yellowStar,
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w600,
                                            decoration: TextDecoration.underline,
                                            decorationColor: AppColor.yellowStar,
                                          ),
                                        ),
                                      ),
                                    ]
                                  )
                                ]
                              )                                           
                            ),
                            //
                            Container(
                              height: 100.h,
                              width: double.infinity,
                              color: AppColor.bgColor,
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                              child: ReusableButton(
                                onPressed: () {
                                  Get.to(() => BookAppointmentScreen(
                                    serviceId: data[index].serviceId,
                                    service_name: data[index].service_name,
                                    date: data[index].date,
                                    time: data[index].time,
                                    duration: data[index].duration,
                                    service_charge_virtual: data[index].service_charge_virtual,
                                    service_charge_in_person: data[index].service_charge_in_person,
                                  ));
                                },
                                color: AppColor.mainColor,
                                text: "Book Now",
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  ),
                  );
                }
            
                return Center(
                  child: Text(
                    "connection timed out",
                    style: GoogleFonts.inter(
                      color: AppColor.darkGreyColor,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.normal
                    ) 
                  )
                );

              }
            ),
            
            ///
          ]
        )
      )
    );
  }
}