import 'dart:convert';

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
import 'package:luround/utils/components/pull_to_refresh.dart';
import 'package:luround/views/account_owner/bookings/screen/booking_screen_empty_state.dart';
import 'package:luround/views/account_owner/bookings/screen/see_proof_of_payment_screen.dart';
import 'package:luround/views/account_owner/bookings/widget/bottomsheets/bookings_list_bottomsheet.dart';
import 'package:luround/views/account_owner/bookings/widget/filter_section/filter_bottomsheet.dart';
import 'package:luround/views/account_owner/bookings/widget/filter_section/filter_container.dart';
import 'package:luround/views/account_owner/bookings/widget/search_textfield.dart';
import 'package:smartrefresh/smartrefresh.dart';









class BookingsPage extends StatefulWidget {
  BookingsPage({super.key});

  @override
  State<BookingsPage> createState() => _BookingsPageState();
}

class _BookingsPageState extends State<BookingsPage> {


  var controller = Get.put(BookingsController());
  var service = Get.put(AccOwnerBookingService());
  var userId = LocalStorage.getUserID();

  // GlobalKey for RefreshIndicator
  final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();
  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 1));
    // Fetch new data here
    final List<DetailsModel> newData = await service.getUserBookings();
    // Update the UI with the new data
    service.filteredList.clear();
    service.filteredList.addAll(newData);
    print('updated bookings list: ${service.filteredList}');
  }


  /*final GlobalKey<RefreshIndicatorState> _refreshKey = GlobalKey<RefreshIndicatorState>();
  Future<void> _refreshSS() async {
    await Future.delayed(Duration(seconds: 1));
    // Fetch new data here
    final List<DetailsModel>  newData = (service.getUserBookingsSocket()) as List<DetailsModel>;
    // Update the UI with the new data
    // Update the UI with the new data
    service.filteredList.clear();
    service.filteredList.addAll(newData);
    print('updated service list: ${service.filteredList}');
  }*/


  late Future<List<DetailsModel>> userBookingFuture;
  //late Stream<List<DetailsModel>> userBookingStream;
  @override
  void initState() {
    super.initState();
 
    userBookingFuture = service.getUserBookings();
    //userBookingStream = service.getUserBookingsSocket();

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
                    service.filterBookings(val);
                  },
                  hintText: "Search",
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.done,  //.search,
                  textController: controller.searchController,
                  onTap: () {},
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
                  /*onTaped: () {
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
                  },*/
                ),
              ],
            ),
          ),
          //SizedBox(height: 10.h,),


            FutureBuilder<List<DetailsModel>>(
              future: userBookingFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Expanded(child: Loader(),);
                }
                if (snapshot.hasError) {
                  print(snapshot.error);
                  return BookingScreenEmptyState(onPressed: () {service.getUserBookings();},);
                }
              
                if (!snapshot.hasData) {
                  print("sn-trace: ${snapshot.stackTrace}");
                  print("sn-error: ${snapshot.error}");
            
                  return BookingScreenEmptyState(onPressed: () {service.getUserBookings();},);
                }
                   
                if (snapshot.hasData) {

                  var data = snapshot.data!;
                  service.filteredList.clear();
                  service.filteredList.addAll(data); 
                  //print("sorted data booking list: $data");
                  print("filtered booking list: ${service.filteredList}");
              
                  return Obx(
                    () {
                      return service.filteredList.isNotEmpty ? Expanded(
                        child: 
                              RefreshIndicator.adaptive(
                              color: AppColor.greyColor,
                              backgroundColor: AppColor.mainColor,
                              key: _refreshKey,
                              onRefresh: () {
                                return _refresh();
                              },
                              child: ListView.separated(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                physics: BouncingScrollPhysics(),
                                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0), //external paddin
                                itemCount: service.filteredList.length,
                                separatorBuilder: (context, index) => SizedBox(height: 25.h,),
                                itemBuilder: (context, index) { 
                                        
                                  //final item = data[index];
                                  final item = service.filteredList[index];
                              
                                  if(service.filteredList.isNotEmpty){
                                    if(controller.selectedIndex == index) {
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
                                                        mainAxisAlignment: item.booked_status == "PENDING CONFIRMATION" ? MainAxisAlignment.spaceBetween : MainAxisAlignment.end,
                                                        children: [
                                                          //confirm bookings button
                                                          item.booked_status == "PENDING CONFIRMATION" ?
                                                          InkWell(
                                                            onTap: () {
                                                              service.confirmBooking(
                                                                context: context, 
                                                                bookingId: service.filteredList[index].id,
                                                                client_name: item.bookingUserInfo.displayName,
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
                                                                service: service,
                                                                serviceDate: item.serviceDetails.date,
                                                                serviceTime: item.serviceDetails.time,
                                                                serviceDuration: item.serviceDetails.duration,
                                                                bookingId: item.id,
                                                                onDelete: () {
                                                                  service.deleteBooking(
                                                                    context: context, 
                                                                    bookingId: item.id
                                                                  ).whenComplete(() => Get.back());
                                                                },
                                                                context: context, 
                                                                serviceName: item.serviceDetails.serviceName,
                                                                client_name: item.bookingUserInfo.displayName,
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
                                                            backgroundColor: AppColor.greyColor,
                                                            //backgroundImage: ,
                                                            radius: 30.r,  //25,
                                                            child: Text(
                                                              //"",
                                                              item.bookingUserInfo.displayName.toUpperCase().substring(0, 1), //.toUpperCase().substring(0, 1),
                                                              style: GoogleFonts.inter(
                                                                color: AppColor.darkGreyColor,
                                                                fontSize: 14.sp,
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
                                                                  item.bookingUserInfo.displayName,
                                                                  style: GoogleFonts.inter(
                                                                    color: AppColor.darkGreyColor,
                                                                    fontSize: 14.sp,
                                                                    fontWeight: FontWeight.w600
                                                                  ),
                                                                ),
                                                                SizedBox(height: 2.h,),
                                                                Text(
                                                                  item.serviceProviderInfo.userId.contains(userId) ? "booked you" : "you booked",
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
                                                            item.booked_status == "PENDING CONFIRMATION" ? "pending" : item.booked_status == "CANCELLED" ? "cancelled" : "confirmed",
                                                            style: GoogleFonts.inter(
                                                              color: item.booked_status == "PENDING CONFIRMATION" ? AppColor.yellowStar : item.booked_status == "CANCELLED" ? AppColor.redColor : AppColor.darkGreen ,
                                                              fontSize: 12.sp,
                                                              fontWeight: FontWeight.w500
                                                            ),
                                                          ),
                                      
                                                        ],
                                                      ),
                                                      SizedBox(height: 10.h,),
                                                      Divider(color: AppColor.textGreyColor, thickness: 0.3,),                  
                                                      SizedBox(height: 10.h,),
                                      
                                                      //see proof of payment
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                        children: [
                                                          InkWell(
                                                            onTap: () {
                                                              Get.to(() => SeePaymentProofPage(
                                                                payment_proof: item.proof_of_payment,
                                                              ));
                                                            },
                                                            child: Text(
                                                              "see proof of payment",
                                                              style: GoogleFonts.inter(
                                                                color: AppColor.darkGreyColor,
                                                                fontSize: 12.sp,
                                                                fontWeight: FontWeight.w500,
                                                                fontStyle: FontStyle.italic,
                                                                decoration: TextDecoration.underline,
                                                                decorationColor: AppColor.darkGreyColor
                                                              )
                                                            ),
                                                          ),
                                                        ]
                                                      ),
                                      
                                                      SizedBox(height: 30.h,),
                                      
                                                      //service name
                                                      Text(
                                                        item.serviceDetails.serviceName,
                                                        style: GoogleFonts.inter(
                                                          color: AppColor.blackColor,
                                                          fontSize: 16.sp,
                                                          fontWeight: FontWeight.w600
                                                        ),
                                                      ),
                                      
                                                      SizedBox(height: 30.h,),
                                                      Text(
                                                        "Booking Details",
                                                        style: GoogleFonts.inter(
                                                          color: AppColor.blackColor,
                                                          fontSize: 14.sp,
                                                          fontWeight: FontWeight.w500,
                                                          decoration: TextDecoration.underline,
                                                          decorationColor: AppColor.blackColor
                                                        ),
                                                      ),
                                      
                                                      SizedBox(height: 30.h),
                                                      Text(
                                                        "Appointment Date",
                                                        style: GoogleFonts.inter(
                                                          color: AppColor.darkGreyColor,
                                                          fontSize: 14.sp,
                                                          fontWeight: FontWeight.w400
                                                        ),
                                                      ),
                                                      SizedBox(height: 10.h),
                                                      Text(
                                                        item.serviceDetails.date,
                                                        style: GoogleFonts.inter(
                                                          color: AppColor.blackColor,
                                                          fontSize: 14.sp,
                                                          fontWeight: FontWeight.w500
                                                        ),
                                                      ),
                                      
                                                      SizedBox(height: 30.h),
                                                      Text(
                                                        "Appointment Time",
                                                        style: GoogleFonts.inter(
                                                          color: AppColor.darkGreyColor,
                                                          fontSize: 14.sp,
                                                          fontWeight: FontWeight.w400
                                                        ),
                                                      ),
                                                      SizedBox(height: 10.h),
                                                      Text(
                                                        item.serviceDetails.time,
                                                        style: GoogleFonts.inter(
                                                          color: AppColor.blackColor,
                                                          fontSize: 14.sp,
                                                          fontWeight: FontWeight.w500
                                                        ),
                                                      ),
                                                      SizedBox(height: 5.h),
                                                      Text(
                                                        "West African Standard Time",
                                                        style: GoogleFonts.inter(
                                                          color: AppColor.darkGreyColor.withOpacity(0.4),
                                                          fontSize: 12.sp,
                                                          fontWeight: FontWeight.w500
                                                        ),
                                                      ),
                                      
                                                      SizedBox(height: 30.h),
                                                      Text(
                                                        "Duration",
                                                        style: GoogleFonts.inter(
                                                          color: AppColor.darkGreyColor,
                                                          fontSize: 14.sp,
                                                          fontWeight: FontWeight.w400
                                                        ),
                                                      ),
                                                      SizedBox(height: 10.h),
                                                      Text(
                                                        item.serviceDetails.duration,
                                                        style: GoogleFonts.inter(
                                                          color: AppColor.blackColor,
                                                          fontSize: 14.sp,
                                                          fontWeight: FontWeight.w500
                                                        ),
                                                      ),
                                      
                                                      SizedBox(height: 30.h),
                                                      Text(
                                                        "Appointment Type",
                                                        style: GoogleFonts.inter(
                                                          color: AppColor.darkGreyColor,
                                                          fontSize: 14.sp,
                                                          fontWeight: FontWeight.w400
                                                        ),
                                                      ),
                                                      SizedBox(height: 10.h),
                                                      Text(
                                                        item.serviceDetails.appointmentType,
                                                        style: GoogleFonts.inter(
                                                          color: AppColor.blackColor,
                                                          fontSize: 14.sp,
                                                          fontWeight: FontWeight.w500
                                                        ),
                                                      ),
                                      
                                                      SizedBox(height: 30.h),
                                                      Text(
                                                        "Location",
                                                        style: GoogleFonts.inter(
                                                          color: AppColor.darkGreyColor,
                                                          fontSize: 14.sp,
                                                          fontWeight: FontWeight.w400
                                                        ),
                                                      ),
                                                      SizedBox(height: 10.h),
                                                      Text(
                                                        item.serviceDetails.location,
                                                        style: GoogleFonts.inter(
                                                          color: AppColor.blackColor,
                                                          fontSize: 14.sp,
                                                          fontWeight: FontWeight.w500
                                                        ),
                                                      ),
                                      
                                      
                                                      SizedBox(height: 30.h),
                                                      Text(
                                                        "Amount Received",
                                                        style: GoogleFonts.inter(
                                                          color: AppColor.darkGreyColor,
                                                          fontSize: 14.sp,
                                                          fontWeight: FontWeight.w400
                                                        ),
                                                      ),
                                                      SizedBox(height: 10.h),
                                                      Text(
                                                        "N${item.serviceDetails.serviceFee}",
                                                        style: GoogleFonts.inter(
                                                          color: AppColor.blackColor,
                                                          fontSize: 14.sp,
                                                          fontWeight: FontWeight.w500
                                                        ),
                                                      ),
                                      
                                      
                                                      SizedBox(height: 30.h),
                                                      Text(
                                                        "Sender's Email",
                                                        style: GoogleFonts.inter(
                                                          color: AppColor.darkGreyColor,
                                                          fontSize: 14.sp,
                                                          fontWeight: FontWeight.w400
                                                        ),
                                                      ),
                                                      SizedBox(height: 10.h),
                                                      Text(
                                                        item.bookingUserInfo.email,
                                                        style: GoogleFonts.inter(
                                                          color: AppColor.blackColor,
                                                          fontSize: 14.sp,
                                                          fontWeight: FontWeight.w500
                                                        ),
                                                      ),
                                      
                                                      SizedBox(height: 30.h),
                                                      Text(
                                                        "Note",
                                                        style: GoogleFonts.inter(
                                                          color: AppColor.blackColor,
                                                          fontSize: 14.sp,
                                                          fontWeight: FontWeight.w500
                                                        )
                                                      ),
                                                      SizedBox(height: 10.h),
                                                      Text(
                                                        item.serviceDetails.message,
                                                        style: GoogleFonts.inter(
                                                          color: AppColor.darkGreyColor,
                                                          fontSize: 14.sp,
                                                          fontWeight: FontWeight.w400
                                                        ),
                                                      ),
                                      
                                                      SizedBox(height: 30.h),
                                                      Text(
                                                        "This Booking was made on",
                                                        style: GoogleFonts.inter(
                                                          color: AppColor.darkGreyColor,
                                                          //fontStyle: FontStyle.italic,
                                                          fontSize: 14.sp,
                                                          fontWeight: FontWeight.w400
                                                        ),
                                                      ),
                                                      SizedBox(height: 10.h),
                                                      Text(
                                                        convertServerTimeToDate(item.serviceDetails.createdAt),
                                                        style: GoogleFonts.inter(
                                                          color: AppColor.darkGreyColor.withOpacity(0.5),
                                                          fontSize: 14.sp,
                                                          fontWeight: FontWeight.normal
                                                        ),
                                                      )
                                                      ///////////////////////////////////////    
                                                    
                                                    ],
                                                  ),
                                                ),
                                                ////////////////////
                                                Divider(color: AppColor.darkGreyColor.withOpacity(0.5), thickness: 0.5,),
                                      
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
                                                        fontSize: 14.sp,
                                                        fontWeight: FontWeight.w600
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
                                    else {
                                        
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
                                                    mainAxisAlignment: item.booked_status == "PENDING CONFIRMATION" ? MainAxisAlignment.spaceBetween : MainAxisAlignment.end,
                                                    children: [
                                                      //confirm bookings button
                                                      item.booked_status == "PENDING CONFIRMATION" ?
                                                      InkWell(
                                                        onTap: () {
                                                          service.confirmBooking(
                                                            context: context, 
                                                            bookingId: item.id,
                                                            client_name: item.bookingUserInfo.displayName,
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
                                                            service: service,
                                                            serviceDate: item.serviceDetails.date,
                                                            serviceTime: item.serviceDetails.time,
                                                            serviceDuration: item.serviceDetails.duration,
                                                            bookingId: item.id,
                                                            onDelete: () {
                                                              service.deleteBooking(
                                                                context: context, 
                                                                bookingId: item.id
                                                              ).whenComplete(() => Get.back());
                                                            },
                                                            context: context, 
                                                            serviceName: item.serviceDetails.serviceName,
                                                            client_name: item.bookingUserInfo.displayName,
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
                                                            backgroundColor: AppColor.greyColor,
                                                            //backgroundImage: ,
                                                            radius: 30.r,  //25,
                                                            child: Text(
                                                              item.bookingUserInfo.displayName.toUpperCase().substring(0, 1),
                                                              style: GoogleFonts.inter(
                                                                color: AppColor.darkGreyColor,
                                                                fontSize: 14.sp,
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
                                                                  item.bookingUserInfo.displayName,
                                                                  style: GoogleFonts.inter(
                                                                    color: AppColor.darkGreyColor,
                                                                    fontSize: 14.sp,
                                                                    fontWeight: FontWeight.w600
                                                                  ),
                                                                ),
                                                                SizedBox(height: 2.h,),
                                                                Text(
                                                                  item.serviceProviderInfo.userId.contains(userId) ? "booked you" : "you booked",
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
                                                            item.booked_status == "PENDING CONFIRMATION" ? "pending" : item.booked_status == "CANCELLED" ? "cancelled" : "confirmed",
                                                            style: GoogleFonts.inter(
                                                              color: item.booked_status == "PENDING CONFIRMATION" ? AppColor.yellowStar : item.booked_status == "CANCELLED" ? AppColor.redColor : AppColor.darkGreen ,
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
                                                            item.serviceDetails.date,
                                                            style: GoogleFonts.inter(
                                                              color: AppColor.darkGreyColor,
                                                              fontSize: 14.sp,
                                                              fontWeight: FontWeight.w500
                                                            ),
                                                          ),
                                                          SizedBox(width: 10.w,),
                                                          /////////////
                                                          item.bookingUserInfo.userId.contains(userId) ?
                                                          SvgPicture.asset("assets/svg/sent_blue.svg")
                                                          :SvgPicture.asset("assets/svg/received_yellow.svg")
                                                          /////////////////
                                                        ],
                                                      ),
                                                      SizedBox(height: 30.h,),
                                                      //service name
                                                      Text(
                                                        item.serviceDetails.serviceName,
                                                        style: GoogleFonts.inter(
                                                          color: AppColor.blackColor,
                                                          fontSize: 16.sp,
                                                          fontWeight: FontWeight.w600
                                                        ),
                                                      ),
                                                      SizedBox(height: 30.h,),
                                                      //service time and duration
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Text(
                                                            item.serviceDetails.time,
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
                                                                item.serviceDetails.duration,
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
                                      
                                                  //see proof of payment
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          Get.to(() => SeePaymentProofPage(
                                                            payment_proof: item.proof_of_payment,
                                                          ));
                                                        },
                                                        child: Text(
                                                          "see proof of payment",
                                                          style: GoogleFonts.inter(
                                                            color: AppColor.darkGreyColor,
                                                            fontSize: 12.sp,
                                                            fontStyle: FontStyle.italic,
                                                            fontWeight: FontWeight.w500,
                                                            decoration: TextDecoration.underline,
                                                            decorationColor: AppColor.darkGreyColor
                                                          )
                                                        ),
                                                      ),
                                                    ]
                                                  ),
                                      
                                                ]
                                              )
                                            ),
                                            ////////////////////
                                               
                                      
                                            Divider(color: AppColor.darkGreyColor.withOpacity(0.5), thickness: 0.5,),
                                      
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
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w600
                                                    //decoration: TextDecoration.underline,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 10.h,),
                                          ]
                                        )
                                      );
                                        
                                    }
                                        
                                  }
                                        
                                  return BookingScreenEmptyState(
                                    onPressed: () {
                                      service.getUserBookings();
                                    },
                                  );
                                }
                              ),
                            ) 
                            //: BookingScreenEmptyState(onPressed: () {},);
                          
                      
                      ) : BookingScreenEmptyState(onPressed: () {},);
                    }
                  );
                }
                return BookingScreenEmptyState(onPressed: () {},);
              }
            ),
              
          
            
          /*Expanded(
            child: Obx(
              () {              
                return service.isLoading.value ? Loader() : service.filteredList.isNotEmpty ? ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0), //external paddin
                  itemCount: service.filteredList.length,
                  separatorBuilder: (context, index) => SizedBox(height: 25.h,),
                  itemBuilder: (context, index) {

                    final item = service.filteredList[index];
                     
                    if(service.filteredList.isEmpty) {
                      print("data list is empty fam");
                      return BookingScreenEmptyState(
                        onPressed: () {
                          service.getUserBookings();
                        },
                      );
                    }

                    if(service.filteredList.isNotEmpty){
                      if(controller.selectedIndex == index) {
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
                                          mainAxisAlignment: item.booked_status == "PENDING CONFIRMATION" ? MainAxisAlignment.spaceBetween : MainAxisAlignment.end,
                                          children: [
                                            //confirm bookings button
                                            item.booked_status == "PENDING CONFIRMATION" ?
                                            InkWell(
                                              onTap: () {
                                                service.confirmBooking(
                                                  context: context, 
                                                  bookingId: service.filteredList[index].id,
                                                  client_name: item.bookingUserInfo.displayName,
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
                                                  service: service,
                                                  serviceDate: item.serviceDetails.date,
                                                  serviceTime: item.serviceDetails.time,
                                                  serviceDuration: item.serviceDetails.duration,
                                                  bookingId: item.id,
                                                  onDelete: () {
                                                    service.deleteBooking(
                                                      context: context, 
                                                      bookingId: item.id
                                                    ).whenComplete(() => Get.back());
                                                  },
                                                  context: context, 
                                                  serviceName: item.serviceDetails.serviceName,
                                                  client_name: item.bookingUserInfo.displayName,
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
                                              backgroundColor: AppColor.greyColor,
                                              //backgroundImage: ,
                                              radius: 30.r,  //25,
                                              child: Text(
                                                //"",
                                                item.bookingUserInfo.displayName.toUpperCase().substring(0, 1), //.toUpperCase().substring(0, 1),
                                                style: GoogleFonts.inter(
                                                  color: AppColor.darkGreyColor,
                                                  fontSize: 14.sp,
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
                                                    item.bookingUserInfo.displayName,
                                                    style: GoogleFonts.inter(
                                                      color: AppColor.darkGreyColor,
                                                      fontSize: 14.sp,
                                                      fontWeight: FontWeight.w600
                                                    ),
                                                  ),
                                                  SizedBox(height: 2.h,),
                                                  Text(
                                                    item.serviceProviderInfo.userId.contains(userId) ? "booked you" : "you booked",
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
                                              item.booked_status == "PENDING CONFIRMATION" ? "pending" : item.booked_status == "CANCELLED" ? "cancelled" : "confirmed",
                                              style: GoogleFonts.inter(
                                                color: item.booked_status == "PENDING CONFIRMATION" ? AppColor.yellowStar : item.booked_status == "CANCELLED" ? AppColor.redColor : AppColor.darkGreen ,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w500
                                              ),
                                            ),

                                          ],
                                        ),
                                        SizedBox(height: 10.h,),
                                        Divider(color: AppColor.textGreyColor, thickness: 0.3,),                  
                                        SizedBox(height: 10.h,),

                                        //see proof of payment
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Get.to(() => SeePaymentProofPage(
                                                  payment_proof: item.proof_of_payment,
                                                ));
                                              },
                                              child: Text(
                                                "see proof of payment",
                                                style: GoogleFonts.inter(
                                                  color: AppColor.darkGreyColor,
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w500,
                                                  fontStyle: FontStyle.italic,
                                                  decoration: TextDecoration.underline,
                                                  decorationColor: AppColor.darkGreyColor
                                                )
                                              ),
                                            ),
                                          ]
                                        ),

                                        SizedBox(height: 30.h,),

                                        //service name
                                        Text(
                                          item.serviceDetails.serviceName,
                                          style: GoogleFonts.inter(
                                            color: AppColor.blackColor,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600
                                          ),
                                        ),

                                        SizedBox(height: 30.h,),
                                        Text(
                                          "Booking Details",
                                          style: GoogleFonts.inter(
                                            color: AppColor.blackColor,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500,
                                            decoration: TextDecoration.underline,
                                            decorationColor: AppColor.blackColor
                                          ),
                                        ),

                                        SizedBox(height: 30.h),
                                        Text(
                                          "Appointment Date",
                                          style: GoogleFonts.inter(
                                            color: AppColor.darkGreyColor,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400
                                          ),
                                        ),
                                        SizedBox(height: 10.h),
                                        Text(
                                          item.serviceDetails.date,
                                          style: GoogleFonts.inter(
                                            color: AppColor.blackColor,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500
                                          ),
                                        ),

                                        SizedBox(height: 30.h),
                                        Text(
                                          "Appointment Time",
                                          style: GoogleFonts.inter(
                                            color: AppColor.darkGreyColor,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400
                                          ),
                                        ),
                                        SizedBox(height: 10.h),
                                        Text(
                                          item.serviceDetails.time,
                                          style: GoogleFonts.inter(
                                            color: AppColor.blackColor,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500
                                          ),
                                        ),
                                        SizedBox(height: 5.h),
                                        Text(
                                          "West African Standard Time",
                                          style: GoogleFonts.inter(
                                            color: AppColor.darkGreyColor.withOpacity(0.4),
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w500
                                          ),
                                        ),

                                        SizedBox(height: 30.h),
                                        Text(
                                          "Duration",
                                          style: GoogleFonts.inter(
                                            color: AppColor.darkGreyColor,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400
                                          ),
                                        ),
                                        SizedBox(height: 10.h),
                                        Text(
                                          item.serviceDetails.duration,
                                          style: GoogleFonts.inter(
                                            color: AppColor.blackColor,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500
                                          ),
                                        ),

                                        SizedBox(height: 30.h),
                                        Text(
                                          "Appointment Type",
                                          style: GoogleFonts.inter(
                                            color: AppColor.darkGreyColor,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400
                                          ),
                                        ),
                                        SizedBox(height: 10.h),
                                        Text(
                                          item.serviceDetails.appointmentType,
                                          style: GoogleFonts.inter(
                                            color: AppColor.blackColor,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500
                                          ),
                                        ),

                                        SizedBox(height: 30.h),
                                        Text(
                                          "Location",
                                          style: GoogleFonts.inter(
                                            color: AppColor.darkGreyColor,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400
                                          ),
                                        ),
                                        SizedBox(height: 10.h),
                                        Text(
                                          item.serviceDetails.location,
                                          style: GoogleFonts.inter(
                                            color: AppColor.blackColor,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500
                                          ),
                                        ),


                                        SizedBox(height: 30.h),
                                        Text(
                                          "Amount Received",
                                          style: GoogleFonts.inter(
                                            color: AppColor.darkGreyColor,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400
                                          ),
                                        ),
                                        SizedBox(height: 10.h),
                                        Text(
                                          "N${item.serviceDetails.serviceFee}",
                                          style: GoogleFonts.inter(
                                            color: AppColor.blackColor,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500
                                          ),
                                        ),


                                        SizedBox(height: 30.h),
                                        Text(
                                          "Sender's Email",
                                          style: GoogleFonts.inter(
                                            color: AppColor.darkGreyColor,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400
                                          ),
                                        ),
                                        SizedBox(height: 10.h),
                                        Text(
                                          item.bookingUserInfo.email,
                                          style: GoogleFonts.inter(
                                            color: AppColor.blackColor,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500
                                          ),
                                        ),

                                        SizedBox(height: 30.h),
                                        Text(
                                          "Note",
                                          style: GoogleFonts.inter(
                                            color: AppColor.blackColor,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500
                                          )
                                        ),
                                        SizedBox(height: 10.h),
                                        Text(
                                          item.serviceDetails.message,
                                          style: GoogleFonts.inter(
                                            color: AppColor.darkGreyColor,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400
                                          ),
                                        ),

                                        SizedBox(height: 30.h),
                                        Text(
                                          "This Booking was made on",
                                          style: GoogleFonts.inter(
                                            color: AppColor.darkGreyColor,
                                            //fontStyle: FontStyle.italic,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w400
                                          ),
                                        ),
                                        SizedBox(height: 10.h),
                                        Text(
                                          convertServerTimeToDate(item.serviceDetails.createdAt),
                                          style: GoogleFonts.inter(
                                            color: AppColor.darkGreyColor.withOpacity(0.5),
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.normal
                                          ),
                                        )
                                        ///////////////////////////////////////    
                                      
                                      ],
                                    ),
                                  ),
                                  ////////////////////
                                  Divider(color: AppColor.darkGreyColor.withOpacity(0.5), thickness: 0.5,),

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
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600
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
                      else {

                        //show the half view here
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
                                      mainAxisAlignment: item.booked_status == "PENDING CONFIRMATION" ? MainAxisAlignment.spaceBetween : MainAxisAlignment.end,
                                      children: [
                                        //confirm bookings button
                                        item.booked_status == "PENDING CONFIRMATION" ?
                                        InkWell(
                                          onTap: () {
                                            service.confirmBooking(
                                              context: context, 
                                              bookingId: item.id,
                                              client_name: item.bookingUserInfo.displayName,
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
                                              service: service,
                                              serviceDate: item.serviceDetails.date,
                                              serviceTime: item.serviceDetails.time,
                                              serviceDuration: item.serviceDetails.duration,
                                              bookingId: item.id,
                                              onDelete: () {
                                                service.deleteBooking(
                                                  context: context, 
                                                  bookingId: item.id
                                                ).whenComplete(() => Get.back());
                                              },
                                              context: context, 
                                              serviceName: item.serviceDetails.serviceName,
                                              client_name: item.bookingUserInfo.displayName,
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
                                              backgroundColor: AppColor.greyColor,
                                              //backgroundImage: ,
                                              radius: 30.r,  //25,
                                              child: Text(
                                                item.bookingUserInfo.displayName.toUpperCase().substring(0, 1),
                                                style: GoogleFonts.inter(
                                                  color: AppColor.darkGreyColor,
                                                  fontSize: 14.sp,
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
                                                    item.bookingUserInfo.displayName,
                                                    style: GoogleFonts.inter(
                                                      color: AppColor.darkGreyColor,
                                                      fontSize: 14.sp,
                                                      fontWeight: FontWeight.w600
                                                    ),
                                                  ),
                                                  SizedBox(height: 2.h,),
                                                  Text(
                                                    item.serviceProviderInfo.userId.contains(userId) ? "booked you" : "you booked",
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
                                              item.booked_status == "PENDING CONFIRMATION" ? "pending" : item.booked_status == "CANCELLED" ? "cancelled" : "confirmed",
                                              style: GoogleFonts.inter(
                                                color: item.booked_status == "PENDING CONFIRMATION" ? AppColor.yellowStar : item.booked_status == "CANCELLED" ? AppColor.redColor : AppColor.darkGreen ,
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
                                              item.serviceDetails.date,
                                              style: GoogleFonts.inter(
                                                color: AppColor.darkGreyColor,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500
                                              ),
                                            ),
                                            SizedBox(width: 10.w,),
                                            /////////////
                                            item.bookingUserInfo.userId.contains(userId) ?
                                            SvgPicture.asset("assets/svg/sent_blue.svg")
                                            :SvgPicture.asset("assets/svg/received_yellow.svg")
                                            /////////////////
                                          ],
                                        ),
                                        SizedBox(height: 30.h,),
                                        //service name
                                        Text(
                                          item.serviceDetails.serviceName,
                                          style: GoogleFonts.inter(
                                            color: AppColor.blackColor,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600
                                          ),
                                        ),
                                        SizedBox(height: 30.h,),
                                        //service time and duration
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              item.serviceDetails.time,
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
                                                  item.serviceDetails.duration,
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

                                    //see proof of payment
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            Get.to(() => SeePaymentProofPage(
                                              payment_proof: item.proof_of_payment,
                                            ));
                                          },
                                          child: Text(
                                            "see proof of payment",
                                            style: GoogleFonts.inter(
                                              color: AppColor.darkGreyColor,
                                              fontSize: 12.sp,
                                              fontStyle: FontStyle.italic,
                                              fontWeight: FontWeight.w500,
                                              decoration: TextDecoration.underline,
                                              decorationColor: AppColor.darkGreyColor
                                            )
                                          ),
                                        ),
                                      ]
                                    ),

                                  ]
                                )
                              ),
                              ////////////////////
                                 

                              Divider(color: AppColor.darkGreyColor.withOpacity(0.5), thickness: 0.5,),

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
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600
                                      //decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.h,),
                            ]
                          )
                        );

                      }

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
          )*/


        
        ]
        
      )
    );

  }
}

