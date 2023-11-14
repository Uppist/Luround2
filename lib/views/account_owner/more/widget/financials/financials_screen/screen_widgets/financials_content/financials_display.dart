import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/dropdowns/invoice_dropdown.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/dropdowns/quotes_dropdown.dart';





class FinancialsDisplay extends StatelessWidget {
  const FinancialsDisplay({super.key, required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(20, 0, 20, 30),
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
          SizedBox(height: 15.h,),
          //1
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "#0000001",
                style: GoogleFonts.inter(
                  color: AppColor.darkGreyColor,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500
                ),
              ),
              //QoutesDrpDown()  //ReceiptDropDown()  //InvoiceDropDown()
              QuoteDropDown()
            ],
          ),
          SizedBox(height: 20.h,),
          //2
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Sheldon Cooper",
                style: GoogleFonts.inter(
                  color: AppColor.blackColor,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w500
                ),
              ),
              Text(
                "28 Oct 2023",
                style: GoogleFonts.inter(
                  color: AppColor.darkGreyColor,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.normal
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h,),
          //3
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //trx type and status svg pictures
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset("assets/financials/invoice.svg"),
                  SizedBox(width: 10.w,),
                  SvgPicture.asset("assets/financials/paid.svg"),
                ],
              ),
              Text(
                "N82,000",
                style: GoogleFonts.inter(
                  color: AppColor.blackColor,
                  fontSize: 16.sp,
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