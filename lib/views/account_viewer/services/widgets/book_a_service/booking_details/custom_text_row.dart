import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';







class CustomTextRow extends StatelessWidget {
  CustomTextRow({super.key, required this.leftText, required this.rightText});
  final String leftText;
  final String rightText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            leftText,
            style: GoogleFonts.poppins(
              color: AppColor.textGreyColor,
              fontSize: 15,
              fontWeight: FontWeight.w500
            ),
          ),
          Text(
            rightText,
            style: GoogleFonts.poppins(
              color: AppColor.blackColor,
              fontSize: 15,
              fontWeight: FontWeight.w500
            ),
          ),
        ],
      ),
    );
  }
}