import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/main.dart';
import 'package:luround/services/account_owner/data_service/local_storage/local_storage.dart';
import 'package:luround/services/account_owner/more/transactions/transaction_pdf_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/converters.dart';
import 'package:luround/utils/components/reusable_button.dart';
import 'package:luround/views/account_owner/mainpage/screen/mainpage.dart';







class WithdrawalReceipt extends StatelessWidget {
  WithdrawalReceipt({super.key, required this.account_name, required this.account_number, required this.bank_name, required this.remark, required this.transaction_ref, required this.transaction_date, required this.transaction_time, required this.amount});
  final String account_name;
  final String account_number;
  final String bank_name;
  final String remark;
  final String transaction_ref;
  final String transaction_date;
  final String transaction_time;
  final String amount;

  final pdfService = Get.put(TransactionPdfService());
  String localStorage = LocalStorage.getUsername();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.darkMainColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 40.h,),
              Text(
                'Withdrawal Receipt',
                style: GoogleFonts.inter(
                  color: AppColor.bgColor,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600
                ),
              ),
              SizedBox(height: 20.h,),
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
                decoration: BoxDecoration(
                  color: AppColor.bgColor,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Withdrawal Details',
                        style: GoogleFonts.inter(
                          color: AppColor.blackColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h,),
                    //Row 1
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Account name:',
                          style: GoogleFonts.inter(
                            color: AppColor.textGreyColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        SizedBox(width: 20.w,),
                        Expanded(
                          child: Text(
                            account_name,
                            style: GoogleFonts.inter(
                              color: AppColor.blackColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h,),
                    Divider(color: Colors.grey.withOpacity(0.6), thickness: 1,),

                    SizedBox(height: 10.h,),

                    //Row 2
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Account number:',
                          style: GoogleFonts.inter(
                            color: AppColor.textGreyColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        Text(
                          account_number,
                          style: GoogleFonts.inter(
                            color: AppColor.blackColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h,),
                    Divider(color: Colors.grey.withOpacity(0.6), thickness: 1,),

                    SizedBox(height: 10.h,),

                    //Row 3
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Date:',
                          style: GoogleFonts.inter(
                            color: AppColor.textGreyColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        Text(
                          transformDateString(transaction_date),
                          style: GoogleFonts.inter(
                            color: AppColor.blackColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h,),
                    Divider(color: Colors.grey.withOpacity(0.6), thickness: 1,),

                    SizedBox(height: 10.h,),

                    //Row 4
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Time:',
                          style: GoogleFonts.inter(
                            color: AppColor.textGreyColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        Text(
                          extractTimeIn12HourFormat(transaction_time),
                          style: GoogleFonts.inter(
                            color: AppColor.blackColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h,),
                    Divider(color: Colors.grey.withOpacity(0.6), thickness: 1,),

                    SizedBox(height: 10.h,),

                    //Row 2
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Reference code:',
                          style: GoogleFonts.inter(
                            color: AppColor.textGreyColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        SizedBox(width: 20.w,),
                        Expanded(
                          child: Text(
                            transaction_ref,
                            style: GoogleFonts.inter(
                              color: AppColor.blackColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h,),
                    
                    Divider(color: Colors.grey.withOpacity(0.6), thickness: 1,),

                    SizedBox(height: 20.h,),
                    
                    //Amount
                    Center(
                      child: Text(
                        "${currency(context).currencySymbol}$amount",
                        style: GoogleFonts.inter(
                          color: AppColor.darkMainColor,
                          fontSize: 36.sp,
                          fontWeight: FontWeight.w700
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h,),

                  ],
                ),
              ),
              SizedBox(height: 60.h,),
              ReusableButton(
                color: AppColor.navyBlue, 
                text: 'Download Receipt', 
                onPressed: () async{
                  await pdfService.writeTrxPdf(
                    account_name: account_name,
                    account_number: account_number,
                    bank_name: bank_name,
                    remark: remark,
                    transaction_ref: transaction_ref,
                    transaction_date: transformDateString(transaction_date),
                    transaction_time: extractTimeIn12HourFormat(transaction_time),
                    amount: amount
                  )
                  .whenComplete(() => pdfService.saveThePdf(context: context));
                }
              ),
              SizedBox(height: 20.h,),
              TextButton(
                onPressed: () {
                  Get.offAll(() => const MainPage());
                }, 
                child: Text(
                  'Exit page',
                  style: GoogleFonts.inter(
                    color: AppColor.bgColor,
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColor.bgColor
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}