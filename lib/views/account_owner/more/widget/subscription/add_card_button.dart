import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';




class AddCardButton extends StatelessWidget {
  const AddCardButton({super.key, required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        "+ Add New Card",
        style: GoogleFonts.inter(
          textStyle: TextStyle(
            color: AppColor.mainColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500
          ),
          decoration: TextDecoration.underline
        )
      ),
    );
  }
}