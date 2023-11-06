import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';






class InvoiceUnpaidDropDown extends StatelessWidget {
  const InvoiceUnpaidDropDown({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      color: AppColor.bgColor,
      position: PopupMenuPosition.under,
      padding: EdgeInsets.symmetric(horizontal: 10),
      initialValue: "Quote",
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            onTap: () {
              print('ggggg');
            },
            child: Text(
              "View",
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w500,
                fontSize: 15,
                color: AppColor.blackColor
              ),
            )
          ),
          PopupMenuItem(
            onTap: () {
              print('gggggffff');
            },
            child: Text(
              "Edit",
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w500,
                fontSize: 15,
                color: AppColor.blackColor
              ),
            )
          ),
          PopupMenuItem(
            onTap: () {
              print('gggggeee');
            },
            child: Text(
              "Download",
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w500,
                fontSize: 15,
                color: AppColor.blackColor
              ),
            )
          ),
          PopupMenuItem(
            onTap: () {
              print('gggggeee');
            },
            child: Text(
              "Enter payment",
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w500,
                fontSize: 15,
                color: AppColor.blackColor
              ),
            )
          ),
          PopupMenuItem(
            onTap: () {
              print('gggggrtt');
            },
            child: Text(
              "Delete",
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w500,
                fontSize: 15,
                color: AppColor.blackColor
              ),
            )
          )
        ];
      },
      icon: Icon(Icons.more_vert_rounded, color: AppColor.darkGreyColor,),
    );
  }
}