import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';






class CustomCard extends StatelessWidget {
  const CustomCard({super.key, required this.onTap, required this.svgAsset, required this.title});
  final VoidCallback onTap;
  final String svgAsset;
  final String title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Expanded(
        child: Container(
          //height: 100,
          width: 200,
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
            color: AppColor.bgColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(svgAsset),
              SizedBox(height: 20,),
              Text(
                title,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: AppColor.blackColor
                ),
              )
            ],
          )
        ),
      ),
    );
  }
}