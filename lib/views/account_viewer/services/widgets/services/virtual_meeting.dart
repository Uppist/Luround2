import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';






class VirtualContainer extends StatelessWidget {
  const VirtualContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(),
      padding: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
        alignment: Alignment.center,
        height: 50,
        width: 250,
        decoration: BoxDecoration(
          color: AppColor.bgColor,
          borderRadius: BorderRadius.all(Radius.circular(50)),
          border: Border.all(
            color: AppColor.navyBlue,
            width: 2.0,
          )
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "In-person",
                style: GoogleFonts.inter(
                  textStyle: TextStyle(
                    color: AppColor.textGreyColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w500
                  )
                )
              ),
            ),
            //
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                alignment: Alignment.center,
                //height: 70,
                //width: 150,
                decoration: BoxDecoration(
                  color: AppColor.navyBlue,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  border: Border.all(
                    color: AppColor.navyBlue,
                    width: 2.0,
                  )
                ),
                child: Text(
                  "Virtual",
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                      color: AppColor.bgColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500
                    )
                  )
                ),
              ),
            )
          ],
        ),
    );
  }
}