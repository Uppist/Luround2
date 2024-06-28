import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/services/account_owner/more/financials/financials_pdf_service.dart';
import 'package:luround/services/account_owner/more/financials/financials_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/screen/quotes_screen/sent_qoutes/view_sent_quote_screen.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/screen_widgets/financials_content/dropdowns/quotes/convert_to_invoice/convert_to_invoice_screen.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/screen_widgets/financials_content/quotes_contents/delete_quote/delete_quote.dart';









class QuoteDropDown extends StatelessWidget {
  QuoteDropDown({super.key, required this.quote_id, required this.send_to_name, required this.send_to_email, required this.phone_number, required this.due_date, required this.quote_date, required this.sub_total, required this.discount, required this.vat, required this.total, required this.appointment_type, required this.status, required this.note, required this.service_provider, required this.product_details, required this.service_provider_address, required this.service_provider_phone_number, required this.tracking_id, required this.bank_details, required this.refresh,});
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
  final String service_provider_address;
  final String service_provider_phone_number;
  final Map<String, dynamic> service_provider;
  final List<dynamic> product_details;
  final String tracking_id;
  //service provider bank details here
  final Map<String, dynamic> bank_details;
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
              Get.to(() => ViewSentQuoteScreen(
                bank_details: bank_details,
                quote_id: quote_id, 
                tracking_id: tracking_id,
                send_to_name: send_to_name,
                send_to_email: send_to_email,
                phone_number: phone_number,
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
                product_details: product_details
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
              finPdfService.shareQuotePDF(
                context: context,
                tracking_id: tracking_id,
                sender_address: service_provider_address,
                sender_phone_number: service_provider_phone_number,
                receiver_name: send_to_name, 
                receiver_email: send_to_email, 
                receiver_phone_number: phone_number, 
                quote_status: status,
                due_date: due_date, 
                grand_total: total, 
                serviceList: product_details, 
                subtotal: sub_total, 
                discount: discount, 
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
              finPdfService.downloadQuotePDFToDevice(
                context: context,
                sender_address: service_provider_address,
                sender_phone_number: service_provider_phone_number,
                tracking_id: tracking_id,
                receiver_name: send_to_name, 
                receiver_email: send_to_email, 
                receiver_phone_number: phone_number, 
                quote_status: status,
                due_date: due_date, 
                grand_total: total, 
                serviceList: product_details, 
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
              Get.to(() => ConvertQuoteToInvoiceScreen(
                bank_details: bank_details,
                tracking_id: tracking_id,
                quote_id: quote_date, 
                send_to_name: send_to_name,
                send_to_email: send_to_email,
                service_provider_address: service_provider_address,
                service_provider_phone_number: service_provider_phone_number,
                phone_number:phone_number,
                due_date: due_date,
                qoute_date: quote_date,
                //quote_date: quote_date,
                sub_total: sub_total,
                discount: discount,
                vat: vat,
                total: total,
                appointment_type: appointment_type,
                status: status,
                note: note,
                service_provider: service_provider,
                product_details: product_details, 
                paymentLink: '',
              ));
            },
            child: Text(
              "Convert To Invoice",
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w400,
                fontSize: 16.sp,
                color: AppColor.blackColor
              ),
            )
          ),
          PopupMenuItem(
            onTap: () {
              deleteQuoteBottomSheet(
                context: context,
                onDelete: () {
                  service.deleteQuoteFromDB(
                    context: context, 
                    quote_id: quote_id
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