import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';





class FirstPage extends StatelessWidget {
  const FirstPage({super.key});

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
          SvgPicture.asset(
            'assets/svg/1.svg',
            //height: 400,
            //width: 450,
          ),
          SizedBox(height: 20,),
          Text(
            'Create your profile page, add your services and rate card',
            style: GoogleFonts.inter(
              color: AppColor.blackColor,
              fontSize: 16,
              fontWeight: FontWeight.w500
            ),
          ),        
        ],
      ),
    );
  }
}