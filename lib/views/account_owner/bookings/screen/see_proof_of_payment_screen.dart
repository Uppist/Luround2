import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';




class SeePaymentProofPage extends StatelessWidget {
  SeePaymentProofPage({super.key, required this.payment_proof});
  final String payment_proof;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          child: Image.network(payment_proof)
        )
      ),
      //FAB (floating action bubble / speed dial)
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SpeedDial(
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
          CupertinoIcons.xmark,
          size: 30,
          color: AppColor.bgColor
        ),
        onPress: () {
          Get.back();
        },
        /*onPress: () {
          controller.isOpened.value = true;
        },*/
        /*: () {
          print("opened");
        },
        onClose: () {
          print("closed");
        },*/
        spaceBetweenChildren: 30,
        //childPadding: EdgeInsets.symmetric(horizontal: 20),
        // Menu items
        children: [],
      )
    
    );
  }
}