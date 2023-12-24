import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/services/account_owner/more/transactions/transaction_pdf_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/reusable_button.dart';
import 'package:luround/views/account_owner/more/widget/transactions/trx_screen/transactions_screen.dart';





class WithdrawalReceipt extends StatelessWidget {
  WithdrawalReceipt({super.key});

  var pdfService = Get.put(TransactionPdfService());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.darkMainColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          physics: BouncingScrollPhysics(),
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
                        'Withdrawal Receipt',
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
                        Text(
                          'Jane Cooper',
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
                          'Account number:',
                          style: GoogleFonts.inter(
                            color: AppColor.textGreyColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        Text(
                          '12345678',
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
                          'Sunday, 28th Dec, 2023',
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
                          '07:30 AM',
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
                        Text(
                          'Wth123565',
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

                    SizedBox(height: 20.h,),
                    
                    //Amount
                    Center(
                      child: Text(
                        'N5,000',
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
                  await pdfService.writeTrxPdf()
                  .whenComplete(() => pdfService.saveThePdf(context: context));
                }
              ),
              SizedBox(height: 20.h,),
              TextButton(
                onPressed: () {
                  Get.offUntil(GetPageRoute(page: () => TransactionPage()), (route) => true);
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