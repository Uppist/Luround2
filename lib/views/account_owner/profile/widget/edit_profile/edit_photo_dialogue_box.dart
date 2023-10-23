import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';

import 'delete_photo_dialogue_box.dart';








///Alert Dialog
Future editPhotoDialogueBox({required BuildContext context}) {
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
          height: 140, //150
          width: double.infinity,
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //1
              InkWell(
                onTap: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset('assets/svg/pen_photo.svg'),
                    SizedBox(width: 20,),
                    Text(
                      'Edit profile photo',
                      style: GoogleFonts.poppins(
                        color: AppColor.textGreyColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w500
                      )
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30,),
              //2
              InkWell(
                onTap: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset('assets/svg/replace_photo.svg'),
                    SizedBox(width: 20,),
                    Text(
                      'Replace profile photo',
                      style: GoogleFonts.poppins(
                        color: AppColor.textGreyColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w500
                      )
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30,),
              //1
              InkWell(
                onTap: () {
                  deletePhotoDialogueBox(context: context);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset('assets/svg/delete_photo.svg'),
                    SizedBox(width: 20,),
                    Text(
                      'Delete profile photo',
                      style: GoogleFonts.poppins(
                        color: AppColor.textGreyColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w500
                      )
                    ),
                  ],
                ),
              ),
              //SizedBox(height: 10,),
            ],
          ),
        ),
      );
    }
  );
}