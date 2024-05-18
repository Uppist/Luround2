import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/main.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/converters.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/screen_widgets/financials_content/dropdowns/receipt/drafted_receipt_dropdown.dart';







class DraftedReceiptDisplay extends StatelessWidget {
  const DraftedReceiptDisplay({super.key, required this.onPressed, required this.receipt_id, required this.send_to, required this.sent_to_email, required this.service_provider_name, required this.service_provider_email, required this.service_provider_userId, required this.phone_number, required this.payment_status, required this.discount, required this.vat, required this.sub_total, required this.total, required this.note, required this.mode_of_payment, required this.receipt_date, required this.service_detail, required this.service_provider_address, required this.service_provider_phone_number, required this.tracking_id, required this.created_at, required this.refresh});
  final VoidCallback onPressed;
  final String receipt_id;
  final String send_to;
  final String sent_to_email;
  final String service_provider_name;
  final String service_provider_email;
  final String service_provider_userId;
  final String service_provider_address;
  final String service_provider_phone_number;
  final String phone_number;
  final String payment_status;
  final String discount;
  final String vat;
  final String sub_total;
  final String total;
  final String note;
  final String mode_of_payment;
  final String receipt_date;
  final String tracking_id;
  final List<dynamic> service_detail;
  final int created_at;
  final Future<void> refresh;

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
              DraftedReceiptDropDown(
                refresh: refresh,
                tracking_id: tracking_id,
                receipt_id: receipt_id, //randNum.toString(),
                service_provider_address: service_provider_address,
                service_provider_phone_number: service_provider_phone_number,
                send_to: send_to,
                sent_to_email: sent_to_email,
                phone_number: phone_number,
                payment_status: payment_status,
                discount: discount,
                vat: vat,
                sub_total:sub_total,
                total:total,
                note: note,
                mode_of_payment: mode_of_payment,
                receipt_date: receipt_date,
                service_provider_name: service_provider_name,
                service_provider_email: service_provider_email,
                service_provider_userId: service_provider_userId,
                service_detail: service_detail,
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
                send_to,
                style: GoogleFonts.inter(
                  color: AppColor.blackColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500
                ),
              ),
              Text(
                receipt_date,
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
                "${currency(context).currencySymbol}$total",
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