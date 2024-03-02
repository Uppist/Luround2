import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/services/services_controller.dart';
import 'package:luround/models/account_owner/user_services/user_service_response_model.dart';
import 'package:luround/services/account_owner/services/user_services._service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/loader.dart';
import 'package:luround/views/account_owner/profile/widget/notifications/notifications_page.dart';
import 'package:luround/views/account_owner/services/screen/service_empty_state.dart';
import 'package:luround/views/account_owner/services/widget/add_service/screen/add_service_screen.dart';
import 'package:luround/views/account_owner/services/widget/edit_service/edit_service_bottomsheet.dart';
import 'package:luround/views/account_owner/services/widget/toggle_service_price_container/toggle_price.dart';
import '../../../../services/account_owner/data_service/local_storage/local_storage.dart';









class ServicesPage extends StatefulWidget {
  ServicesPage({super.key});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {

  var controller = Get.put(ServicesController());
  final AccOwnerServicePageService userService = Get.put(AccOwnerServicePageService());

  //var data = <UserServiceModel>[].obs;

  // GlobalKey for RefreshIndicator
  /*final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();
  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 1));
    // Fetch new data here
    final List<UserServiceModel>  newData = await userService.getUserServices();
    // Update the UI with the new data
    data.clear();
    data(newData);
    print('updated service list: $data');
  }*/
  
  final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();
  Future<void> _refreshSS() async {
    await Future.delayed(Duration(seconds: 1));
    // Fetch new data here
    final List<UserServiceModel>  newData = (userService.getUserServicesSocket()) as List<UserServiceModel>;
    // Update the UI with the new data
    userService.servicesList.clear();
    userService.servicesList.addAll(newData);
    print('updated service list: ${userService.servicesList}');
  }



  late Stream<List<UserServiceModel>> userServiceStream;
  //late Future<List<UserServiceModel>> userServiceFuture;
  @override
  void initState() {
    super.initState();
    //_refresh();
    //userServiceFuture = userService.getUserServices();
    userServiceStream = userService.getUserServicesSocket();
  }

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
          StreamBuilder<List<UserServiceModel>>(
            stream: userServiceStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Expanded(child: Loader());
              }
              if (snapshot.hasError) {
                debugPrint("${snapshot.error}");
              }
              if (!snapshot.hasData) {
                print("sn-trace: ${snapshot.stackTrace}");
                print("sn-data: ${snapshot.data}");
                return Expanded(
                  child: SingleChildScrollView(
                    child: ServiceEmptyState(
                      onPressed: () {
                        Get.to(() => AddServiceScreen());
                      },
                    ),
                  ),
                );
              } 
                 
              //[Do this if anything sups]//
              if (snapshot.hasData) {
            
                final item = snapshot.data!;
                var data = userService.servicesList;
      
                //sort the resulting list by name
                data.clear();
                data.addAll(item); 
                print("sorted data service list: $data");
            
                return Expanded(
                  child: Obx(
                    () {
                      return data.isNotEmpty ? RefreshIndicator.adaptive(
                        color: AppColor.greyColor,
                        backgroundColor: AppColor.mainColor,
                        key: _refreshKey,
                        onRefresh: () {
                          return _refreshSS();
                        },
                        child: ListView.separated(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0), //external paddin
                          itemCount: data.length,
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
                                                    service_link: data[index].service_link,
                                                    context: context, 
                                                    userId: data[index].service_provider_details['userId'],
                                                    email: data[index].service_provider_details['email'],
                                                    displayName: data[index].service_provider_details['displayName'],
                                                    serviceId: data[index].serviceId,
                                                    service_name: data[index].service_name,
                                                    description: data[index].description!,
                                                    links: data[index].links,
                                                    service_charge_in_person: data[index].service_charge_in_person!,
                                                    service_charge_virtual: data[index].service_charge_virtual!,
                                                    duration: data[index].duration!,
                                                    date: data[index].date,
                                                    time: data[index].time,
                                                    available_days: data[index].available_days
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
                                        data[index].service_name,
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
                                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                                SizedBox(height: 10.h),
                                                Text(
                                                  data[index].time,
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
                                                      controller.isVirtual.value && controller.selectedIndex.value == index 
                                                      ?"N${data[index].service_charge_virtual}" 
                                                      :"N${data[index].service_charge_in_person}",
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
                                                data[index].duration!.isEmpty ?
                                                Text('')
                                                :Text(
                                                  "per ${data[index].duration} session",
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
                                        data[index].description!,
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
                                                  service_link: data[index].service_link,
                                                  context: context, 
                                                  userId: data[index].service_provider_details['userId'],
                                                  email: data[index].service_provider_details['email'],
                                                  displayName: data[index].service_provider_details['displayName'],
                                                  serviceId: data[index].serviceId,
                                                  service_name: data[index].service_name,
                                                  description: data[index].description!,
                                                  links: data[index].links,
                                                  service_charge_in_person: data[index].service_charge_in_person!,
                                                  service_charge_virtual: data[index].service_charge_virtual!,
                                                  duration: data[index].duration!,
                                                  date: data[index].date,
                                                  time: data[index].time,
                                                  available_days: data[index].available_days
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
                                        data[index].service_name,
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
                                                  "${data[index].available_days}",
                                                  style: GoogleFonts.inter(
                                                    color: AppColor.bgColor,
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w400
                                                  ),
                                                ),
                                                SizedBox(height: 10.h),
                                                Text(
                                                  data[index].time,
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
                                                      controller.isVirtual.value && controller.selectedIndex.value == index 
                                                      ?"N${data[index].service_charge_virtual}" 
                                                      :"N${data[index].service_charge_in_person}",
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
                                                data[index].duration!.isEmpty ?
                                                Text('')
                                                :Text(
                                                  "per ${data[index].duration} session",
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
                                        data[index].description!,
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
          SizedBox(height: 20.h,)           
        
        ]
      )
    );
  }
}