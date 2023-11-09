import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';






class SignInWithGoogleWidget extends StatelessWidget {
  const SignInWithGoogleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //Or
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Divider(color: Colors.grey.withOpacity(0.2), thickness: 0.3,),
            Text(
              "OR",
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: AppColor.darkGreyColor
              ),
            ),
            Divider(color: Colors.grey.withOpacity(0.2), thickness: 0.3,),
          ],
        )
      ],
    );
  }
}