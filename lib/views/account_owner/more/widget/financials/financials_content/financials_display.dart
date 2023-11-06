import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';





class FinancialsDisplay extends StatelessWidget {
  const FinancialsDisplay({super.key, required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: AppColor.bgColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5) ,//withOpacity(0.2),
            spreadRadius: 0.5,
            blurRadius: 0.2,
          )
        ]
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15,),
          //1
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "#0000001",
                style: GoogleFonts.inter(
                  color: AppColor.darkGreyColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w500
                ),
              ),
              InkWell(
                onTap: onPressed, 
                child: Icon(Icons.more_vert_rounded, color: AppColor.darkGreyColor,),
              )
            ],
          ),
          SizedBox(height: 20,),
          //2
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Sheldon Cooper",
                style: GoogleFonts.inter(
                  color: AppColor.blackColor,
                  fontSize: 15,
                  fontWeight: FontWeight.w500
                ),
              ),
              Text(
                "28 Oct 2023",
                style: GoogleFonts.inter(
                  color: AppColor.darkGreyColor,
                  fontSize: 15,
                  fontWeight: FontWeight.normal
                ),
              ),
            ],
          ),
          SizedBox(height: 20,),
          //3
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //trx type and status svg pictures
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset("assets/financials/invoice.svg"),
                  SizedBox(width: 10,),
                  SvgPicture.asset("assets/financials/paid.svg"),
                ],
              ),
              Text(
                "N82,000",
                style: GoogleFonts.inter(
                  color: AppColor.blackColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                ),
              ),
            ],
          ),
          
        ],
      ),
    );
  }
}