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
  showModalBottomSheet(
    isScrollControlled: true,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 2,
    isDismissible: false,
    useSafeArea: true,
    backgroundColor: AppColor.bgColor,
    //barrierColor: Theme.of(context).colorScheme.background,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(15)
      )
    ),
    context: context, 
    builder: (context) {
      return Wrap(
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
                  style: GoogleFonts.poppins(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColor.darkGreyColor
                  ),
                ),
                SizedBox(height: 20,),
                Text(
                  "By setting up your own account, others can \n         schedule and book your services.",
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColor.darkGreyColor
                  ),
                ),
                SizedBox(height: 30,),
                //buttons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
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
                ),
              ],
            ),
          ),
        ],
      );
    }
  );
}