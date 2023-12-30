import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/financials/main/financials_controller.dart';
import 'package:luround/controllers/account_owner/financials/qoutes/sent_quotes/sent_quotes_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/create_quotes/screen/create_quotes.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/screen_widgets/financials_content/quotes_contents/sent_quotes/filter_quotes_button.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/screen_widgets/financials_content/quotes_contents/sent_quotes/quotes_list.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/screen_widgets/financials_content/components/search_textfield.dart';
import 'package:luround/views/account_owner/profile/widget/notifications/notifications_page.dart';








class QuotesPage extends StatefulWidget {
  QuotesPage({super.key});

  @override
  State<QuotesPage> createState() => _QuotesPageState();
}

class _QuotesPageState extends State<QuotesPage>{

  var controller = Get.put(SentQuotesController());
  var fincontroller = Get.put(FinancialsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: controller.isFinancialsListEmpty.value ? AppColor.bgColor : AppColor.greyColor,
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ///Header Section/////
            /*Container(
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
            ),*/
           
            ///Navigation Section////////////////
            Container(
              padding: EdgeInsets.symmetric(horizontal: 7.w,),
              //height: 70, //65
              width: double.infinity,
              color: AppColor.bgColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h,),                   
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
                        "Quotes",
                        style: GoogleFonts.inter(
                          color: AppColor.blackColor,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    ],
                  ),
                  ////////////////////////////////////////////////

                  ////Search TextField and Filter/////
                  SizedBox(height: 20.h,),
                  //search textfield
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 13.w),
                    child:FinancialsSearchTextField(
                      controller: controller,
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
                      textController: controller.searchQuoteController,
                    )                
                  ),
                  SizedBox(height: 30.h,),
                  //filter button
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 13.w),
                    child: FilterQuotesButton(),
                  ),
                  SizedBox(height: 15.h,),                 
                ],
              ),
            ),
            //SizedBox(height: 20,),
            //financils list and empty state (run future builder there)
            //FinancialsEmptyState(),
            QuotesList()
          ]
        ),
      ),  
      
      //FAB (floating action bubble / speed dial)
      floatingActionButton: Obx(
        () {
          return SpeedDial(
            //extendedPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            //isOpenOnStart: true,
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
              fincontroller.isQuotesOpened.value ? CupertinoIcons.xmark :
              CupertinoIcons.add,
              size: 30,
              color: AppColor.bgColor
            ),
            /*onPress: () {
              controller.isOpened.value = true;
            },*/
            onOpen: () {
              fincontroller.isQuotesOpened.value = true;
            },
            onClose: () {
              fincontroller.isQuotesOpened.value = false;
            },
            spaceBetweenChildren: 30,
            //childPadding: EdgeInsets.symmetric(horizontal: 20),
            // Menu items
            children: [
              /*SpeedDialChild(
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
              ),*/

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
                  Get.to(() => CreateQuotePage());
                },
              )
            ],
          );
        }
      ),
    );
  }
}







