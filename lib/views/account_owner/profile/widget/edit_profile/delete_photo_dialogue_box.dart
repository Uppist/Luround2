import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';








///Alert Dialog
Future deletePhotoDialogueBox({required BuildContext context}) {
  return showDialog(
    barrierDismissible: true,
    context: context,
    builder: (context) {
      return AlertDialog(
        alignment: Alignment.center,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        backgroundColor: AppColor.bgColor,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 30,
        ),
        content: SizedBox(
          height: 180, //150
          width: double.infinity,
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Delete Photo',
                style: GoogleFonts.poppins(
                  color: AppColor.blackColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                )
              ),
              SizedBox(height: 40,),
              Text(
                'Are you sure you want to delete\n                  this photo ?',
                style: GoogleFonts.poppins(
                  color: AppColor.textGreyColor,
                  fontSize: 16,
                  //fontWeight: FontWeight.bold
                )
              ),
              SizedBox(height: 20,),
            ],
          ),
        ),
      );
    }
  );
}