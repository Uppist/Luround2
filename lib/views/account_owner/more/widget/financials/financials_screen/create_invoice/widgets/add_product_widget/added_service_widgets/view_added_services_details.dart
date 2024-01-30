import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/financials/main/financials_controller.dart';
import 'package:luround/services/account_owner/more/financials/financials_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/create_invoice/widgets/add_product_widget/added_service_widgets/border_textfield.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/create_invoice/widgets/add_product_widget/added_service_widgets/no_border_textfield.dart';






// ignore: must_be_immutable
class ViewAddedServiceDetailsForInvoice extends StatefulWidget {
  ViewAddedServiceDetailsForInvoice({super.key, required this.service_id, required this.service_name, required this.service_description, required this.meeting_type, required this.rate, required this.total, required this.discount, required this.duration, required this.index, required this.discounted_total, required this.appointmentType, required this.client_phone_number});
  final String service_id;
  final String service_name;
  final String service_description;
  final String meeting_type;
  final String rate;
  final String total;
  final String discount;
  final String duration;
  final int index;
  final String discounted_total;
  final String appointmentType;
  final String client_phone_number;

  @override
  State<ViewAddedServiceDetailsForInvoice> createState() => _ViewAddedServiceDetailsForInvoiceState();
}

class _ViewAddedServiceDetailsForInvoiceState extends State<ViewAddedServiceDetailsForInvoice> {
  var controller = Get.put(FinancialsController());
  var finService = Get.put(FinancialsService());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 15.h,),
            //
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w,), //7.w
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(
                      Icons.arrow_back_rounded,
                      color: AppColor.blackColor,
                    )
                  ),
                  SizedBox(width: 10.w,),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Back",
                          style: GoogleFonts.inter(
                            color: AppColor.blackColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500
                          ),
                        ),
                        //Save button
                        InkWell(
                          onTap: () {
                            finService.editProductForInvoiceCreation(
                              booking_user_name: controller.invoiceClientNameController.text.isNotEmpty ? controller.invoiceClientNameController.text : "no entry", 
                              booking_user_email: controller.invoiceClientEmailController.text.isNotEmpty ? controller.invoiceClientEmailController.text : "no entry",
                              context: context, 
                              service_name: widget.service_name, 
                              service_description: finService.serviceDescriptionForInvoice.text.isEmpty ? widget.service_description : finService.serviceDescriptionForInvoice.text, 
                              service_id: widget.service_id, 
                              discount: finService.discountForInvoice.text.isEmpty ? widget.discount : finService.discountForInvoice.text, 
                              vat: (double.parse(finService.rateForInvoice.text.isEmpty ? widget.rate : finService.rateForInvoice.text) * 0.075).toString(),
                              rate: finService.rateForInvoice.text.isEmpty ? widget.rate : finService.rateForInvoice.text, 
                              total: finService.subtotalForInvoice.text.isNotEmpty ? finService.subtotalForInvoice.text : widget.total,
                              duration: finService.durationForInvoice.text.isEmpty ? widget.duration : finService.durationForInvoice.text, 
                              appointmentType: finService.selectedMeetingTypeForInvoice.text.isEmpty ? widget.appointmentType : finService.selectedMeetingTypeForInvoice.text, 
                              index: widget.index, 
                              phone_number: widget.client_phone_number
                            ).whenComplete(() {
                              //finService.subtotalForInvoice.clear();
                              finService.calculateDiscountForInvoice(
                                index: widget.index,
                                initialDiscountValue: widget.discount,
                                initialRateValue: widget.rate,
                                context: context
                              );
                              finService.showEverythingForInvoiceList();
                              print(finService.selectedInvoicebslist);
                            });
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: 60.w,
                            height: 35.h,
                            decoration: BoxDecoration(
                              color: AppColor.mainColor,
                              borderRadius: BorderRadius.circular(8.r)
                            ),
                            child: Text(
                              'Save',
                              style: GoogleFonts.inter(
                                color: AppColor.bgColor,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w500
                              )
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            /*SizedBox(height: 15.h),
            Container(
              color: AppColor.greyColor,
              width: double.infinity,
              height: 7.h,
            ),*/     
            SizedBox(height: 10.h,),
            //
            //Expanded Singlechild here
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.service_name,
                          style: GoogleFonts.inter(
                            color: AppColor.mainColor, 
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                        Text(
                          "N${widget.total}",
                          style: GoogleFonts.inter(
                            color: AppColor.mainColor, 
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h,),
                    Divider(color: Colors.grey.withOpacity(0.5), thickness: 0.5,),
                    SizedBox(height: 30.h,),
                    
                    ////[FIELDS HERE]//////
                    //1
                    Text(
                      "Service name",
                      style: GoogleFonts.inter(
                        color: AppColor.blackColor, 
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    SizedBox(height: 5.h,),
                    NoBorderTextFieldForInvoice(
                      onChanged: (p0) {},
                      hintText: 'Enter service name',
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      initialValue: widget.service_name,
                    ),
                    SizedBox(height: 30.h,),
                    //2
                    Text(
                      "Service description",
                      style: GoogleFonts.inter(
                        color: AppColor.blackColor, 
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    SizedBox(height: 5.h,),
                    NoBorderTextFieldForInvoice(
                      onChanged: (p0) {                    
                        finService.serviceDescriptionForInvoice.text = p0;
                      },
                      hintText: 'Enter service description',
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      initialValue: widget.service_description,
                    ),
                    SizedBox(height: 30.h,),

                    //3
                    Text(
                      "Meeting type",
                      style: GoogleFonts.inter(
                        color: AppColor.blackColor, 
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    SizedBox(height: 5.h,),
                    NoBorderTextFieldForInvoice(
                      onChanged: (p0) {
                        finService.selectedMeetingTypeForInvoice.text = p0;
                      },
                      hintText: 'Enter meeting type',
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      initialValue: widget.appointmentType,
                    ),
                    SizedBox(height: 30.h,),
                    
                    //4
                    Text(
                      "Rate",
                      style: GoogleFonts.inter(
                        color: AppColor.blackColor, 
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    SizedBox(height: 10.h,),
                    BorderTextFieldForInvoice(
                      onChanged: (p0) {
                        finService.rateForInvoice.text = p0;
                        print(finService.rateForInvoice.text);
                      },
                      hintText: 'Enter service fee',
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      initialValue: widget.rate,
                    ),
                    SizedBox(height: 30.h,),

                    //5
                    Text(
                      "Duration",
                      style: GoogleFonts.inter(
                        color: AppColor.blackColor, 
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    SizedBox(height: 10.h,),
                    BorderTextFieldForInvoice(
                      onChanged: (p0) {
                        finService.durationForInvoice.text = p0;
                        print(finService.durationForInvoice.text);
                      },
                      hintText: 'Enter service duration',
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      initialValue: widget.duration,
                    ),
                    SizedBox(height: 30.h,),

                    //6
                    Text(
                      "Discount",
                      style: GoogleFonts.inter(
                        color: AppColor.blackColor, 
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    SizedBox(height: 10.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: DiscountTextFieldForInvoice(
                            onChanged: (p0) {
                          
                              // Check if the entered text is a valid integer
                              if (p0.isNotEmpty && double.tryParse(p0) != null) {
                                setState(() {
                                  // If it's an integer, append ".0" to the text
                                  if (!p0.contains('.')) {
                                    finService.discountForInvoice.text  = '$p0.0';
                                    print(finService.discountForInvoice.text);
                                  }
                                });
                              }
                            },
                            hintText: 'Enter service discount',
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.done,
                            initialValue: widget.discount,
                          ),
                        ),
                        SizedBox(width: 10.w,),
                        //calculate button
                        InkWell(
                          onTap: () {
                            finService.calculateDiscountForInvoice(
                              initialDiscountValue: widget.discount.toString(),
                              index: widget.index, 
                              context: context,
                              initialRateValue: widget.rate
                            );
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: 100.w,  //70.w
                            height: 70.h, //40.h
                            decoration: BoxDecoration(
                              color: AppColor.mainColor,
                              borderRadius: BorderRadius.circular(10.r),
                              border: Border.all(color: AppColor.mainColor)
                            ),
                            child: Text(
                              'Calculate',
                              style: GoogleFonts.inter(
                                color: AppColor.bgColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500
                              )
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'Total:',
                                style: GoogleFonts.inter(
                                  color: AppColor.darkGreyColor,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500
                                )
                              ),
                              TextSpan(
                                text: "N${widget.total}",
                                style: GoogleFonts.inter(
                                  color: AppColor.darkGreyColor,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600
                                )
                              ),

                            ]
                          )
                        ),
                        //delete button
                        InkWell(
                          onTap: () {
                            finService.deleteSelectedProductForInvoice(widget.index)
                            .whenComplete(() {
                              finService.showEverythingForInvoiceList();
                              Get.back();
                            });
                          },
                          child: Text(
                            "Delete",
                            style: GoogleFonts.inter(
                              color: AppColor.redColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline,
                              decorationColor: AppColor.redColor
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 30.h,),
                  ]
                )
              )
            ),

          ]
        )
      )
    );
  }
}