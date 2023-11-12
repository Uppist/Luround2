import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/bookings_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/views/account_owner/bookings/screen/booking_screen_empty_state.dart';
import 'package:luround/views/account_owner/bookings/widget/bottomsheets/bookings_list_bottomsheet.dart';
import 'package:luround/views/account_owner/bookings/widget/filter_section/filter_bottomsheet.dart';
import 'package:luround/views/account_owner/bookings/widget/filter_section/filter_container.dart';
import 'package:luround/views/account_owner/bookings/widget/search_textfield.dart';
import 'package:luround/views/account_owner/profile/widget/notifications/notifications_page.dart';










class BookingsPage extends StatefulWidget {
  BookingsPage({super.key});

  @override
  State<BookingsPage> createState() => _BookingsPageState();
}

class _BookingsPageState extends State<BookingsPage> {
  var controller = Get.put(BookingsController());

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
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h,),
                    //search textfield
                    SearchTextField(
                      onFocusChanged: (val) {},
                      onFieldSubmitted: (p0) {
                        setState(() {
                          controller.isFieldTapped.value = false;
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
                        filterDialogueBox(context: context);
                      },
                    ),
                  ],
                ),
              ),
              //SizedBox(height: 10.h,),
        
              //no booking available widget
              //BookingScreenEmptyState(onPressed: () {},),
        
              //Futurebuilder will start from here (will wrap this listview)
              Expanded(
                child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0), //external paddin
                  itemCount: 8,
                  separatorBuilder: (context, index) => SizedBox(height: 25.h,),
                  itemBuilder: (context, index) {
                  
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
                                        bookingsListDialogueBox(context: context, serviceName: 'Digital Marketing Training',);
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
                                            "Yennifer Merit",
                                            style: GoogleFonts.poppins(
                                              color: AppColor.darkGreyColor,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.bold
                                            ),
                                          ),
                                          SizedBox(height: 2.h,),
                                          Text(
                                            index.isEven ? "booked you" : "you booked",
                                            style: GoogleFonts.poppins(
                                              color: AppColor.textGreyColor,
                                              fontSize: 13.sp,
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
                                      "Tuesday, 11 July 2023",
                                      style: GoogleFonts.poppins(
                                        color: AppColor.darkGreyColor,
                                        fontSize: 15.sp,
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
                                  "Digital Marketing Training",
                                  style: GoogleFonts.poppins(
                                    color: AppColor.blackColor,
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                SizedBox(height: 30,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "9:30am - 10:30am",
                                      style: GoogleFonts.poppins(
                                        color: AppColor.blackColor,
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w500
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        SvgPicture.asset("assets/svg/time_icon.svg"),
                                        SizedBox(width: 10.w,),
                                        Text(
                                          "1 hr 30 mins",
                                          style: GoogleFonts.poppins(
                                            color: AppColor.textGreyColor,
                                            fontSize: 14.sp,
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
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w500
                                      ),
                                      //maxLines: controller.selectedIndex == index ? null : 1,
                                      //overflow: controller.selectedIndex == index  ? null : TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 10.h,),
                                    Text(
                                      "yennifermerit@gmail.com",
                                      style: GoogleFonts.poppins(
                                        color: AppColor.darkGreyColor,
                                        fontSize: 14.sp,
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
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w500
                                      ),
                                      //maxLines: controller.selectedIndex == index ? null : 1,
                                      //overflow: controller.selectedIndex == index  ? null : TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 10.h,),
                                    Text(
                                      "Virtual",
                                      style: GoogleFonts.poppins(
                                        color: AppColor.darkGreyColor,
                                        fontSize: 14.sp,
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
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w500
                                      ),
                                      //maxLines: controller.selectedIndex == index ? null : 1,
                                      //overflow: controller.selectedIndex == index  ? null : TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 10.h,),
                                    Text(
                                      "This is a Google Meet web conference",
                                      style: GoogleFonts.poppins(
                                        color: AppColor.darkGreyColor,
                                        fontSize: 14.sp,
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
                                        fontSize: 15.sp,
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
                                        fontSize: 14.sp,
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
                                        fontSize: 15.sp,
                                        fontWeight: FontWeight.w500
                                      ),
                                      //maxLines: controller.selectedIndex == index ? null : 1,
                                      //overflow: controller.selectedIndex == index  ? null : TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 10.h,),
                                    Text(
                                      "qwertyuiopasdfghjklzxcvbnmggggggggggdrerearwaetsrsgergsegehtrshghfh",
                                      style: GoogleFonts.poppins(
                                        color: AppColor.darkGreyColor,
                                        fontSize: 14.sp,
                                        //fontWeight: FontWeight.w500
                                      ),
                                      //maxLines: controller.selectedIndex == index ? null : 1,
                                      //overflow: controller.selectedIndex == index  ? null : TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: 30.h,),
                                    Text(
                                      "Created on 8 July 2023",
                                      style: GoogleFonts.poppins(
                                        color: AppColor.textGreyColor.withOpacity(0.4),
                                        fontSize: 14.sp,
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
                ),
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

