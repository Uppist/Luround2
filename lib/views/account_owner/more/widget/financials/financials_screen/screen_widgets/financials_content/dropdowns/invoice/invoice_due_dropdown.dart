import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/services/account_owner/more/financials/financials_pdf_service.dart';
import 'package:luround/services/account_owner/more/financials/financials_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/screen/invoice_screen/due_invoices/view_due_invoice_screen.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/screen_widgets/financials_content/invoice_contents/delete_invoice/delete_invoice.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/screen_widgets/financials_content/invoice_contents/enter_payment/enter_invoice_payment.dart';





class InvoiceDueDropDown extends StatelessWidget {
  InvoiceDueDropDown({super.key, required this.invoice_id, required this.send_to_name, required this.send_to_email, required this.phone_number, required this.due_date, required this.sub_total, required this.discount, required this.vat, required this.total, required this.note, required this.status, required this.booking_detail, required this.service_provider_address, required this.service_provider_phone_number, required this.tracking_id, required this.bank_details, required this.refresh, required this.paymentLink,});
  final String invoice_id;
  final String send_to_name;
  final String send_to_email;
  final String phone_number;
  final String due_date;
  final String sub_total;
  final String discount;
  final String vat;
  final String total;
  final String note;
  final String status;
  final String service_provider_address;
  final String service_provider_phone_number;
  final List<dynamic> booking_detail;
  final String tracking_id;
  //service provider bank details here
  final Map<String, dynamic> bank_details;
  final String paymentLink;
  final Future<void> refresh;



  final service = Get.put(FinancialsService());
  final finPdfService = Get.put(FinancialsPdfService());

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      color: AppColor.bgColor,
      position: PopupMenuPosition.under,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      initialValue: "Quote",
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            onTap: () {
              Get.to(() => ViewDueInvoiceScreen(
                onPressed: () {},
                bank_details: bank_details,
                tracking_id: tracking_id,
                service_provider_address: service_provider_address,
                service_provider_phone_number: service_provider_phone_number,
                invoice_id: invoice_id,
                send_to_name: send_to_name,
                send_to_email: send_to_email,
                phone_number: phone_number,
                due_date: due_date,
                sub_total: sub_total,
                discount: discount,
                vat: vat,
                total: total,
                note: note,
                status: status,
                booking_detail: booking_detail,
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
          PopupMenuItem(
            onTap: () {
              enterInvoicePaymentBottomSheet(context: context, invoice_id: invoice_id);
            },
            child: Text(
              "Enter Payment",
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w400,
                fontSize: 16.sp,
                color: AppColor.blackColor
              ),
            )
          ),
          PopupMenuItem(
            onTap: () {
          
              finPdfService.shareInvoicePDF(
                /*bank_name: bank_details['bank'],
                account_name: bank_details['account_name'],
                account_number: bank_details['account_number'],*/
                paymentLink: paymentLink,
                context: context, 
                sender_address: service_provider_address,
                sender_phone_number: service_provider_phone_number,
                tracking_id: tracking_id,
                receiver_name: send_to_name, 
                receiver_email: send_to_email, 
                receiver_phone_number: phone_number, 
                invoice_status: status, 
                due_date: due_date, 
                grand_total: total.toString(), 
                serviceList: booking_detail, 
                subtotal: sub_total.toString(), 
                discount: discount.toString(), 
                vat: vat, 
                note: note
              );
            },
            child: Text(
              "Resend",
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w400,
                fontSize: 16.sp,
                color: AppColor.blackColor
              ),
            )
          ),
          PopupMenuItem(
            onTap: () {
              finPdfService.downloadInvoicePDFToDevice(
                context: context, 
                /*bank_name: bank_details['bank'],
                account_name: bank_details['account_name'],
                account_number: bank_details['account_number'],*/
                paymentLink: paymentLink,
                sender_address: service_provider_address,
                sender_phone_number: service_provider_phone_number,
                tracking_id: tracking_id,
                receiver_name: send_to_name, 
                receiver_email: send_to_email, 
                receiver_phone_number: phone_number, 
                invoice_status: status, 
                due_date: due_date, 
                grand_total: total.toString(), 
                serviceList: booking_detail, 
                subtotal: sub_total.toString(), 
                discount: discount.toString(), 
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
              deleteInvoiceBottomSheet(
                context: context,
                onDelete: () {
                  service.deleteInvoiceFromDB(
                    context: context, 
                    invoice_id: invoice_id
                  ).whenComplete(() => refresh);
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