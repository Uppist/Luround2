import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/converters.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/screen_widgets/financials_content/dropdowns/quotes/sent_qoutes_dropdown.dart';








class QuotesDisplay extends StatelessWidget {
  const QuotesDisplay({
    super.key, 
    required this.onPressed,
    required this.send_to_name, 
    required this.send_to_email, 
    required this.phone_number, 
    required this.due_date, 
    required this.quote_date, 
    required this.sub_total, 
    required this.discount, 
    required this.vat, 
    required this.total, 
    required this.appointment_type, 
    required this.status, 
    required this.note, 
    required this.service_provider,  
    required this.product_details,
    required this.quote_id, 
    required this.service_provider_address, 
    required this.service_provider_phone_number, 
    required this.tracking_id, 
    required this.created_at, 
    required this.bank_name, 
    required this.account_name, 
    required this.account_number,
    
  });
  final VoidCallback onPressed;
  final String service_provider_address;
  final String service_provider_phone_number;
  final String quote_id;
  final String send_to_name;
  final String send_to_email;
  final String phone_number;
  final String due_date;
  final String quote_date;
  final String sub_total;
  final String discount;
  final String vat;
  final String total;
  final String appointment_type;
  final String status;
  final String note;
  final Map<String, dynamic> service_provider;
  final List<dynamic> product_details;
  final String tracking_id;
  final int created_at;
  final String bank_name;
  final String account_name;
  final String account_number;



  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(20, 0, 20, 30),
      decoration: BoxDecoration(
        color: AppColor.bgColor,
        borderRadius: BorderRadius.circular(5.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5) ,//withOpacity(0.2),
            spreadRadius: 0.5,
            blurRadius: 0.2,
          )
        ],
        border: Border(
          bottom: BorderSide(
            color: AppColor.mainColor,
            width: 1.5, // Adjust the width as needed
          ),
        ),
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
                tracking_id,
                style: GoogleFonts.inter(
                  color: AppColor.darkGreyColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400
                ),
              ),
              QuoteDropDown(
                bank_name: bank_name,
                account_name: account_name,
                account_number: account_number,
                tracking_id: tracking_id,
                quote_id: quote_id, 
                send_to_name: send_to_name,
                send_to_email: send_to_email,
                phone_number:phone_number,
                due_date: due_date,
                quote_date: quote_date,
                sub_total: sub_total,
                discount: discount,
                vat: vat,
                total: total,
                appointment_type: appointment_type,
                status: status,
                note: note,
                service_provider: service_provider,
                product_details: product_details, 
                service_provider_address: service_provider_address,
                service_provider_phone_number: service_provider_phone_number,
              )
            ],
          ),
          SizedBox(height: 10.h,),
          Divider(thickness: 0.3, color: Colors.grey,),
          SizedBox(height: 20.h,),
          //2
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                send_to_name,
                style: GoogleFonts.inter(
                  color: AppColor.blackColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500
                ),
              ),
              Text(
                due_date,
                style: GoogleFonts.inter(
                  color: AppColor.darkGreyColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400
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
              /*Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset("assets/financials/invoice.svg"),
                  SizedBox(width: 10.w,),
                  SvgPicture.asset("assets/financials/paid.svg"),
                ],
              ),*/
              Text(
                convertServerTimeToDate(created_at),
                style: GoogleFonts.inter(
                  color: AppColor.darkGreyColor.withOpacity(0.5),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400
                ),
              ),
              Text(
                "N$total",
                style: GoogleFonts.inter(
                  color: AppColor.blackColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600
                ),
              ),
            ],
          ),
          
        ],
      ),
    );
  }
}