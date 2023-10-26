import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';





class LuroundSnackBar {

  static errorSnackBar({required String message,  Widget? icon}) {
    Get.rawSnackbar(
      snackStyle: SnackStyle.FLOATING,
      message: message,
      messageText: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            width: Get.width / 1.85,
            child: Wrap(
              children: [
                Text(
                  message,
                  style: GoogleFonts.poppins(
                    color: AppColor.bgColor
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      margin: const EdgeInsets.all(24),
      snackPosition: SnackPosition.TOP,
      borderRadius: 10,
      icon: Icon(
        CupertinoIcons.xmark_circle,
        color: AppColor.bgColor
      ),
      isDismissible: false,
      backgroundColor: AppColor.redColor
    );
  }

  static noInternet({required String message, message2,  Widget? icon}) {
    Get.rawSnackbar(
      snackStyle: SnackStyle.GROUNDED,
      boxShadows: [
        BoxShadow(
          color: AppColor.bgColor.withOpacity(0.1),
          spreadRadius: 5,
          blurRadius: 5,
        )
      ],
      message: message,
      messageText: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          SizedBox(
            width: Get.width / 1.85,
            child: Wrap(
              children: [
                Text(
                  '$message $message2',
                  style: GoogleFonts.poppins(
                    color: AppColor.textGreyColor,
                    fontWeight: FontWeight.w400,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      margin: const EdgeInsets.all(24),
      snackPosition: SnackPosition.TOP,
      borderRadius: 8,
      icon: Icon(
        CupertinoIcons.xmark_circle,
        color: AppColor.textGreyColor,
      ),
      isDismissible: false,
      backgroundColor: AppColor.bgColor,
    );
  }

  static successSnackBar({required String message,}) {
    return Get.rawSnackbar(
      snackStyle: SnackStyle.FLOATING,
      message: message,
      messageText: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: Get.width / 1.85,
            child: Wrap(
              children: [
                Text(
                  message,
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      color: AppColor.bgColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      margin: const EdgeInsets.all(24),
      snackPosition: SnackPosition.TOP,
      borderRadius: 15,
      icon: Icon(
        CupertinoIcons.check_mark_circled,
        color: AppColor.bgColor,
      ),
      isDismissible: false,
      backgroundColor: AppColor.darkGreen,
    );
  }
}
