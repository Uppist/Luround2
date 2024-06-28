import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/services/account_owner/more/financials/financials_pdf_service.dart';
import 'package:luround/services/account_owner/more/financials/financials_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/copy_to_clipboard.dart';
import 'package:luround/utils/components/reusable_button.dart';
import 'package:luround/utils/components/utils_textfield.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/create_invoice/widgets/create_invoice_widgets/send_invoice_bottomsheet.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/screen_widgets/financials_content/dropdowns/quotes/convert_to_invoice/ctv_textfield.dart';








class ConvertQuoteToInvoiceScreen extends StatefulWidget {
  const ConvertQuoteToInvoiceScreen({super.key, required this.quote_id, required this.send_to_name, required this.send_to_email, required this.phone_number, required this.due_date, required this.sub_total, required this.discount, required this.vat, required this.total, required this.appointment_type, required this.status, required this.note, required this.service_provider, required this.product_details, required this.qoute_date, required this.service_provider_phone_number, required this.service_provider_address, required this.tracking_id, required this.bank_details, required this.paymentLink});
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
  final String tracking_id;
  //service provider bank details here
  final String paymentLink;
  final Map<String, dynamic> bank_details;


  @override
  State<ConvertQuoteToInvoiceScreen> createState() => _ConvertQuoteToInvoiceScreenState();
}

class _ConvertQuoteToInvoiceScreenState extends State<ConvertQuoteToInvoiceScreen> {
  var service = Get.put(FinancialsService());

  var finPdfService = Get.put(FinancialsPdfService());

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
                          widget.service_provider['name'],
                          style: GoogleFonts.inter(
                            color: AppColor.darkGreyColor,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        SizedBox(height: 10.h,),
                        Text(
                          widget.service_provider['email'],
                          style: GoogleFonts.inter(
                            color: AppColor.darkGreyColor.withOpacity(0.6),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400
                          ),
                        ),
                        SizedBox(height: 10.h,),
                        Text(
                          widget.service_provider_phone_number,
                          style: GoogleFonts.inter(
                            color: AppColor.darkGreyColor.withOpacity(0.6),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        SizedBox(height: 10.h,),
                        Text(
                          widget.service_provider_address,
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
                          widget.send_to_name,
                          style: GoogleFonts.inter(
                            color: AppColor.darkGreyColor,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        SizedBox(height: 10.h,),
                        Text(
                          widget.send_to_email,
                          style: GoogleFonts.inter(
                            color: AppColor.darkGreyColor.withOpacity(0.6),
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400
                          ),
                        ),
                        SizedBox(height: 10.h,),
                        Text(
                          widget.phone_number,
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
                                widget.status,
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
                              widget.tracking_id,
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
                            Expanded(
                              child: Text(
                                "Valid till:",
                                style: GoogleFonts.inter(
                                  color: AppColor.darkGreyColor.withOpacity(0.6),
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                            ),
                            CTVDueDateTextField(
                              initialValue: widget.due_date,
                              onFieldSubmitted: (val) {
                                service.ctvdueDateController.text = val;
                                print("ctv due date: ${service.ctvdueDateController.text}");
                              },
                              hintText: "Enter due date",
                              keyboardType: TextInputType.datetime,
                              textInputAction: TextInputAction.next,
                            )
                            /*Text(
                              due_date,
                              style: GoogleFonts.inter(
                                color: AppColor.darkGreyColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500
                              )
                            ),*/
                            
                          ],
                        ),
                        SizedBox(height: 20.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Quote Grand Total:",
                              style: GoogleFonts.inter(
                                color: AppColor.darkGreyColor.withOpacity(0.6),
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                            Text(
                              'N${widget.total}',
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
                                itemCount: widget.product_details.length,
                                itemBuilder: (context, index) {
                                  final item = widget.product_details[index];
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
                              "Invoice Subtotal",
                              style: GoogleFonts.inter(
                                color: AppColor.darkGreyColor.withOpacity(0.6),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                            Text(
                              'N${widget.sub_total}',
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
                            CTVDueDateTextField(
                              initialValue: widget.discount,
                              onFieldSubmitted: (val) {
                                // Check if the entered text is a valid integer
                                if (val.isNotEmpty && double.tryParse(val) != null) {
                                  setState(() {
                                    // If it's an integer, append ".0" to the text
                                    if (!val.contains('.')) {
                                      service.ctvdiscountController.text = "$val.0";
                                      print("ctv discount: ${service.ctvdiscountController.text}");
                                    }
                                  });
                                }

                                //calculate all the values below (vat, and Grand Total)
                                service.calculateCTVDiscount(
                                  context: context,
                                  initialDiscountValue: widget.discount,
                                  initialSubTotal: widget.sub_total
                                );

                              },
                              hintText: "Enter Discount",
                              keyboardType: TextInputType.number,
                              textInputAction: TextInputAction.done,
                            )
                            /*Text(
                              "$discount%",
                              style: GoogleFonts.inter(
                                color: AppColor.darkGreyColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500
                              )
                            ),*/
                            
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

                            Obx(
                              () {
                                return Text(
                                  service.reactiveCTVVAT.isNotEmpty ? "N${service.reactiveCTVVAT.value}" :'N${widget.vat}',
                                  style: GoogleFonts.inter(
                                    color: AppColor.darkGreyColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500
                                  )
                                );
                                
                              }
                            ),
                            
                          ],
                        ),
                        SizedBox(height: 20.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Invoice Grand Total",
                              style: GoogleFonts.inter(
                                color: AppColor.darkGreyColor.withOpacity(0.6),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                            Obx(
                              () {
                                return Text(
                                  service.reactiveCTVGrandTotal.isNotEmpty ? "N${service.reactiveCTVGrandTotal.value}" : 'N${widget.total}',
                                  style: GoogleFonts.inter(
                                    color: AppColor.darkGreyColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500
                                  )
                                );
                                
                              }
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
                                  SizedBox(height: 20.h,),
                                  UtilsTextField2(
                                    initialValue: widget.note,
                                    onChanged: (val) {
                                      setState(() {
                                        service.ctvnoteController.text = val;
                                        debugPrint(service.ctvnoteController.text);
                                      });
                                    },                    
                                    hintText: "Write a short note for the recipient.",
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.done,
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
                                    widget.bank_details['account_name'],
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
                                        "${widget.bank_details['bank']} | ${widget.bank_details['account_number']}",
                                        style: GoogleFonts.inter(
                                          color: AppColor.darkGreyColor,
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w400
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          copyToClipboard(
                                            text: widget.bank_details['account_number'], 
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
                  ),
                  /////////////////////////////////////////////

                  SizedBox(height: 30.h,),
                  ReusableButton(
                    color: AppColor.mainColor,
                    text: 'Share Invoice',
                    onPressed: () {
                        sendInvoiceBottomSheet(
                          context: context,
                          onShare: () {
                          service.createNewInvoiceAndSendToClientMarkTrue(
                            context: context, 
                            /*bank_name: widget.bank_details['bank'],
                            account_name: widget.bank_details['account_name'],
                            account_number: widget.bank_details['account_number'],*/
                            client_name: widget.send_to_name, 
                            client_email: widget.send_to_email,
                            client_phone_number: widget.phone_number,
                            note: service.ctvnoteController.text.isNotEmpty ? service.ctvnoteController.text : widget.note,
                            invoice_date: widget.qoute_date, 
                            due_date: service.ctvdueDateController.text.isNotEmpty ? service.ctvdueDateController.text : widget.due_date,

                            vat: service.reactiveCTVVAT.value.isNotEmpty ? service.reactiveCTVVAT.value : widget.vat,
                            sub_total: widget.sub_total,
                            discount: service.ctvdiscountController.text.isNotEmpty ? service.ctvdiscountController.text : widget.discount,
                            total: service.reactiveCTVGrandTotal.isNotEmpty ? service.reactiveCTVGrandTotal.value : widget.total,
                            booking_detail: widget.product_details
                          ).whenComplete(() {
                            print("sent");
                            //Get.back();
                          });                       
                        },
                        onSave: () {
                          service.createNewInvoiceAndSaveToDB(
                            /*bank_name: widget.bank_details['bank'],
                            account_name: widget.bank_details['account_name'],
                            account_number: widget.bank_details['account_number'],*/
                            context: context, 
                            client_name: widget.send_to_name, 
                            client_email: widget.send_to_email,
                            client_phone_number: widget.phone_number,
                            note: service.ctvnoteController.text.isNotEmpty ? service.ctvnoteController.text : widget.note,
                            invoice_date: widget.qoute_date, 
                            due_date: service.ctvdueDateController.text.isNotEmpty ? service.ctvdueDateController.text : widget.due_date,

                            vat: service.reactiveCTVVAT.value.isNotEmpty ? service.reactiveCTVVAT.value : widget.vat,
                            sub_total: widget.sub_total,
                            discount: service.ctvdiscountController.text.isNotEmpty ? service.ctvdiscountController.text : widget.discount,
                            total: service.reactiveCTVGrandTotal.isNotEmpty ? service.reactiveCTVGrandTotal.value : widget.total,
                            booking_detail: widget.product_details
                          ).whenComplete(() { 
                            setState(() {
                              service.reactiveCTVVAT.value = "";
                              service.reactiveCTVGrandTotal.value = "";
                            });
                            Get.back();
                          });
                        },
                        onDownload: () {
                          finPdfService.downloadInvoicePDFToDevice(
                            /*bank_name: widget.bank_details['bank'],
                            account_name: widget.bank_details['account_name'],
                            account_number: widget.bank_details['account_number'],*/
                            paymentLink: widget.paymentLink,
                            context: context,
                            sender_address: widget.service_provider_address,
                            sender_phone_number: widget.service_provider_phone_number,
                            tracking_id: widget.tracking_id,
                            receiver_email: widget.send_to_email,
                            receiver_name: widget.send_to_name,
                            receiver_phone_number: widget.phone_number,
                            invoice_status: "UNPAID",
                            due_date: service.ctvdueDateController.text.isNotEmpty ? service.ctvdueDateController.text : widget.due_date,
                            subtotal: widget.sub_total,
                            discount: service.ctvdiscountController.text.isNotEmpty ? service.ctvdiscountController.text : widget.discount,
                            vat: service.reactiveCTVVAT.value.isNotEmpty ? service.reactiveCTVVAT.value : widget.vat,
                            note: service.ctvnoteController.text.isNotEmpty ? service.ctvnoteController.text : widget.note,
                            grand_total: service.reactiveCTVGrandTotal.isNotEmpty ? service.reactiveCTVGrandTotal.value : widget.total,
                            serviceList: widget.product_details,
                          ).whenComplete(() {
                            setState(() {
                              service.reactiveCTVVAT.value = "";
                              service.reactiveCTVGrandTotal.value = "";
                            });
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