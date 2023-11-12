import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/financials_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/create_quotes/create_quotes.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/screen_widgets/filter_financials_button.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/screen_widgets/financials_list.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/screen_widgets/search_textfield.dart';
import 'package:luround/views/account_owner/profile/widget/notifications/notifications_page.dart';








class FinancialsPage extends StatefulWidget {
  FinancialsPage({super.key});

  @override
  State<FinancialsPage> createState() => _FinancialsPageState();
}

class _FinancialsPageState extends State<FinancialsPage>{
  var controller = Get.put(FinancialsController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: controller.isFinancialsListEmpty.value ? AppColor.bgColor : AppColor.greyColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ///Header Section/////
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
                      InkWell(
                        onTap: () {
                          Get.to(() => NotificationsPage());
                        },
                        child: SvgPicture.asset("assets/svg/notify_active.svg"),
                      ),
                    ]
                  ),
                ]
              )
            ),
            ///Navigation Section, Search TextField and Filter/////
            Container(
              padding: EdgeInsets.symmetric(horizontal: 7.w,),
              //height: 70, //65
              width: double.infinity,
              color: AppColor.bgColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [                   
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          Icons.arrow_back_rounded,
                          color: AppColor.blackColor,
                        )
                      ),
                      SizedBox(width: 3.w,),
                      Text(
                        "Financials",
                        style: GoogleFonts.inter(
                          color: AppColor.blackColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h,),
                  //search textfield
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 13.w),
                    child:FinancialsSearchTextField(
                      onTap: () {
                        setState(() {
                          controller.isFieldTapped.value = true;
                        });
                      },
                      onFieldSubmitted: (p0) {
                        setState(() {
                          controller.isFieldTapped.value = false;
                        });  
                      },
                      hintText: "Search",
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      textController: controller.searchController,
                    )                
                  ),
                  SizedBox(height: 20.h,),
                  //filter button
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 13.w),
                    child: FilterFinancialsButton(),
                  ),
                  SizedBox(height: 15.h,),                 
                ],
              ),
            ),
            //SizedBox(height: 20,),
            //financils list and empty state (run future builder there)
            //FinancialsEmptyState(),
            FinancialsList()
          ]
        ),
      ),  
      
      //FAB (floating action bubble / speed dial)
      floatingActionButton: Obx(
        () {
          return SpeedDial(
            //extendedPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            foregroundColor: AppColor.mainColor,
            backgroundColor: AppColor.mainColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(50.r))
            ),
            overlayOpacity: 0.4,
            overlayColor: AppColor.blackColor,
            //icon:CupertinoIcons.add,        
            //animatedIcon: AnimatedIcons.menu_close,
            child: Icon(
              controller.isOpened.value ? CupertinoIcons.xmark :
              CupertinoIcons.add,
              size: 30,
              color: AppColor.bgColor
            ),
            onOpen: () {
              controller.isOpened.value = true;
            },
            onClose: () {
              controller.isOpened.value = false;
            },
            spaceBetweenChildren: 30,
            //childPadding: EdgeInsets.symmetric(horizontal: 20),
            // Menu items
            onPress: () {},
            children: [
              SpeedDialChild(
                label: "Generate Receipt",
                labelStyle: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  fontSize: 15.sp,
                  color: AppColor.darkGreyColor
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.r))
                ),
                onTap: () {
                  //Get.off(() => CreateReceiptPage());
                },
              ),
              SpeedDialChild(
                label: "Generate Invoice",
                labelStyle: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  fontSize: 15.sp,
                  color: AppColor.darkGreyColor
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.r))
                ),
                onTap: () {
                  //Get.off(() => CreateInvoicePage());
                },
              ),

              SpeedDialChild(
                label: "Generate Quote",
                labelStyle: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  fontSize: 15.sp,
                  color: AppColor.darkGreyColor
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.r))
                ),
                onTap: () {
                  Get.off(() => CreateQuotePage());
                },
              )
            ],
          );
        }
      ),
    );
  }
}







