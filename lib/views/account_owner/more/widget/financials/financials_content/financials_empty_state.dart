import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';






class FinancialsEmptyState extends StatelessWidget {
  const FinancialsEmptyState({super.key,});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.bgColor,
      alignment: Alignment.center,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20,),
          SvgPicture.asset('assets/svg/no_financials.svg'),
          SizedBox(height: 30,),
          Text(
            'No Financial documents yet',
            style: GoogleFonts.poppins(
              textStyle: TextStyle(
                color: AppColor.blackColor,
                fontSize: 22,
                fontWeight: FontWeight.bold
              )
            )
          ),
          SizedBox(height: 15,),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      color: AppColor.darkGreyColor,
                      fontSize: 16,
                      //fontWeight: FontWeight.bold
                    )
                  )
                )
              ]
            ),
          ),
          SizedBox(height: 60,),
        ],
      ),
    );
  }
}