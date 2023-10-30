import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';






class ProfileEmptyState extends StatelessWidget {
  const ProfileEmptyState({super.key, required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset('assets/svg/profile_empty.svg'),
          SizedBox(height: 30,),
          Text(
            'No profile details yet',
            style: GoogleFonts.inter(
              textStyle: TextStyle(
                color: AppColor.blackColor,
                fontSize: 20,
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
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                      color: AppColor.darkGreyColor,
                      fontSize: 16,
                      //fontWeight: FontWeight.bold
                    )
                  )
                ),
                TextSpan(
                  text:' "Add Section" ',
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                      color: AppColor.blackColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    )
                  )
                ),
                TextSpan(
                  text:'button to start \n             adding to your profile',
                  style: GoogleFonts.inter(
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
                style: GoogleFonts.inter(
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