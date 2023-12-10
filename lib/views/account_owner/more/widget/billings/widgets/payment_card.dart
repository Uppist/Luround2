import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';








class PaymentCard extends StatelessWidget {
  const PaymentCard({super.key, required this.onEditPressed, required this.onDelete, required this.cardType, required this.expiryDate, required this.cardNuber});
  final VoidCallback onEditPressed;
  final VoidCallback onDelete;
  final String cardType;
  final String expiryDate;
  final String cardNuber;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      width: double.infinity,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      padding: EdgeInsets.symmetric(
        horizontal: 20.w, 
        vertical: 30.h, 
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColor.bgColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5) ,//withOpacity(0.2),
            spreadRadius: 0.5,
            blurRadius: 5.0,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                cardType,
                style: GoogleFonts.inter(
                  color: AppColor.blackColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500
                ),
              ),
              InkWell(
                onTap: onDelete,
                child: SvgPicture.asset("assets/svg/delete_card.svg"),
              )
            ],
          ),
          SizedBox(height: 20.h,),
          Text(
            cardNuber,
            style: GoogleFonts.inter(
              color: AppColor.textGreyColor,
              fontSize: 15.sp,
              fontWeight: FontWeight.w500
            ),
          ),
          SizedBox(height: 15.h,),
          Text(
            expiryDate,
            style: GoogleFonts.inter(
              color: AppColor.textGreyColor,
              fontSize: 15.sp,
              fontWeight: FontWeight.w500
            ),
          ),
          SizedBox(height: 20.h,),
          //edit card button and card logo
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: onEditPressed,
                //onPressed: onEditPressed,
                child: Text(
                  "Edit Card Info",
                  style: GoogleFonts.inter(
                    textStyle: TextStyle(
                      color: AppColor.yellowStar,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500
                    ),
                    decoration: TextDecoration.underline
                  )
                ),
              ),
              /*Icon(
                Icons.payment_rounded, 
                size: 40,
                color: AppColor.navyBlue,
              )*/
              SvgPicture.asset("assets/svg/master_card.svg"),
              //SvgPicture.asset("assets/svg/visa_card.svg")
            ],
          ),

        ]
      )
    );
  }
}