import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/border_button.dart';
import 'package:luround/utils/components/reusable_button.dart';
import 'package:luround/views/account_viewer/mainpage/screen/mainpage._acc_viewer.dart';








///Alert Dialog
Future<void> signMeUpBottomSheet({required BuildContext context}) async{
  showDialog(
    useSafeArea: true,
    context: context, 
    builder: (context) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(15)
          )
        ),
        backgroundColor: AppColor.bgColor,
        content: Wrap(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                //image: DecorationImage(image: AssetImage(''),),
                color: AppColor.bgColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //Cancel button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.back();
                        }, 
                        icon: Icon(CupertinoIcons.xmark),
                        iconSize: 30,
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Text(
                    "Create your own account",
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColor.darkGreyColor
                    ),
                  ),
                  SizedBox(height: 20,),
                  Text(
                    "     By setting up your own account,\n      others can schedule and book\n                    your services.",
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColor.darkGreyColor
                    ),
                  ),
                  SizedBox(height: 30,),
                  ReusableButton(
                    onPressed: () {
                      //Get.offAll(() => LoginScreen());
                    },
                    color: AppColor.mainColor,
                    text: 'Sign me up',
                  ),
                  SizedBox(height: 30,),
                  BorderButton(
                    onPressed: (){
                      Get.offAll(() => MainPageAccViewer());
                    },
                    text: "Remind me later",
                    textColor: AppColor.mainColor,
                  ),
                  SizedBox(height: 20,),
                  //buttons
                  /*Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    child: Column(
                      children: [
                        ReusableButton(
                          onPressed: () {
                            //Get.offAll(() => LoginScreen());
                          },
                          color: AppColor.mainColor,
                          text: 'Sign me up',
                        ),
                        SizedBox(height: 30,),
                        BorderButton(
                          onPressed: (){
                            Get.offAll(() => MainPageAccViewer());
                          },
                          text: "Remind me later",
                          textColor: AppColor.mainColor,
                        ),
                        SizedBox(height: 20,),
                      ],
                    ),
                  ),*/
                ],
              ),
            ),
          ],
        ),
      );
    }
  );
}