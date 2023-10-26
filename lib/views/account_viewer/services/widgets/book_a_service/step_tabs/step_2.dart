import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../utils/colors/app_theme.dart';






class Step2Screen extends StatelessWidget {
  Step2Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Select day",
            style: GoogleFonts.poppins(
              color: AppColor.blackColor,
              fontSize: 15,
              fontWeight: FontWeight.w500
            ),
          ),
          SizedBox(height: 20,)
        ],
      ),
    );
  }
}