import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/services/account_owner/more/financials/financials_pdf_service.dart';
import 'package:luround/services/account_owner/more/financials/financials_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/screen/receipt_screen/drafted_receipts/view_drafted_receipts.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/screen_widgets/financials_content/receipts_contents/delete_receipt/delete_receipt.dart';






class DraftedReceiptDropDown extends StatelessWidget {
  DraftedReceiptDropDown({super.key, required this.receipt_id, required this.send_to, required this.sent_to_email, required this.service_provider_name, required this.service_provider_email, required this.service_provider_userId, required this.phone_number, required this.payment_status, required this.discount, required this.vat, required this.sub_total, required this.total, required this.note, required this.mode_of_payment, required this.receipt_date, required this.service_detail, required this.service_provider_address, required this.service_provider_phone_number});
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
  final List<dynamic> service_detail;

  var service = Get.put(FinancialsService());
  var finPdfService = Get.put(FinancialsPdfService());
  final int randNum = Random().nextInt(200000);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      color: AppColor.bgColor,
      position: PopupMenuPosition.under,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      initialValue: "Receipt",
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            onTap: () {
              Get.to(() => ViewDraftedReceiptScreen(
                receipt_id: receipt_id,
                send_to: send_to,
                sent_to_email: sent_to_email,
                phone_number: phone_number,
                payment_status: payment_status,
                discount: discount,
                vat: vat,
                sub_total: sub_total,
                total: total,
                note: note,
                mode_of_payment: mode_of_payment,
                receipt_date: receipt_date,
                service_provider_name: service_provider_name,
                service_provider_email: service_provider_email,
                service_provider_userId: service_provider_userId,
                service_detail: service_detail,
              ));
            },
            child: Text(
              "View",
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w400,
                fontSize: 16.sp,
                color: AppColor.blackColor
              ),
            )
          ),
          /*PopupMenuItem(
            onTap: () {
              print('gggggffff');
            },
            child: Text(
              "Edit",
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w400,
                fontSize: 16.sp,
                color: AppColor.blackColor
              ),
            )
          ),*/
          PopupMenuItem(
            onTap: () {
              finPdfService.shareReceiptPDF(
                context: context, 
                receiptNumber: randNum, 
                receiver_name: send_to, 
                receiver_email: sent_to_email, 
                receiver_phone_number: phone_number, 
                receipt_status: payment_status, 
                due_date: receipt_date, 
                grand_total: total, 
                serviceList: service_detail, 
                subtotal: sub_total, 
                discount: discount, 
                vat: vat, 
                note: note
              );
            },
            child: Text(
              "Send",
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w400,
                fontSize: 16.sp,
                color: AppColor.blackColor
              ),
            )
          ),
          PopupMenuItem(
            onTap: () {
              finPdfService.downloadReceiptPDFToDevice(
                context: context, 
                receiptNumber: randNum, 
                receiver_name: send_to, 
                receiver_email: sent_to_email, 
                receiver_phone_number: phone_number, 
                receipt_status: payment_status, 
                due_date: receipt_date, 
                grand_total: total, 
                serviceList: service_detail, 
                subtotal: sub_total, 
                discount: discount, 
                vat: vat, 
                note: note
              );
            },
            child: Text(
              "Download",
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w400,
                fontSize: 16.sp,
                color: AppColor.blackColor
              ),
            )
          ),
          PopupMenuItem(
            onTap: () {
              deleteReceiptsBottomSheet(
                context: context,
                onDelete: () {
                  deleteReceiptsBottomSheet(
                  context: context,
                  onDelete: () {
                      service.deleteReceiptFromDB(
                        context: context, 
                        receipt_id: receipt_id
                      );
                    },
                    service: service
                  );  
                },
                service: service
              );
            },
            child: Text(
              "Delete",
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w400,
                fontSize: 16.sp,
                color: AppColor.blackColor
              ),
            )
          )
        ];
      },
      icon: Icon(Icons.more_vert_rounded, color: AppColor.darkGreyColor,),
    );
  }
}