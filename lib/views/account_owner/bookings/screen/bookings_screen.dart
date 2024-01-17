import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/bookings/bookings_controller.dart';
import 'package:luround/models/account_owner/user_bookings/user_bookings_response_model.dart';
import 'package:luround/services/account_owner/bookings_service/user_bookings_services.dart';
import 'package:luround/services/account_owner/data_service/local_storage/local_storage.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/converters.dart';
import 'package:luround/utils/components/loader.dart';
import 'package:luround/views/account_owner/bookings/screen/booking_screen_empty_state.dart';
import 'package:luround/views/account_owner/bookings/widget/bottomsheets/bookings_list_bottomsheet.dart';
import 'package:luround/views/account_owner/bookings/widget/filter_section/filter_bottomsheet.dart';
import 'package:luround/views/account_owner/bookings/widget/filter_section/filter_container.dart';
import 'package:luround/views/account_owner/bookings/widget/search_textfield.dart';









class BookingsPage extends StatefulWidget {
  BookingsPage({super.key});

  @override
  State<BookingsPage> createState() => _BookingsPageState();
}

class _BookingsPageState extends State<BookingsPage> {

  var controller = Get.put(BookingsController());
  var service = Get.put(AccOwnerBookingService());
  var userId = LocalStorage.getUserID();


  @override
  void initState() {
    super.initState();

    service.getUserBookings().then((List<DetailsModel> list) {
      service.filteredList.clear();
      service.filteredList.addAll(list);  //service.dataList
      print("initState: ${service.filteredList}");
    });

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.greyColor,
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
                /*Row(
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
                ),*/
                SizedBox(height: 10.h,), //40
                Center(
                  child: Text(
                    "Bookings",
                    style: GoogleFonts.inter(
                      color: AppColor.blackColor,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600
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
              
          
            
          Expanded(
            child: Obx(
              () {              
                return service.isLoading.value ? Loader() : service.filteredList.isNotEmpty ? ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0), //external paddin
                        itemCount: service.filteredList.length, //data.length,
                        separatorBuilder: (context, index) => SizedBox(height: 25.h,),
                        itemBuilder: (context, index) {
      
                          if(service.filteredList.isEmpty) {
                            print("data list is empty fam");
                            return BookingScreenEmptyState(
                              onPressed: () {
                                service.getUserBookings();
                              },
                            );
                          }

                          if(service.filteredList.isNotEmpty){
      
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
                                          mainAxisAlignment: service.filteredList[index].booked_status == "PENDING CONFIRMATION" ? MainAxisAlignment.spaceBetween : MainAxisAlignment.end,
                                          children: [
                                            //confirm bookings button
                                            service.filteredList[index].booked_status == "PENDING CONFIRMATION" ?
                                            InkWell(
                                              onTap: () {
                                                service.confirmBooking(
                                                  context: context, 
                                                  bookingId: service.filteredList[index].id
                                                );
                                              },
                                              child: Container(
                                                height: 40.h,
                                                width: 80.w,
                                                alignment: Alignment.center,
                                                //padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10.r),
                                                  color: AppColor.mainColor,
                                                ),
                                                child: Text(
                                                  "Confirm",
                                                  style: GoogleFonts.inter(
                                                    color: AppColor.bgColor,
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w400
                                                  ),
                                                ),
                                              ),
                                            ) : SizedBox(),

                                            //more vert button
                                            IconButton(
                                              onPressed: () {
                                                bookingsListDialogueBox(
                                                  serviceDate: service.filteredList[index].serviceDetails.date,
                                                  serviceTime: service.filteredList[index].serviceDetails.time,
                                                  serviceDuration: service.filteredList[index].serviceDetails.duration,
                                                  bookingId: service.filteredList[index].id,
                                                  onDelete: () {
                                                    service.deleteBooking(
                                                      context: context, 
                                                      bookingId: service.filteredList[index].id
                                                    ).whenComplete(() => Get.back());
                                                  },
                                                  context: context, 
                                                  serviceName: service.filteredList[index].serviceDetails.serviceName  //.serviceDetails.serviceName,
                                                );
                                              }, 
                                              icon: Icon(
                                                Icons.more_vert_rounded,
                                                color: AppColor.blackColor,
                                              )
                                            )
                                          ],
                                        ),

                                        SizedBox(height: 30.h,),

                                        //beginning
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                            CircleAvatar(
                                              backgroundColor: AppColor.mainColor,
                                              //backgroundImage: ,
                                              radius: 30.r,  //25,
                                              child: Text(
                                                service.filteredList[index].bookingUserInfo.displayName.toUpperCase().substring(0, 1),
                                                style: GoogleFonts.inter(
                                                  color: AppColor.bgColor,
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w600
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 10.w,),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    service.filteredList[index].bookingUserInfo.displayName,
                                                    style: GoogleFonts.inter(
                                                      color: AppColor.darkGreyColor,
                                                      fontSize: 14.sp,
                                                      fontWeight: FontWeight.w600
                                                    ),
                                                  ),
                                                  SizedBox(height: 2.h,),
                                                  Text(
                                                    service.filteredList[index].serviceProviderInfo.userId.contains(userId) ? "you booked" : "booked you",
                                                    //"booked you",//index.isEven ? "booked you" : "you booked",
                                                    style: GoogleFonts.inter(
                                                      color: AppColor.textGreyColor,
                                                      fontSize: 12.sp,
                                                      fontWeight: FontWeight.w500
                                                    ),
                                                  )
                                                ],
                                              )
                                            ),

                                            Text(
                                              service.filteredList[index].booked_status == "PENDING CONFIRMATION" ? "pending" : "confirmed",
                                              style: GoogleFonts.inter(
                                                color: service.filteredList[index].booked_status == "PENDING CONFIRMATION" ? AppColor.yellowStar : AppColor.darkGreen ,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w500
                                              ),
                                            ),

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
                                              service.filteredList[index].serviceDetails.date,
                                              style: GoogleFonts.inter(
                                                color: AppColor.darkGreyColor,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500
                                              ),
                                            ),
                                            SizedBox(width: 10.w,),
                                            /////////////
                                            service.filteredList[index].bookingUserInfo.userId.contains(userId) ?
                                            SvgPicture.asset("assets/svg/sent_blue.svg")
                                            :SvgPicture.asset("assets/svg/received_yellow.svg"),
                                            /////////////////
                                          ],
                                        ),
                                        SizedBox(height: 30.h,),
                                        //service name
                                        Text(
                                          service.filteredList[index].serviceDetails.serviceName,
                                          style: GoogleFonts.inter(
                                            color: AppColor.blackColor,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600
                                          ),
                                        ),
                                        SizedBox(height: 30,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              service.filteredList[index].serviceDetails.time,
                                              style: GoogleFonts.inter(
                                                color: AppColor.blackColor,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400
                                              ),
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                SvgPicture.asset("assets/svg/time_icon.svg"),
                                                SizedBox(width: 10.w,),
                                                Text(
                                                  service.filteredList[index].serviceDetails.duration,
                                                  style: GoogleFonts.inter(
                                                    color: AppColor.textGreyColor,
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.w400
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
                                              style: GoogleFonts.inter(
                                                color: AppColor.blackColor,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500
                                              ),
                                              //maxLines: controller.selectedIndex == index ? null : 1,
                                              //overflow: controller.selectedIndex == index  ? null : TextOverflow.ellipsis,
                                            ),
                                            SizedBox(height: 10.h,),
                                            Text(
                                              service.filteredList[index].bookingUserInfo.email,
                                              style: GoogleFonts.inter(
                                                color: AppColor.darkGreyColor,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400
                                              ),
                                              //maxLines: controller.selectedIndex == index ? null : 1,
                                              //overflow: controller.selectedIndex == index  ? null : TextOverflow.ellipsis,
                                            ),
                                      
                                            SizedBox(height: 30.h,),
                                            Text(
                                              "Meeting Type",
                                              style: GoogleFonts.inter(
                                                color: AppColor.blackColor,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500
                                              ),
                                              //maxLines: controller.selectedIndex == index ? null : 1,
                                              //overflow: controller.selectedIndex == index  ? null : TextOverflow.ellipsis,
                                            ),
                                            SizedBox(height: 10.h,),
                                            Text(
                                              service.filteredList[index].serviceDetails.appointmentType,
                                              style: GoogleFonts.inter(
                                                color: AppColor.darkGreyColor,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400
                                              ),
                                              //maxLines: controller.selectedIndex == index ? null : 1,
                                              //overflow: controller.selectedIndex == index  ? null : TextOverflow.ellipsis,
                                            ),
                                            SizedBox(height: 30.h,),
                                      
                                            Text(
                                              "Location",
                                              style: GoogleFonts.inter(
                                                color: AppColor.blackColor,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500
                                              ),
                                              //maxLines: controller.selectedIndex == index ? null : 1,
                                              //overflow: controller.selectedIndex == index  ? null : TextOverflow.ellipsis,
                                            ),
                                            SizedBox(height: 10.h,),
                                            Text(
                                              service.filteredList[index].serviceDetails.location,
                                              style: GoogleFonts.inter(
                                                color: AppColor.darkGreyColor,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400
                                              ),
                                              //maxLines: controller.selectedIndex == index ? null : 1,
                                              //overflow: controller.selectedIndex == index  ? null : TextOverflow.ellipsis,
                                            ),
                                            SizedBox(height: 30.h,),
                                      
                                            Text(
                                              "Sender's Time Zone",
                                              style: GoogleFonts.inter(
                                                color: AppColor.blackColor,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500
                                              ),
                                              //maxLines: controller.selectedIndex == index ? null : 1,
                                              //overflow: controller.selectedIndex == index  ? null : TextOverflow.ellipsis,
                                            ),
                                            SizedBox(height: 10,),
                                            Text(
                                              "West Africa Time",
                                              style: GoogleFonts.inter(
                                                color: AppColor.darkGreyColor,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400
                                              ),
                                              //maxLines: controller.selectedIndex == index ? null : 1,
                                              //overflow: controller.selectedIndex == index  ? null : TextOverflow.ellipsis,
                                            ),
                                            SizedBox(height: 30.h,),
                                      
                                            Text(
                                              "Note",
                                              style: GoogleFonts.inter(
                                                color: AppColor.blackColor,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500
                                              ),
                                              //maxLines: controller.selectedIndex == index ? null : 1,
                                              //overflow: controller.selectedIndex == index  ? null : TextOverflow.ellipsis,
                                            ),
                                            SizedBox(height: 10.h,),
                                            Text(
                                              service.filteredList[index].serviceDetails.message,
                                              style: GoogleFonts.inter(
                                                color: AppColor.darkGreyColor,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400
                                              ),
                                              //maxLines: controller.selectedIndex == index ? null : 1,
                                              //overflow: controller.selectedIndex == index  ? null : TextOverflow.ellipsis,
                                            ),
                                            SizedBox(height: 30.h,),
                                          
                                            Text(
                                              "Created on ${convertServerTimeToDate(service.filteredList[index].serviceDetails.createdAt)}",
                                              style: GoogleFonts.inter(
                                                color: AppColor.textGreyColor.withOpacity(0.4),
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400
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
                                        style: GoogleFonts.inter(
                                          color: AppColor.mainColor,
                                          fontSize: 16.sp,
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

                          return BookingScreenEmptyState(
                            onPressed: () {
                              service.getUserBookings();
                            },
                          );
                        }
                      ) : BookingScreenEmptyState(
                        onPressed: () {
                          service.getUserBookings();
                        },
                      );
                    }
                  ),
          )
        
        ]
        
      )
    );

  }
}

