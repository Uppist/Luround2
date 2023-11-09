import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';





class ThirdPage extends StatelessWidget {
  const ThirdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/onb_3.png',
            //height: 400,
            //width: 450,
          ),
          SizedBox(height: 60,),
          Text(
            'Accept payments in dollars, pounds, euro, naira\n                                and more...',
            style: GoogleFonts.inter(
              color: AppColor.darkGreyColor,
              fontSize: 16,
              fontWeight: FontWeight.w500
            ),
          ),        
        ],
      ),
    );
  }
}