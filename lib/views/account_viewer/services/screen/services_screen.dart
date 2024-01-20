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
  AccViewerServicesPage({super.key,});

  var controller = Get.put(AccViewerServicesController());
  var service = Get.put(AccViewerService());
  //final String userEmail = LocalStorage.getUseremail();

  @override
  Widget build(BuildContext context) {
    // Access the parameter using Get.parameters['userName']
    String userName = Get.parameters['user'] ?? 'DefaultUserName';
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
                      Image.asset('assets/images/latest_logo.png'),
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
              future: service.getUserServices(userName: userName),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Expanded(child: Loader());
                }
                if (snapshot.hasError) {
                  debugPrint("${snapshot.error}");
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  print("sn-trace: ${snapshot.stackTrace}");
                  print("sn-data: ${snapshot.data}");
                  return Expanded(child: Loader2());
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
                        //color: AppColor.bgColor, //index.isEven ? AppColor.lightRed : AppColor.lightPurple,
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
                        decoration: BoxDecoration(
                          color: index.isOdd ? AppColor.navyBlue : AppColor.darkMainColor,
                          borderRadius: BorderRadius.circular(20.r),
                          /*border: Border.all(
                            color: AppColor.darkGreyColor,
                            width: 1.0,
                          )*/
                        ),
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
                                    color: AppColor.bgColor,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600
                                  ),
                                ),
                            
                                SizedBox(height: 30.h,),
                            
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "${data[index].available_days}",
                                            style: GoogleFonts.inter(
                                              color: AppColor.bgColor,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w400
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            "${data[index].time}",
                                            style: GoogleFonts.inter(
                                              color: AppColor.bgColor,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w400
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          //price
                                          Obx(
                                            () {
                                              return Text(
                                                controller.isVirtual.value && controller.selectedIndex.value == index 
                                                ? "N${data[index].service_charge_virtual}" 
                                                : "N${data[index].service_charge_in_person}",
                                                style: GoogleFonts.inter(
                                                  color: AppColor.bgColor,
                                                  fontSize: 20.sp,
                                                  fontWeight: FontWeight.w600
                                                ),
                                              );
                                            }
                                          ),
                                          SizedBox(height: 5.h,),
                                          //time
                                          data[index].duration!.isEmpty ?
                                          Text("")
                                          :Text(
                                            "per ${data[index].duration} session",
                                            style: GoogleFonts.inter(
                                              color: AppColor.whiteTextColor,
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w500,
                                              //fontStyle: FontStyle.italic
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                            
                                SizedBox(height: 30.h,),
                            
                                Text(
                                  data[index].description!,
                                  style: GoogleFonts.inter(
                                    color: AppColor.bgColor,
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
                                      //SvgPicture.asset("assets/svg/link_icon.svg"),
                                      Icon(
                                        CupertinoIcons.link,
                                        color: AppColor.whiteTextColor,
                                      ),
                                      SizedBox(width: 10.w,),
                                      Expanded(
                                        child: Text(
                                          data[index].links[0],
                                          style: GoogleFonts.inter(
                                            color: index.isEven ? AppColor.navyBlue : AppColor.mainColor,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w500,
                                            
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            
                                SizedBox(height: 30.h,),
                                            
                                //request quote                        
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    //price
                                    Text(
                                      "Require a personalized touch?",
                                      style: GoogleFonts.inter(
                                        color: AppColor.whiteTextColor,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500
                                      ),
                                    ),
                                    //SizedBox(width: 5,),
                                    //time
                                    TextButton(
                                      onPressed: () {
                                        Get.to(() => RequestQuoteScreen(
                                          service_name: data[index].service_name,
                                          service_provider_email: data[index].service_provider_details['email'],
                                          service_provider_name: data[index].service_provider_details['displayName'], 
                                          service_id: data[index].serviceId,
                                        ));
                                      },
                                      child: Text(
                                        "Request Quote",
                                          style: GoogleFonts.inter(
                                          color: AppColor.yellowStar,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600,
                                          decoration: TextDecoration.underline,
                                          decorationColor: AppColor.yellowStar,
                                        ),
                                      ),
                                    ),
                                  ]
                                ),

                                SizedBox(height: 30.h,),
                                
                                //bookings button here
                                ReusableButton(
                                  onPressed: () {
                                    Get.to(() => BookAppointmentScreen(
                                      avail_time: data[index].available_time,
                                      serviceId: data[index].serviceId,
                                      service_name: data[index].service_name,
                                      date: data[index].date,
                                      time: data[index].time,
                                      duration: data[index].duration!,
                                      service_charge_virtual: data[index].service_charge_virtual!,
                                      service_charge_in_person: data[index].service_charge_in_person!,
                                    ));
                                  },
                                  color: index.isEven ? AppColor.navyBlue : AppColor.mainColor,
                                  text: "Book Now",
                                ),
                            
                              ]
                            ),
                            //SizedBox(height: 10.h,) 
                              
                          
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