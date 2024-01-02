import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/financials/invoice/unpaid/unpaid_invoice_controller.dart';
import 'package:luround/utils/colors/app_theme.dart';








class ViewUnpaidInvoiceScreen extends StatelessWidget {
  ViewUnpaidInvoiceScreen({super.key});

  var controller = Get.put(UnpaidInvoiceController());

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
                            "Japhet Alvin",
                            style: GoogleFonts.inter(
                              color: AppColor.darkGreyColor,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          SizedBox(height: 10.h,),
                          Text(
                            "jay@gmail.com",
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
                            "John Wick",
                            style: GoogleFonts.inter(
                              color: AppColor.darkGreyColor,
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          SizedBox(height: 10.h,),
                          Text(
                            "johnwick@gmail.com",
                            style: GoogleFonts.inter(
                              color: AppColor.darkGreyColor.withOpacity(0.6),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w400
                            ),
                          ),
                          SizedBox(height: 10.h,),
                          Text(
                            "+234 7040571471",
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
                                width: 65.w,
                                height: 30.h,
                                decoration: BoxDecoration(
                                  color: AppColor.bgColor,
                                  borderRadius: BorderRadius.circular(7.r),
                                  border: Border.all(color: AppColor.redColor)
                                ),
                                child: Text(
                                  'UNPAID',
                                  style: GoogleFonts.inter(
                                    color: AppColor.redColor,
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
                                '#00000001',
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
                                '2023-04-12',
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
                                'N28,000',
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
                                  itemCount: 2,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 15.h,),
                                        Text(
                                          "Personal Training",
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
                                              'In-Person',
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
                                              'N20,000',
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
                                              '30mins',
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
                                              'N1,000',
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
                                              'N24,000',
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
                                'N20,000',
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
                                'N1,500',
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
                                'N900',
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
                                'N50,000',
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
                                      "gfhghchgchgjgjBLFY",
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