import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/bookings_controller.dart';
import 'package:luround/models/account_owner/user_bookings/user_bookings_response_model.dart';
import 'package:luround/services/account_owner/bookings/user_bookings_services.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/converters.dart';
import 'package:luround/utils/components/loader.dart';
import 'package:luround/views/account_owner/bookings/screen/booking_screen_empty_state.dart';
import 'package:luround/views/account_owner/bookings/widget/bottomsheets/bookings_list_bottomsheet.dart';
import 'package:luround/views/account_owner/bookings/widget/filter_section/filter_bottomsheet.dart';
import 'package:luround/views/account_owner/bookings/widget/filter_section/filter_container.dart';
import 'package:luround/views/account_owner/bookings/widget/search_textfield.dart';
import 'package:luround/views/account_owner/profile/widget/notifications/notifications_page.dart';
import 'package:luround/views/account_owner/services/widget/delete_service/delete_service_bottomsheet.dart';










class BookingsPage extends StatefulWidget {
  BookingsPage({super.key});

  @override
  State<BookingsPage> createState() => _BookingsPageState();
}

class _BookingsPageState extends State<BookingsPage> {

  var controller = Get.put(BookingsController());
  var service = Get.put(AccOwnerBookingService());

  @override
  void initState() {
    /*service.getUserBookings().then((value) {
      setState(() {
        service.dataList.value = service.filterBookingsList.value = value;
      });
    });
    print("filtered list: ${service.filterBookingsList}");*/
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.greyColor, //controller.isServicePresent.value ? AppColor.bgColor : AppColor.greyColor,
      body: SafeArea(
        child: Container(
          //physics: NeverScrollableScrollPhysics(),
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
                        Image(
                          image: AssetImage('assets/images/luround_logo.png'),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                Get.to(() => NotificationsPage());
                              },
                              child: SvgPicture.asset("assets/svg/notify_active.svg"),
                            ),
                          ],
                        )
                      ]
                    ),
                    const SizedBox(height: 10,), //40
                    Center(
                      child: Text(
                        "Bookings",
                        style: GoogleFonts.poppins(
                          color: AppColor.blackColor,
                          fontSize: 19.sp,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h,),
                    //search textfield
                    SearchTextField(
                      onFocusChanged: (val) {},
                      onFieldSubmitted: (val) {
                        setState(() {
                          controller.isFieldTapped.value = false;
                          service.filterBookings(val);
                        });
                      },
                      hintText: "Search",
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,  //.search,
                      textController: controller.searchController,
                      onTap: () {
                        setState(() {
                          controller.isFieldTapped.value = true;
                        });
                      },
                    ),
                  ],
                ),
              ),         
              ////////////////////////////////////////////////////////          
        
              SizedBox(height: 5.h,),
              //Filter widget here
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FilterContainer(
                      onTaped: () {
                        filterDialogueBox(
                          context: context,
                          onSentFilter: () {
                            service.filterBySent()
                            .whenComplete(() => Get.back());
                          },
                          onReceivedFilter: () {
                            service.filterByReceived()
                            .whenComplete(() => Get.back());
                          },
                          onUpcomingFilter: () {
                            service.filterByUpcoming()
                            .whenComplete(() => Get.back());
                          },
                          onPastFilter: () {
                            service.filterByPast()
                            .whenComplete(() => Get.back());
                          },
                          onCancelledFilter: () {
                            service.fiterByCancelled()
                            .whenComplete(() => Get.back());
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              //SizedBox(height: 10.h,),
        
              //no booking available widget
              //BookingScreenEmptyState(onPressed: () {},),
        
              FutureBuilder<List<DetailsModel>>(
                future: service.getUserBookings(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Loader();
                  }
                  if (snapshot.hasError) {
                   print(snapshot.error);
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    print("uh--oh! nothing dey;");
                    return BookingScreenEmptyState(
                      onPressed: () {
                        service.getUserBookings();
                      },
                    );
                  }
                  if (snapshot.hasData) {
      
                    //var data = snapshot.data!;
                
                    return Expanded(
                      child: Obx(
                        () {
                    
                          return ListView.separated(
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            physics: const BouncingScrollPhysics(),
                            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0), //external paddin
                            itemCount: service.dataList.length, //data.length,
                            separatorBuilder: (context, index) => SizedBox(height: 25.h,),
                            itemBuilder: (context, index) {

                              /*if(service.dataList.isEmpty) {
                                print("data list is empty fam");
                                return BookingScreenEmptyState(
                                  onPressed: () {
                                    service.getUserBookings();
                                  },
                                );
                              }*/

                              return Container(
                                alignment: Alignment.center,
                                //padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                decoration: BoxDecoration(
                                color: AppColor.bgColor,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColor.textGreyColor.withOpacity(0.2),
                                    blurRadius: 0.2,
                                    //spreadRadius: 0.1,
                                    blurStyle: BlurStyle.solid
                                  )
                                ]
                              ),
                              child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            //more vert icon
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.end,
                                              children: [
                                                IconButton(
                                                  onPressed: () {
                                                    bookingsListDialogueBox(
                                                      serviceDate: service.dataList[index].serviceDetails.date,
                                                      serviceTime: service.dataList[index].serviceDetails.time,
                                                      serviceDuration: service.dataList[index].serviceDetails.duration,
                                                      bookingId: service.dataList[index].id,
                                                      onDelete: () {
                                                        service.deleteBooking(
                                                          context: context, 
                                                          bookingId: service.dataList[index].id
                                                        ).whenComplete(() => Get.back());
                                                      },
                                                      context: context, 
                                                      serviceName: service.dataList[index].serviceDetails.serviceName  //.serviceDetails.serviceName,
                                                    );
                                                  }, 
                                                  icon: Icon(
                                                    Icons.more_vert_rounded,
                                                    color: AppColor.blackColor,
                                                  )
                                                )
                                              ],
                                            ),
                                            SizedBox(height: 5.h,),
                                            //beginning
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                CircleAvatar(
                                                  backgroundColor: AppColor.mainColor,
                                                  //backgroundImage: ,
                                                  radius: 30.r,  //25,
                                                ),
                                                SizedBox(width: 10.w,),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        service.dataList[index].bookingUserInfo.displayName,
                                                        style: GoogleFonts.poppins(
                                                          color: AppColor.darkGreyColor,
                                                          fontSize: 15.sp,
                                                          fontWeight: FontWeight.bold
                                                        ),
                                                      ),
                                                      SizedBox(height: 2.h,),
                                                      Text(
                                                        "booked you",//index.isEven ? "booked you" : "you booked",
                                                        style: GoogleFonts.poppins(
                                                          color: AppColor.textGreyColor,
                                                          fontSize: 15.sp,
                                                          fontWeight: FontWeight.w500
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                )
                                              ],
                                            ),
                                            SizedBox(height: 10.h,),
                                            Divider(color: AppColor.textGreyColor, thickness: 0.3,),                  
                                            SizedBox(height: 10.h,),
                                            //date of booking
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  service.dataList[index].serviceDetails.date,
                                                  style: GoogleFonts.poppins(
                                                    color: AppColor.darkGreyColor,
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w500
                                                  ),
                                                ),
                                                SizedBox(width: 10.w,),
                                                /////////////
                                                index.isEven ?
                                                SvgPicture.asset("assets/svg/sent_blue.svg")
                                                :SvgPicture.asset("assets/svg/received_yellow.svg"),
                                                /////////////////
                                              ],
                                            ),
                                            SizedBox(height: 30.h,),
                                            //service name
                                            Text(
                                              service.dataList[index].serviceDetails.serviceName,
                                              style: GoogleFonts.poppins(
                                                color: AppColor.blackColor,
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.bold
                                              ),
                                            ),
                                            SizedBox(height: 30,),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  service.dataList[index].serviceDetails.time,
                                                  style: GoogleFonts.poppins(
                                                    color: AppColor.blackColor,
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w500
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.start,
                                                  children: [
                                                    SvgPicture.asset("assets/svg/time_icon.svg"),
                                                    SizedBox(width: 10.w,),
                                                    Text(
                                                      service.dataList[index].serviceDetails.duration,
                                                      style: GoogleFonts.poppins(
                                                        color: AppColor.textGreyColor,
                                                        fontSize: 15.sp,
                                                        //fontWeight: FontWeight.w500
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 30.h,),
                                          
                                          
                                            ///////////////////////////////////////
                                            //collapsible and expandibles here,
                                            controller.selectedIndex == index ?
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Sender's Email",
                                                  style: GoogleFonts.poppins(
                                                    color: AppColor.blackColor,
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w500
                                                  ),
                                                  //maxLines: controller.selectedIndex == index ? null : 1,
                                                  //overflow: controller.selectedIndex == index  ? null : TextOverflow.ellipsis,
                                                ),
                                                SizedBox(height: 10.h,),
                                                Text(
                                                  service.dataList[index].bookingUserInfo.email,
                                                  style: GoogleFonts.poppins(
                                                    color: AppColor.darkGreyColor,
                                                    fontSize: 15.sp,
                                                    //fontWeight: FontWeight.w500
                                                  ),
                                                  //maxLines: controller.selectedIndex == index ? null : 1,
                                                  //overflow: controller.selectedIndex == index  ? null : TextOverflow.ellipsis,
                                                ),
                                          
                                                SizedBox(height: 30.h,),
                                                Text(
                                                  "Meeting Type",
                                                  style: GoogleFonts.poppins(
                                                    color: AppColor.blackColor,
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w500
                                                  ),
                                                  //maxLines: controller.selectedIndex == index ? null : 1,
                                                  //overflow: controller.selectedIndex == index  ? null : TextOverflow.ellipsis,
                                                ),
                                                SizedBox(height: 10.h,),
                                                Text(
                                                  service.dataList[index].serviceDetails.appointmentType,
                                                  style: GoogleFonts.poppins(
                                                    color: AppColor.darkGreyColor,
                                                    fontSize: 15.sp,
                                                    //fontWeight: FontWeight.w500
                                                  ),
                                                  //maxLines: controller.selectedIndex == index ? null : 1,
                                                  //overflow: controller.selectedIndex == index  ? null : TextOverflow.ellipsis,
                                                ),
                                                SizedBox(height: 30.h,),
                                          
                                                Text(
                                                  "Location",
                                                  style: GoogleFonts.poppins(
                                                    color: AppColor.blackColor,
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w500
                                                  ),
                                                  //maxLines: controller.selectedIndex == index ? null : 1,
                                                  //overflow: controller.selectedIndex == index  ? null : TextOverflow.ellipsis,
                                                ),
                                                SizedBox(height: 10.h,),
                                                Text(
                                                  service.dataList[index].serviceDetails.location,
                                                  style: GoogleFonts.poppins(
                                                    color: AppColor.darkGreyColor,
                                                    fontSize: 15.sp,
                                                    //fontWeight: FontWeight.w500
                                                  ),
                                                  //maxLines: controller.selectedIndex == index ? null : 1,
                                                  //overflow: controller.selectedIndex == index  ? null : TextOverflow.ellipsis,
                                                ),
                                                SizedBox(height: 30.h,),
                                          
                                                Text(
                                                  "Sender's Time Zone",
                                                  style: GoogleFonts.poppins(
                                                    color: AppColor.blackColor,
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w500
                                                  ),
                                                  //maxLines: controller.selectedIndex == index ? null : 1,
                                                  //overflow: controller.selectedIndex == index  ? null : TextOverflow.ellipsis,
                                                ),
                                                SizedBox(height: 10,),
                                                Text(
                                                  "West Africa Time",
                                                  style: GoogleFonts.poppins(
                                                    color: AppColor.darkGreyColor,
                                                    fontSize: 15.sp,
                                                    //fontWeight: FontWeight.w500
                                                  ),
                                                  //maxLines: controller.selectedIndex == index ? null : 1,
                                                  //overflow: controller.selectedIndex == index  ? null : TextOverflow.ellipsis,
                                                ),
                                                SizedBox(height: 30.h,),
                                          
                                                Text(
                                                  "Note",
                                                  style: GoogleFonts.poppins(
                                                    color: AppColor.blackColor,
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w500
                                                  ),
                                                  //maxLines: controller.selectedIndex == index ? null : 1,
                                                  //overflow: controller.selectedIndex == index  ? null : TextOverflow.ellipsis,
                                                ),
                                                SizedBox(height: 10.h,),
                                                Text(
                                                  service.dataList[index].serviceDetails.message,
                                                  style: GoogleFonts.poppins(
                                                    color: AppColor.darkGreyColor,
                                                    fontSize: 15.sp,
                                                    //fontWeight: FontWeight.w500
                                                  ),
                                                  //maxLines: controller.selectedIndex == index ? null : 1,
                                                  //overflow: controller.selectedIndex == index  ? null : TextOverflow.ellipsis,
                                                ),
                                                SizedBox(height: 30.h,),
                                              
                                                Text(
                                                  "Created on ${convertServerTimeToDate(service.dataList[index].serviceDetails.createdAt)}",
                                                  style: GoogleFonts.poppins(
                                                    color: AppColor.textGreyColor.withOpacity(0.4),
                                                    fontSize: 15.sp,
                                                    //fontWeight: FontWeight.w500
                                                  ),
                                                  //maxLines: controller.selectedIndex == index ? null : 1,
                                                  //overflow: controller.selectedIndex == index  ? null : TextOverflow.ellipsis,
                                                ),
                                                SizedBox(height: 10.h,),
                                              ],
                                            ): SizedBox(),
                                            ///////////////////////////////////////    
                                          
                                          ],
                                        ),
                                      ),
                                      ////////////////////
                                      Divider(color: AppColor.mainColor, thickness: 0.8,),
                                      //see more text button
                                      Center(
                                        child: TextButton(
                                          onPressed: () {
                                            setState(() {
                                              if (controller.selectedIndex == index) {
                                                // Collapse the selected item.
                                                controller.selectedIndex = -1;
                                              } 
                                              else {
                                                // Expand the selected item.
                                                controller.selectedIndex = index; 
                                              }
                                            });
                                          }, 
                                          child: Text(
                                            controller.selectedIndex == index   ? 'See Less' : 'See More',
                                            style: GoogleFonts.poppins(
                                              color: AppColor.mainColor,
                                              fontSize: 17.sp,
                                              fontWeight: FontWeight.w500
                                              //decoration: TextDecoration.underline,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10.h,),
                                      ////////////////////
                                    ],
                                  ),
                                );
                              }
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
              SizedBox(height: 20.h,)
            ]
          ),
        )
      )
    );
  }
}

