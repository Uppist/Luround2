import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/financials/invoice/unpaid/unpaid_invoice_controller.dart';
import 'package:luround/controllers/account_owner/financials/main/financials_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/create_invoice/screen/create_invoice_screen.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/screen/invoice_screen/utils/search_textfield.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/screen_widgets/financials_content/invoice_contents/unpaid_invoice/filter_unpaid_invoice_button.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/screen_widgets/financials_content/invoice_contents/unpaid_invoice/unpaid_invoice_list.dart';









class UnpaidInvoicesPage extends StatefulWidget {
  UnpaidInvoicesPage({super.key});

  @override
  State<UnpaidInvoicesPage> createState() => _UnpaidInvoicesPageState();
}

class _UnpaidInvoicesPageState extends State<UnpaidInvoicesPage>{

  var controller = Get.put(UnpaidInvoiceController());
  var fincontroller = Get.put(FinancialsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.greyColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 7.w,),
            //height: 70, //65
            width: double.infinity,
            color: AppColor.bgColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ////Search TextField and Filter/////
                SizedBox(height: 40.h,),
                //search textfield
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 13.w),
                  child: InvoicesSearchTextField(
                    onTap: () {},
                    onFieldSubmitted: (p0) {},
                    hintText: "Search",
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    textController: controller.searchUnpaidInvoiceController,
                  )                
                ),
                SizedBox(height: 30.h,),
                //filter button
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 13.w),
                  child: FilterUnpaidInvoiceButton(),
                ),
                SizedBox(height: 15.h,),                 
              ],
            ),
          ),
          //SizedBox(height: 20,),
          //financils list and empty state (run future builder there)
          //FinancialsEmptyState(),
          UnpaidInvoiceList()
        ]
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
              fincontroller.isInvoiceOpened.value ? CupertinoIcons.xmark :
              CupertinoIcons.add,
              size: 30,
              color: AppColor.bgColor
            ),
            /*onPress: () {
              controller.isOpened.value = true;
            },*/
            onOpen: () {
              fincontroller.isInvoiceOpened.value = true;
            },
            onClose: () {
              fincontroller.isInvoiceOpened.value = false;
            },
            spaceBetweenChildren: 30,
            //childPadding: EdgeInsets.symmetric(horizontal: 20),
            // Menu items
            children: [

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
                  final int invoiceNumber = Random().nextInt(200000);
                  Get.to(() => CreateInvoicePage(
                    invoiceNumber: invoiceNumber,
                  ));
                },
              )
            ],
          );
        }
      ),
    );
  }
}







