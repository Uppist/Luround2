import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';








class ServiceEmptyState extends StatelessWidget {
  const ServiceEmptyState({super.key, required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            color: AppColor.greyColor,
            width: double.infinity,
            height: 7,
          ),
          //SizedBox(height: 30,),
          SizedBox(height: 60,),
          SvgPicture.asset('assets/svg/no_service.svg'),
          SizedBox(height: 60,),
          Text(
            'No services yet',
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
                  text:'Click on',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      color: AppColor.darkGreyColor,
                      fontSize: 16,
                      //fontWeight: FontWeight.bold
                    )
                  )
                ),
                TextSpan(
                  text:' "Add Section" ',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      color: AppColor.blackColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    )
                  )
                ),
                TextSpan(
                  text:'button to start \n             adding your services',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      color: AppColor.darkGreyColor,
                      fontSize: 16,
                      //fontWeight: FontWeight.bold
                    )
                  )
                ),
              ]
            )
          ),
          SizedBox(height: 30,),
          //ADD SECTION BUTTON
          InkWell(
            onTap: onPressed,
            child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              alignment: Alignment.center,
              height: 50,
              width: 350,
              decoration: BoxDecoration(
                color: AppColor. mainColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: AppColor.mainColor
                )
              ),
              child: Text(
                'Add Section',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                    color: AppColor.bgColor,
                    fontSize: 16,
                    //fontWeight: FontWeight.w500
                  )
                )
              ),
            )
          )
        ],
      ),
    );
  }
}