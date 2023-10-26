import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';






class UploadFileWidget extends StatelessWidget {
  UploadFileWidget({super.key, required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      borderType: BorderType.Rect, //RrRct
      radius: Radius.circular(50),
      dashPattern: [6, 6],
      color: AppColor.mainColor,
      child: Container(
        color: AppColor.lightMainColor,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Drag file here or click the button below",
              style: GoogleFonts.poppins(
                color: AppColor.textGreyColor,
                fontSize: 14,
                //fontWeight: FontWeight.w500
              ),
            ),
            SizedBox(height: 30,),
            InkWell(
              onTap: onPressed,
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                width: 170,
                decoration: BoxDecoration(
                  color: AppColor.mainColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  "Upload file",
                  style: GoogleFonts.poppins(
                    color: AppColor.bgColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500
                  ),
                ),
            
              ),
            )
          ],
        ),
      )
    );
  }
}