import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services/regular_service/services_controller.dart';
import 'package:luround/models/account_owner/user_services/user_service_response_model.dart';
import 'package:luround/services/account_owner/services/user_services._service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/loader.dart';
import 'package:luround/views/account_owner/profile/widget/notifications/notifications_page.dart';
import 'package:luround/views/account_owner/services/screen/service_empty_state.dart';
import 'package:luround/views/account_owner/services/widget/regular/add_service/screen/add_service_screen.dart';
import 'package:luround/views/account_owner/services/widget/regular/edit_service/edit_service_bottomsheet.dart';
import 'package:luround/views/account_owner/services/widget/screen_widget/toggle_service_price_container/toggle_price.dart';
import '../../../../services/account_owner/data_service/local_storage/local_storage.dart';









class ServicesPage extends StatefulWidget {
  ServicesPage({super.key});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {

  var controller = Get.put(ServicesController());
  final AccOwnerServicePageService userService = Get.put(AccOwnerServicePageService());

  // GlobalKey for RefreshIndicator
  final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();
  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 1));
    // Fetch new data here
    final List<UserServiceModel>  newData = await userService.getUserServices();
    // Update the UI with the new data
    userService.servicesList.clear();
    userService.servicesList.addAll(newData);
    print('updated service list: ${userService.servicesList}');
  }
  
  /*final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();
  Future<void> _refreshSS() async {
    await Future.delayed(Duration(seconds: 1));
    // Fetch new data here
    final List<UserServiceModel>  newData = (userService.getUserServicesSocket()) as List<UserServiceModel>;
    // Update the UI with the new data
    userService.servicesList.clear();
    userService.servicesList.addAll(newData);
    print('updated service list: ${userService.servicesList}');
  }*/


  //late Stream<List<UserServiceModel>> userServiceStream;
  //late Future<List<UserServiceModel>> userServiceFuture;
  @override
  void initState() {
    super.initState();
    userService.getUserServices().then(
      (value) {
         userService.servicesList.clear();
         userService.servicesList.addAll(value);
      }
    );
    //userServiceFuture = userService.getUserServices();
    //userServiceStream = userService.getUserServicesSocket();
  }

  //var data = userService.servicesList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.greyColor, //controller.isServicePresent.value ? AppColor.bgColor : AppColor.greyColor,
      body: Column(
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
                SizedBox(height: 20.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                 
                    Text(
                      "Services",
                      style: GoogleFonts.inter(
                        color: AppColor.blackColor,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                    InkWell(
                      onTap: () async{
                        Get.to(() => AddServiceScreen());
                      },
                      child: SvgPicture.asset("assets/svg/add_service.svg"),
                    ),
                  ]
                ),
      
                //SizedBox(height: 30.h,),
                /*Center(
                  child: Text(
                    "Services",
                    style: GoogleFonts.inter(
                      color: AppColor.blackColor,
                      fontSize: 19.sp,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ),*/
              ],
            ),
          ),         
          
            
          SizedBox(height: 20.h,),
             
            
          //Futurebuilder will start from here (will wrap this listview)
          Expanded(
            child: Obx(
              () {
                return userService.servicesList.isNotEmpty ? RefreshIndicator.adaptive(
                  color: AppColor.greyColor,
                  backgroundColor: AppColor.mainColor,
                  key: _refreshKey,
                  onRefresh: () {
                    return _refresh();
                  },
                  child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0), //external paddin
                    itemCount: userService.servicesList.length,
                    separatorBuilder: (context, index) => SizedBox(height: 25.h,),
                    itemBuilder: (context, index) {
                      if(index.isEven) {
                        return Container(
                          //height: 500,
                          width: double.infinity,
                          //color: AppColor.bgColor, //index.isEven ? AppColor.lightRed : AppColor.lightPurple,
                          alignment: Alignment.center,
                          //padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                          decoration: BoxDecoration(
                            color: AppColor.darkMainColor,
                            borderRadius: BorderRadius.circular(20.r),
                              /*border: Border.all(
                                color: AppColor.darkGreyColor,
                                width: 1.0,
                              )*/
                             ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  SizedBox(height: 20.h),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      //check if the account owner selected in-person or virtual
                                                      TogglePriceContainer(index: index,),
                                                      InkWell(
                                                        onTap: () {
                                                          editServiceDialogueBox(
                                                            service_link: userService.servicesList[index].service_link,
                                                            context: context, 
                                                            userId: userService.servicesList[index].service_provider_details['userId'],
                                                            email: userService.servicesList[index].service_provider_details['email'],
                                                            displayName: userService.servicesList[index].service_provider_details['displayName'],
                                                            serviceId: userService.servicesList[index].serviceId,
                                                            service_name: userService.servicesList[index].service_name,
                                                            description: userService.servicesList[index].description!,
                                                            links: userService.servicesList[index].links,
                                                            service_charge_in_person: userService.servicesList[index].service_charge_in_person!,
                                                            service_charge_virtual: userService.servicesList[index].service_charge_virtual!,
                                                            duration: userService.servicesList[index].duration!,
                                                            date: userService.servicesList[index].date,
                                                            time: userService.servicesList[index].time,
                                                            available_days: userService.servicesList[index].available_days
                                                          );
                                                        },
                                                      child: Icon(
                                                        Icons.more_vert_rounded,
                                                        color: AppColor.bgColor,
                                                        size: 30,
                                                      ),
                                                    ),                                   
                                                  ],
                                                ),
                                
                                              
                                              SizedBox(height: 40.h,),
                                
                                              Text(
                                                userService.servicesList[index].service_name,
                                                style: GoogleFonts.inter(
                                                  color: AppColor.bgColor,
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w600
                                                ),
                                              ),
                                              SizedBox(height: 20.h,),
                                              Text(
                                                "Available from",
                                                style: GoogleFonts.inter(
                                                  color: AppColor.limeGreen,  //AppColor.yellowStar,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w400
                                                ),
                                              ),
                                
                                              SizedBox(height: 20.sp,),
                                
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          "${userService.servicesList[index].available_days}",
                                                          style: GoogleFonts.inter(
                                                            color: AppColor.bgColor,
                                                            fontSize: 14.sp,
                                                            fontWeight: FontWeight.w400
                                                          ),
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                        SizedBox(height: 10.h),
                                                        Text(
                                                          userService.servicesList[index].time,
                                                          style: GoogleFonts.inter(
                                                            color: AppColor.bgColor,
                                                            fontSize: 14.sp,
                                                            fontWeight: FontWeight.w400
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  //price text here
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.end,
                                                      children: [
                                                        Obx(
                                                          () {
                                                            return Text(
                                                              key: Key('price_text_$index'),
                                                              controller.isVirtual.value && controller.selectedIndex.value == index 
                                                              ?"N${userService.servicesList[index].service_charge_virtual}" 
                                                              :"N${userService.servicesList[index].service_charge_in_person}",
                                                              style: GoogleFonts.inter(
                                                                color: AppColor.bgColor,
                                                                fontSize: 20.sp,
                                                                fontWeight: FontWeight.w600
                                                              ),
                                                              overflow: TextOverflow.ellipsis,
                                                            );
                                                          }
                                                        ),
                                                        SizedBox(height: 5.h,),
                                                        //time
                                                        userService.servicesList[index].duration!.isEmpty ?
                                                        Text('')
                                                        :Text(
                                                          "per ${userService.servicesList[index].duration} session",
                                                          style: GoogleFonts.inter(
                                                            color: AppColor.whiteTextColor,
                                                            fontSize: 12.sp,
                                                            fontWeight: FontWeight.w500
                                                          ),
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                                  
                                              SizedBox(height: 30.h,),
                                              Text(
                                                userService.servicesList[index].description!,
                                                style: GoogleFonts.inter(
                                                  color: AppColor.bgColor,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w400
                                                ),
                                              ),
                                              SizedBox(height: 30.h,),
                                              
                                              //link 1
                                              /*InkWell(
                                                onTap: () {},
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
                                                      child: InkWell(
                                                        onTap: () {
                                                          userService.launchUrlLink(link: data[index].links[0]);
                                                        },
                                                        child: Text(
                                                          data[index].links[0],
                                                          style: GoogleFonts.inter(
                                                            color: AppColor.navyBlue,
                                                            fontSize: 12.sp,
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: 20.h,),*/
                                            ]
                                          )
                                        )
                                      ]                           
                                      
                                    ),
                                  );
                                    }
                                    return Container(
                                      //height: 500,
                                      width: double.infinity,
                                      //color: AppColor.bgColor, //index.isEven ? AppColor.lightRed : AppColor.lightPurple,
                                      alignment: Alignment.center,
                                      //padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                      decoration: BoxDecoration(
                                        color: AppColor.navyBlue,
                                        borderRadius: BorderRadius.circular(20.r),
                                        /*border: Border.all(
                                          color: AppColor.darkGreyColor,
                                          width: 1.0,
                                        )*/
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(height: 20.h),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    //check if the account owner selected in-person or virtual
                                                    TogglePriceContainer(index: index,),
                                                    InkWell(
                                                      onTap: () {
                                                        editServiceDialogueBox(
                                                          service_link: userService.servicesList[index].service_link,
                                                          context: context, 
                                                          userId: userService.servicesList[index].service_provider_details['userId'],
                                                          email: userService.servicesList[index].service_provider_details['email'],
                                                          displayName: userService.servicesList[index].service_provider_details['displayName'],
                                                          serviceId: userService.servicesList[index].serviceId,
                                                          service_name: userService.servicesList[index].service_name,
                                                          description: userService.servicesList[index].description!,
                                                          links: userService.servicesList[index].links,
                                                          service_charge_in_person: userService.servicesList[index].service_charge_in_person!,
                                                          service_charge_virtual: userService.servicesList[index].service_charge_virtual!,
                                                          duration: userService.servicesList[index].duration!,
                                                          date: userService.servicesList[index].date,
                                                          time: userService.servicesList[index].time,
                                                          available_days: userService.servicesList[index].available_days
                                                        );
                                                      },
                                                      child: Icon(
                                                        Icons.more_vert_rounded,
                                                        color: AppColor.bgColor,
                                                        size: 30,
                                                      ),
                                                    ),                                   
                                                  ],
                                                ),
                                
                                              
                                              SizedBox(height: 40.h,),
                                
                                              Text(
                                                userService.servicesList[index].service_name,
                                                style: GoogleFonts.inter(
                                                  color: AppColor.bgColor,
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w600
                                                ),
                                              ),
                                              SizedBox(height: 20.h,),
                                              Text(
                                                "Available from",
                                                style: GoogleFonts.inter(
                                                  color: AppColor.yellowStar,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w400
                                                ),
                                              ),
                                
                                              SizedBox(height: 20.sp,),
                                
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          "${userService.servicesList[index].available_days}",
                                                          style: GoogleFonts.inter(
                                                            color: AppColor.bgColor,
                                                            fontSize: 14.sp,
                                                            fontWeight: FontWeight.w400
                                                          ),
                                                        ),
                                                        SizedBox(height: 10.h),
                                                        Text(
                                                          userService.servicesList[index].time,
                                                          style: GoogleFonts.inter(
                                                            color: AppColor.bgColor,
                                                            fontSize: 14.sp,
                                                            fontWeight: FontWeight.w400
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  //price text here
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.end,
                                                      children: [
                                                        Obx(
                                                          () {
                                                            return Text(
                                                              key: Key('price_text_2_$index'),
                                                              controller.isVirtual.value && controller.selectedIndex.value == index 
                                                              ?"N${userService.servicesList[index].service_charge_virtual}" 
                                                              :"N${userService.servicesList[index].service_charge_in_person}",
                                                              style: GoogleFonts.inter(
                                                                color: AppColor.bgColor,
                                                                fontSize: 20.sp,
                                                                fontWeight: FontWeight.w600
                                                              ),
                                                              overflow: TextOverflow.ellipsis,
                                                            );
                                                          }
                                                        ),
                                                        SizedBox(height: 5.h,),
                                                        //time
                                                        userService.servicesList[index].duration!.isEmpty ?
                                                        Text('')
                                                        :Text(
                                                          "per ${userService.servicesList[index].duration} session",
                                                          style: GoogleFonts.inter(
                                                            color: AppColor.whiteTextColor,
                                                            fontSize: 12.sp,
                                                            fontWeight: FontWeight.w500
                                                          ),
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                                  
                                              SizedBox(height: 30.h,),
                                              Text(
                                                userService.servicesList[index].description!,
                                                style: GoogleFonts.inter(
                                                  color: AppColor.bgColor,
                                                  fontSize: 14.sp,
                                                  fontWeight: FontWeight.w400
                                                ),
                                              ),
                                              SizedBox(height: 30.h,),
                                
                                              //link 1
                                              /*InkWell(
                                                onTap: () {},
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
                                                      child: InkWell(
                                                        onTap: () {
                                                          userService.launchUrlLink(link: data[index].links[0]);
                                                        },
                                                        child: Text(
                                                          data[index].links[0],
                                                          style: GoogleFonts.inter(
                                                            color: AppColor.mainColor,
                                                            fontSize: 12.sp,
                                                            fontWeight: FontWeight.w500,
                                                          ),
                                                          overflow: TextOverflow.ellipsis,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              SizedBox(height: 20.h,),*/
                                            ]
                                          )
                                        )
                                      ]                           
                                      
                                    ),
                                  );
                                }
                                ),
                              )
                                              
                              : ServiceEmptyState(
                                  onPressed: () {
                                    Get.to(() => AddServiceScreen());
                                  },
                                );
                        }
                      )
                        
                    
                      
          )
              
        ]
      )
    );
  }
}