import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';





class TrxDisplay extends StatelessWidget {
  const TrxDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 15,),
        //1
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Personal Training",
              style: GoogleFonts.inter(
                color: AppColor.darkGreyColor,
                fontSize: 15,
                fontWeight: FontWeight.bold
              ),
            ),
            Text(
              "N56,000",
              style: GoogleFonts.inter(
                color: AppColor.redColor,
                fontSize: 15,
                fontWeight: FontWeight.w500
              ),
            ),
          ],
        ),
        SizedBox(height: 20,),
        //2
        Text(
          "Transaction reference | Sent to Sheldon Cooper via LuroundPay", //"Transaction reference | Received from Sheldon Cooper via LuroundPay",
          style: GoogleFonts.inter(
            color: AppColor.darkGreyColor,
            fontSize: 14,
            fontWeight: FontWeight.w500
          ),
        ),
        SizedBox(height: 20,),
        Text(
          "Tue, 11 July 2023 17:30",
          style: GoogleFonts.inter(
            color: AppColor.textGreyColor,
            fontSize: 14,
            //fontWeight: FontWeight.w500
          ),
        ),
        SizedBox(height: 15,),
      ],
    );
  }
}