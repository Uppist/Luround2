import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/financials/qoutes/drafts/drafted_quotes_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';








class ViewDraftedQuoteScreen extends StatelessWidget {
  ViewDraftedQuoteScreen({super.key, required this.quote_id, required this.send_to_name, required this.send_to_email, required this.phone_number, required this.due_date, required this.quote_date, required this.sub_total, required this.discount, required this.vat, required this.total, required this.appointment_type, required this.status, required this.note, required this.service_provider, required this.product_details, required this.tracking_id});
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

  
  var controller = Get.put(DraftedQuotesController());

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
                        "Quote Preview",
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
                            service_provider['phone_number'],
                            style: GoogleFonts.inter(
                              color: AppColor.darkGreyColor.withOpacity(0.6),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400
                            ),
                          ),
                          SizedBox(height: 10.h,),
                          Text(
                            service_provider['address'],
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
                            "Quote Details",
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
                                "Quote number:",
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
                                              item["duration"],
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