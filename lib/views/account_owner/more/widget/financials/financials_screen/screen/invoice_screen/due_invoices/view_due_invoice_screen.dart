import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/financials/invoice/due/due_invoice_controller.dart';
import 'package:luround/services/account_owner/data_service/local_storage/local_storage.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/copy_to_clipboard.dart';








class ViewDueInvoiceScreen extends StatelessWidget {
  ViewDueInvoiceScreen({super.key, required this.onPressed, required this.invoice_id, required this.send_to_name, required this.send_to_email, required this.phone_number, required this.due_date, required this.sub_total, required this.discount, required this.vat, required this.total, required this.note, required this.status, required this.booking_detail, required this.service_provider_phone_number, required this.service_provider_address, required this.tracking_id, required this.bank_details});
  final VoidCallback onPressed;
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
  final String service_provider_phone_number;
  final String service_provider_address;
  final List<dynamic> booking_detail;
  final String tracking_id;
  final Map<String, dynamic> bank_details;

  

  var controller = Get.put(DueInvoiceController());
  var userName = LocalStorage.getUsername();
  var userEmail = LocalStorage.getUseremail();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.greyColor,
      body: Container(
        child: Column(
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
                            "Bill from:",
                            style: GoogleFonts.inter(
                              color: AppColor.darkGreyColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600
                            ),
                          ),
                          SizedBox(height: 10.h,),
                          Text(
                            userName,
                            style: GoogleFonts.inter(
                              color: AppColor.darkGreyColor,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          SizedBox(height: 10.h,),
                          Text(
                            userEmail,
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
                              fontWeight: FontWeight.w400
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
                            "Bill to:",
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
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                //width: 60.w,
                                height: 40.h,
                                decoration: BoxDecoration(
                                  color: AppColor.bgColor,
                                  borderRadius: BorderRadius.circular(7.r),
                                  border: Border.all(color: AppColor.yellowStar)
                                ),
                                child: Text(
                                  status,
                                  style: GoogleFonts.inter(
                                    color: AppColor.yellowStar,
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
                                tracking_id,
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
                            controller.isServiceTapped.value = !controller.isServiceTapped.value;
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
                                    controller.isServiceTapped.value
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
                                controller.isServiceTapped.value ? ListView.separated(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  separatorBuilder: (context, index) => SizedBox(height: 10.h,),
                                  itemCount: booking_detail.length,
                                  itemBuilder: (context, index) {
                                    final item = booking_detail[index];
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 15.h,),
                                        Text(
                                          item['service_name']  ?? "no service name",
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
                                              item['appointment_type'],
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

                    //INVOICE DISCOUNT AND GRAND TOTAL CONTAINER
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
                                '$discount%',
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
                            controller.isNoteTapped.value = !controller.isNoteTapped.value;
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
                                    controller.isNoteTapped.value
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
                                controller.isNoteTapped.value 
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

                    SizedBox(height: 20.h),
                    //PAYMENT CONTAINER//////////////////
                    Container(
                      //alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                      width: double.infinity,
                      color: AppColor.bgColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Payment",
                            style: GoogleFonts.inter(
                              color: AppColor.darkGreyColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600
                            )
                          ),
                          SizedBox(height: 10.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SvgPicture.asset("assets/svg/bank.svg"),
                              SizedBox(width: 20.w,),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      bank_details['account_name'],
                                      style: GoogleFonts.inter(
                                        color: AppColor.blackColor,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w500
                                      ),
                                    ),
                                    SizedBox(height: 5.h,),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${bank_details['bank']} | ${bank_details['account_number']}",
                                          style: GoogleFonts.inter(
                                            color: AppColor.darkGreyColor,
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w400
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            copyToClipboard(
                                              text: bank_details['account_number'], 
                                              snackMessage: "account number copied to clipboard", 
                                              context: context
                                            );
                                          },
                                          child: SvgPicture.asset("assets/svg/copy_link.svg"),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ]
                      )
                    )
                    /////////////////////////////////////////////
                              

                  ],
                ),
              ),
            ),
          ]
        )
      )
    );
  }
}