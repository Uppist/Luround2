import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';




class CustomAppBarTitle extends StatelessWidget {
  CustomAppBarTitle({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.inter(
        color: AppColor.blackColor,
        fontSize: 18,
        fontWeight: FontWeight.w500
      ),
    );
  }
}