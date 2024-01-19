import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/financials/main/financials_controller.dart';
import 'package:luround/services/account_owner/more/financials/financials_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/create_receipt/widgets/add_product_widget/added_service_widgets/border_textfield.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/create_receipt/widgets/add_product_widget/added_service_widgets/no_border_textfield.dart';





class ViewAddedServiceDetailsForReceipt extends StatelessWidget {
  ViewAddedServiceDetailsForReceipt({super.key, required this.appointment_type, required this.service_name, required this.total, required this.discount, required this.rate, required this.duration, required this.index, required this.discounted_total});
  final String appointment_type;
  final String service_name;
  final String total;
  final String discounted_total;
  final String discount;
  final String rate;
  final String duration;
  final int index;

  //var controller = Get.put(FinancialsController());
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
                            finService.editProductForReceiptCreation(
                              context: context, 
                              service_id: "(not needed)", 
                              discount: discount, 
                              rate: rate, 
                              total: discounted_total, 
                              duration: duration, 
                              appointmentType: appointment_type, 
                              index: index
                            ).whenComplete(() {
                              finService.subtotalForReceipt.clear();
                              print(finService.editedSelectedProuctMapListForReceipt);
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
                          service_name,
                          style: GoogleFonts.inter(
                            color: AppColor.mainColor, 
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                        Text(
                          "N$total",
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
                    NoBorderTextFieldForReceipt(
                      onChanged: (p0) {},
                      hintText: 'Enter service name',
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      initialValue: service_name,
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
                    NoBorderTextFieldForReceipt(
                      onChanged: (p0) {
                        finService.serviceDescriptionForReceipt.text = p0;
                      },
                      hintText: 'Enter service description',
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      initialValue: "",
                    ),
                    SizedBox(height: 30.h,),

                    //3
                    Text(
                      "Meeting type*",
                      style: GoogleFonts.inter(
                        color: AppColor.blackColor, 
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    SizedBox(height: 5.h,),
                    NoBorderTextFieldForReceipt(
                      onChanged: (p0) {
                        finService.selectedMeetingTypeForReceipt.text = p0;
                        print(finService.selectedMeetingTypeForReceipt.text);
                      },
                      hintText: 'Enter meeting type',
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      initialValue: appointment_type,
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
                    BorderTextFieldForReceipt(
                      onChanged: (p0) {
                        finService.rateForReceipt.text = p0;
                        print(finService.rateForReceipt.text);
                      },
                      hintText: 'Enter service fee',
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      initialValue: rate,
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
                    BorderTextFieldForReceipt(
                      onChanged: (p0) {
                        finService.durationForReceipt.text = p0;
                        print(finService.durationForReceipt.text);
                      },
                      hintText: 'Enter service duration',
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      initialValue: duration,
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
                          child: DiscountTextFieldForReceipt(
                            onChanged: (p0) {
                              finService.discountForReceipt.text = p0;
                              print(finService.discountForReceipt.text);
                            },
                            hintText: 'Enter service discount',
                            keyboardType: TextInputType.number,
                            textInputAction: TextInputAction.done,
                            initialValue: discount,
                          ),
                        ),
                        SizedBox(width: 10.w,),
                        //calculate button
                        InkWell(
                          onTap: () {
                            finService.calculateDiscountForReceipt(
                              index: index, 
                              context: context,
                              initialRateValue: rate
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
                                text: "N$discounted_total",
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
                            finService.deleteSelectedProductForReceipt(index)
                            .whenComplete(() => Get.back());
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