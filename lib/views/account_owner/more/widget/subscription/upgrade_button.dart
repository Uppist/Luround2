import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';




class UpgradeButton extends StatelessWidget {
  const UpgradeButton({super.key, required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        alignment: Alignment.center,
        height: 50,
        width: 150,
        decoration: BoxDecoration(
          color: AppColor.mainColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          "Upgrade",
          style: GoogleFonts.inter(
            textStyle: TextStyle(
              color: AppColor.bgColor,
              fontSize: 18,
              fontWeight: FontWeight.w500
            )
          )
        ),
      )
    );
  }
}