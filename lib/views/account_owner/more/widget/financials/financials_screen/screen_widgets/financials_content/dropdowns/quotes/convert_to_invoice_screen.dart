import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/services/account_owner/more/financials/financials_pdf_service.dart';
import 'package:luround/services/account_owner/more/financials/financials_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/reusable_button.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/create_invoice/widgets/create_invoice_widgets/send_invoice_bottomsheet.dart';








class ConvertQuoteToInvoiceScreen extends StatelessWidget {
  ConvertQuoteToInvoiceScreen({super.key, required this.quote_id, required this.send_to_name, required this.send_to_email, required this.phone_number, required this.due_date, required this.sub_total, required this.discount, required this.vat, required this.total, required this.appointment_type, required this.status, required this.note, required this.service_provider, required this.product_details, required this.qoute_date, required this.service_provider_phone_number, required this.service_provider_address});
  final String quote_id;
  final String send_to_name;
  final String send_to_email;
  final String phone_number;
  final String due_date;
  final String qoute_date;
  final String sub_total;
  final String discount;
  final String vat;
  final String total;
  final String appointment_type;
  final String status;
  final String note;
  final String service_provider_phone_number;
  final String service_provider_address;
  final Map<String, dynamic> service_provider;
  final List<dynamic> product_details;


  var service = Get.put(FinancialsService());
  var finPdfService = Get.put(FinancialsPdfService());
  int randNum = Random().nextInt(2000000);
  var isServiceTapped = false.obs;
  var isNoteTapped = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.greyColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
         
          ///Navigation Section////////////////
          Container(
            padding: EdgeInsets.symmetric(horizontal: 7.w,),
            //height: 70, //65
            width: double.infinity,
            color: AppColor.bgColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.h,),                   
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(
                        CupertinoIcons.xmark,
                        color: AppColor.blackColor,
                      )
                    ),
                    SizedBox(width: 100.w,),
                    Text(
                      "Invoice Preview",
                      style: GoogleFonts.inter(
                        color: AppColor.darkGreyColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                  ],
                ),                                
              ],
            ),
          ),
          ////////////////////////////////////////////////
          //SizedBox(height: 20.h,),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              physics: BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //SENDER'S CONTAINER
                  Container(
                    //alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                    width: double.infinity,
                    color: AppColor.bgColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sent from:",
                          style: GoogleFonts.inter(
                            color: AppColor.darkGreyColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                        SizedBox(height: 10.h,),
                        Text(
                          service_provider['name'],
                          style: GoogleFonts.inter(
                            color: AppColor.darkGreyColor,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        SizedBox(height: 10.h,),
                        Text(
                          service_provider['email'],
                          style: GoogleFonts.inter(
                            color: AppColor.darkGreyColor.withOpacity(0.6),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400
                          ),
                        ),
                        SizedBox(height: 10.h,),
                        Text(
                          service_provider_phone_number,
                          style: GoogleFonts.inter(
                            color: AppColor.darkGreyColor.withOpacity(0.6),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        SizedBox(height: 10.h,),
                        Text(
                          service_provider_address,
                          style: GoogleFonts.inter(
                            color: AppColor.darkGreyColor.withOpacity(0.6),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h,),
      
                  //RECEIVER'S CONTAINER
                  Container(
                    //alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                    width: double.infinity,
                    color: AppColor.bgColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sent to:",
                          style: GoogleFonts.inter(
                            color: AppColor.darkGreyColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                        SizedBox(height: 10.h,),
                        Text(
                          send_to_name,
                          style: GoogleFonts.inter(
                            color: AppColor.darkGreyColor,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        SizedBox(height: 10.h,),
                        Text(
                          send_to_email,
                          style: GoogleFonts.inter(
                            color: AppColor.darkGreyColor.withOpacity(0.6),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400
                          ),
                        ),
                        SizedBox(height: 10.h,),
                        Text(
                          phone_number,
                          style: GoogleFonts.inter(
                            color: AppColor.darkGreyColor.withOpacity(0.6),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400
                          ),
                        ),
                      ],
                    ),
                  ),
      
                  SizedBox(height: 20.h,),
      
                  //QUOTES DETAILS CONTAINER
                  Container(
                    //alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                    width: double.infinity,
                    color: AppColor.bgColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Invoice Details",
                          style: GoogleFonts.inter(
                            color: AppColor.darkGreyColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                        SizedBox(height: 10.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Status:",
                              style: GoogleFonts.inter(
                                color: AppColor.darkGreyColor.withOpacity(0.6),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: 60.w,
                              height: 30.h,
                              decoration: BoxDecoration(
                                color: AppColor.navyBlue,
                                borderRadius: BorderRadius.circular(7.r)
                              ),
                              child: Text(
                                status,
                                style: GoogleFonts.inter(
                                  color: AppColor.bgColor,
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w500
                                )
                              ),
                            ),                    
                          ],
                        ),
                        SizedBox(height: 20.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Invoice number:",
                              style: GoogleFonts.inter(
                                color: AppColor.darkGreyColor.withOpacity(0.6),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                            Text(
                              '#$randNum',
                              style: GoogleFonts.inter(
                                color: AppColor.darkGreyColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500
                              )
                            ),
                            
                          ],
                        ),
                        SizedBox(height: 20.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Valid till:",
                              style: GoogleFonts.inter(
                                color: AppColor.darkGreyColor.withOpacity(0.6),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                            Text(
                              due_date,
                              style: GoogleFonts.inter(
                                color: AppColor.darkGreyColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500
                              )
                            ),
                            
                          ],
                        ),
                        SizedBox(height: 20.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Grand total:",
                              style: GoogleFonts.inter(
                                color: AppColor.darkGreyColor.withOpacity(0.6),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                            Text(
                              'N$total',
                              style: GoogleFonts.inter(
                                color: AppColor.darkGreyColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500
                              )
                            ),
                            
                          ],
                        ),
      
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h,),
      
                  //PRODUCTS/SERVICES LIST
                  Obx(
                    () {
                      return InkWell(
                        onTap: () {
                          isServiceTapped.value = !isServiceTapped.value;
                        },
                        child: Container(
                          //alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                          width: double.infinity,
                          color: AppColor.bgColor,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Products/Services",
                                    style: GoogleFonts.inter(
                                      color: AppColor.darkGreyColor,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600
                                    ),
                                  ),
                                  isServiceTapped.value
                                  ?Icon(
                                    CupertinoIcons.chevron_down,
                                    color: AppColor.blackColor,
                                  )
                                  :Icon(
                                    CupertinoIcons.chevron_forward,
                                    color: AppColor.blackColor,
                                  )
                                ],
                              ),
                              //LIST OF PRODUCTS
                              isServiceTapped.value ? ListView.separated(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                separatorBuilder: (context, index) => SizedBox(height: 10.h,),
                                itemCount: product_details.length,
                                itemBuilder: (context, index) {
                                  final item = product_details[index];
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 15.h,),
                                      Text(
                                        item['service_name'],
                                        style: GoogleFonts.inter(
                                          color: AppColor.darkGreyColor,
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w600
                                        ),
                                      ),
                                      SizedBox(height: 10.h,),
                                      Divider(color: AppColor.darkGreyColor.withOpacity(0.6), thickness: 0.5,),
                                      SizedBox(height: 10.h,),
                                      //row1
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Meeting Type:",
                                            style: GoogleFonts.inter(
                                              color: AppColor.darkGreyColor.withOpacity(0.6),
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w500
                                            ),
                                          ),
                                          Text(
                                            item['meeting_type'],
                                            style: GoogleFonts.inter(
                                              color: AppColor.darkGreyColor,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500
                                            )
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10.h,),
                                      //row2
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Rate:",
                                            style: GoogleFonts.inter(
                                              color: AppColor.darkGreyColor.withOpacity(0.6),
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w500
                                            ),
                                          ),
                                          Text(
                                            'N${item['rate']}',
                                            style: GoogleFonts.inter(
                                              color: AppColor.darkGreyColor,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500
                                            )
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10.h,),
                                      //row3
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Duration:",
                                            style: GoogleFonts.inter(
                                              color: AppColor.darkGreyColor.withOpacity(0.6),
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w500
                                            ),
                                          ),
                                          Text(
                                            item['duration'],
                                            style: GoogleFonts.inter(
                                              color: AppColor.darkGreyColor,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500
                                            )
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10.h,),
                                      //row4
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Discount:",
                                            style: GoogleFonts.inter(
                                              color: AppColor.darkGreyColor.withOpacity(0.6),
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w500
                                            ),
                                          ),
                                          Text(
                                            '${item['discount']}%',
                                            style: GoogleFonts.inter(
                                              color: AppColor.darkGreyColor,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500
                                            )
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10.h,),
                                      //row5
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Total:",
                                            style: GoogleFonts.inter(
                                              color: AppColor.darkGreyColor.withOpacity(0.6),
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w500
                                            ),
                                          ),
                                          Text(
                                            'N${item['total']}',
                                            style: GoogleFonts.inter(
                                              color: AppColor.darkGreyColor,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500
                                            )
                                          ),
                                        ],
                                      ),
      
                                    ],
                                  );
                                }
                              ) : SizedBox(),
                        
                            ]
                          )
                        ),
                      );
                    }
                  ),
      
                  SizedBox(height: 20.h),
      
                  //QUOTES DISCOUNT AND GRAND TOTAL CONTAINER
                  Container(
                    //alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                    width: double.infinity,
                    color: AppColor.bgColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Subtotal",
                              style: GoogleFonts.inter(
                                color: AppColor.darkGreyColor.withOpacity(0.6),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                            Text(
                              'N$sub_total',
                              style: GoogleFonts.inter(
                                color: AppColor.darkGreyColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500
                              )
                            ),
                            
                          ],
                        ),
                        SizedBox(height: 20.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Discount",
                              style: GoogleFonts.inter(
                                color: AppColor.darkGreyColor.withOpacity(0.6),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                            Text(
                              "$discount%",
                              style: GoogleFonts.inter(
                                color: AppColor.darkGreyColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500
                              )
                            ),
                            
                          ],
                        ),
                        SizedBox(height: 20.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "VAT",
                              style: GoogleFonts.inter(
                                color: AppColor.darkGreyColor.withOpacity(0.6),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                            Text(
                              'N$vat',
                              style: GoogleFonts.inter(
                                color: AppColor.darkGreyColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500
                              )
                            ),
                            
                          ],
                        ),
                        SizedBox(height: 20.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total",
                              style: GoogleFonts.inter(
                                color: AppColor.darkGreyColor.withOpacity(0.6),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                            Text(
                              'N$total',
                              style: GoogleFonts.inter(
                                color: AppColor.darkGreyColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500
                              )
                            ),
                            
                          ],
                        ),
      
                      ],
                    ),
                  ),
      
                  SizedBox(height: 20.h),
      
      
                  //VIEW NOTE CONTAINER
                  Obx(
                    () {
                      return InkWell(
                        onTap: () {
                          isNoteTapped.value = !isNoteTapped.value;
                        },
                        child: Container(
                          //alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                          width: double.infinity,
                          color: AppColor.bgColor,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Note",
                                    style: GoogleFonts.inter(
                                      color: AppColor.darkGreyColor,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600
                                    ),
                                  ),
                                  isNoteTapped.value
                                  ?Icon(
                                    CupertinoIcons.chevron_down,
                                    color: AppColor.blackColor,
                                  )
                                  :Icon(
                                    CupertinoIcons.chevron_forward,
                                    color: AppColor.blackColor,
                                  )
                                ],
                              ),
                              //Note text
                              isNoteTapped.value 
                              ?Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10.h,),
                                  Text(
                                    note,
                                    style: GoogleFonts.inter(
                                      color: AppColor.darkGreyColor,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400
                                    ),
                                  ),
                                ],
                              )
                              :SizedBox(),
                            ]
                          )
                        )
                      );
                    }
                  ),

                  SizedBox(height: 30.h,),
                  ReusableButton(
                    color: AppColor.mainColor,
                    text: 'Share Invoice',
                    onPressed: () {
                        sendInvoiceBottomSheet(
                          context: context,
                          onShare: () {
                          service.createNewInvoiceAndSendToClient(
                            context: context, 
                            client_name: send_to_name, 
                            client_email: send_to_email,
                            client_phone_number: phone_number,
                            note: note,
                            invoice_date: qoute_date, 
                            due_date: due_date,

                            vat: vat,
                            sub_total: sub_total,
                            discount: discount,
                            total: total,
                            booking_detail: product_details
                          ).whenComplete(() {
                            finPdfService.shareInvoicePDF(
                              sender_address: service_provider_address,
                              sender_phone_number: service_provider_phone_number,
                              context: context,
                              invoiceNumber: randNum,
                              receiver_email: send_to_email,
                              receiver_name: send_to_name,
                              receiver_phone_number: phone_number,
                              invoice_status: "UNPAID",
                              due_date: due_date,
                              subtotal: sub_total,
                              discount: discount,
                              vat: vat,
                              note: note,
                              grand_total: total,
                              serviceList: product_details,
                            ).whenComplete(() {   
                              Get.back();
                            });
                          });                       
                        },
                        onSave: () {
                          service.createNewInvoiceAndSaveToDB(
                            context: context, 
                            client_name: send_to_name, 
                            client_email: send_to_email,
                            client_phone_number: phone_number,
                            note: note,
                            invoice_date: qoute_date, 
                            due_date: due_date,

                            vat: vat,
                            sub_total: sub_total,
                            discount: discount,
                            total: total,
                            booking_detail: product_details
                          ).whenComplete(() { 
                            Get.back();
                          });
                        },
                        onDownload: () {
                          finPdfService.downloadInvoicePDFToDevice(
                            context: context,
                            sender_address: service_provider_address,
                            sender_phone_number: service_provider_phone_number,
                            invoiceNumber: randNum,
                            receiver_email: send_to_email,
                            receiver_name: send_to_name,
                            receiver_phone_number: phone_number,
                            invoice_status: "UNPAID",
                            due_date: due_date,
                            subtotal: sub_total,
                            discount: discount,
                            vat: vat,
                            note: note,
                            grand_total: total,
                            serviceList: product_details,
                          ).whenComplete(() {
                            Get.back();
                          });
                        },
                      );
                    },
                  ),

                  SizedBox(height: 20.h,),
                            
      
                ],
              ),
            ),
          ),
        ]
      )
    );
  }
}