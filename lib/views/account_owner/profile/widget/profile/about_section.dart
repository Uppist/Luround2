import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';





class AboutSection extends StatelessWidget {
  AboutSection({super.key, required this.text, required this.onPressed});
  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'About',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  color: AppColor.blackColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                )
              )
            ),
            InkWell(
              onTap: onPressed,
              child: SvgPicture.asset('assets/svg/edit.svg')
            )
          ],
        ),
        SizedBox(height: 20),
        Text(
          text,
          style: GoogleFonts.poppins(
            textStyle: TextStyle(
              color: AppColor.darkGreyColor,
              fontSize: 14,
              //fontWeight: FontWeight.w500
            )
          )
        ),
      ]
    );
  }
}