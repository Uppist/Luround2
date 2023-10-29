import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';







class BookingScreenEmptyState extends StatelessWidget {
  const BookingScreenEmptyState({super.key, required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        color: AppColor.bgColor,
        alignment: Alignment.center,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20,),
            SvgPicture.asset('assets/svg/no_bookings.svg'),
            SizedBox(height: 30,),
            Text(
              'No bookings yet',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  color: AppColor.blackColor,
                  fontSize: 22,
                  fontWeight: FontWeight.bold
                )
              )
            ),
            SizedBox(height: 15,),
            Text(
              "When you get bookingss, they'll\n                 show up here",
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  color: AppColor.darkGreyColor,
                  fontSize: 16,
                  //fontWeight: FontWeight.bold
                )
              )
            ),
            SizedBox(height: 60,),
            //Refresh BUTTON
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
                  'Refresh',
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      color: AppColor.bgColor,
                      fontSize: 16,
                      //fontWeight: FontWeight.w500
                    )
                  )
                ),
              )
            ),
            SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}