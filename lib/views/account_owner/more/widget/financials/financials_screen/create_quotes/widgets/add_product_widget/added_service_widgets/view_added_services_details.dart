import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/financials/main/financials_controller.dart';
import 'package:luround/services/account_owner/more/financials/financials_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/loader.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/create_quotes/widgets/add_product_widget/added_service_widgets/border_textfield.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/create_quotes/widgets/add_product_widget/added_service_widgets/no_border_textfield.dart';





class ViewAddedServiceDetails extends StatefulWidget {
  ViewAddedServiceDetails({super.key, required this.duration, required this.service_description, required this.index, required this.service_name, required this.discount, required this.total, required this.meeting_type, required this.rate, required this.discounted_total,});
  final String service_name;
  final String service_description;
  final String meeting_type;
  final String rate;
  final String discount;
  final String duration;
  final int index;
  final String total;
  final String discounted_total;

  @override
  State<ViewAddedServiceDetails> createState() => _ViewAddedServiceDetailsState();
}

class _ViewAddedServiceDetailsState extends State<ViewAddedServiceDetails> {
  var controller = Get.put(FinancialsController());

  var finService = Get.put(FinancialsService());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: Obx(
        () {
          return finService.isLoading.value ? Loader() : SafeArea(
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
                                finService.editProductForCreatingQuote(
                                  index: widget.index,
                                  service_name: widget.service_name,
                                  discount: finService.convertedToLocalCurrencyDiscountForQuote.value,
                                  total: finService.subTotalForQuote.value,
                                  context: context, 
                                  rate: finService.rateForQuote.value,
                                  service_description: finService.serviceDescriptionForQuote.value.isNotEmpty ? finService.serviceDescriptionForQuote.value : widget.service_description, 
                                  duration: widget.duration, 
                                  meetingType: finService.selectedMeetingTypeForQuote.value
                                ).whenComplete(() {
                                  finService.subTotalForQuote.value = "";
                                  print(finService.editedSelectedProuctMapList);
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
                            Expanded(
                              child: Text(
                                widget.service_name,
                                style: GoogleFonts.inter(
                                  color: AppColor.mainColor, 
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              "N${widget.total}",
                              style: GoogleFonts.inter(
                                color: AppColor.mainColor, 
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600
                              ),
                              overflow: TextOverflow.ellipsis,
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
                        NoBorderTextField(
                          onChanged: (p0) {},
                          hintText: 'Enter service name',
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          initialValue: widget.service_name
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
                        NoBorderTextField(
                          onChanged: (p0) {
                            setState(() {
                              finService.serviceDescriptionForQuote.value = p0;
                            });
                          },
                          hintText: 'Enter service description',
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          initialValue: finService.serviceDescriptionForQuote.value.isEmpty ? "${widget.service_description}" : finService.serviceDescriptionForQuote.value,
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
                        NoBorderTextField(
                          onChanged: (p0) {
                            setState(() {
                              finService.selectedMeetingTypeForQuote.value = p0;
                            });
                          },
                          hintText: 'Enter meeting type',
                          keyboardType: TextInputType.text,
                          textInputAction: TextInputAction.next,
                          initialValue: widget.meeting_type,
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
                        BorderTextField(
                          onChanged: (p0) {
                            setState(() {
                              finService.rateForQuote.value = p0;
                              print(finService.rateForQuote.value);
                            });
                          },
                          hintText: 'Enter service fee',
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          initialValue: widget.rate, //finService.rateForQuote.value
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
                        BorderTextField(
                          onChanged: (p0) {
                            finService.durationForQuote.value = p0;
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
                              child: DiscountTextField(
                                onChanged: (p0) {
                                  setState(() {
                                    finService.discountForQuote.value = p0;
                                    print(finService.discountForQuote.value);
                                  });
                                  
                                },
                                hintText: 'Enter service discount',
                                keyboardType: TextInputType.number,
                                textInputAction: TextInputAction.done,
                                initialValue: "",
                              ),
                            ),
                            SizedBox(width: 10.w,),
                            //calculate button
                            InkWell(
                              onTap: () {
                                finService.calculateDiscount(index: widget.index, context: context);
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
                            )
                            
                            
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
                                    text: 'Total: ',
                                    style: GoogleFonts.inter(
                                      color: AppColor.darkGreyColor,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500
                                    )
                                  ),
                                  TextSpan(
                                    text: "N${widget.discounted_total}",
                                    //text: finService.subTotalForQuote.value.isNotEmpty ? "N${finService.subTotalForQuote.value}" : "N${widget.total}",
                                    style: GoogleFonts.inter(
                                      color: AppColor.darkGreyColor,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600
                                    )
                                  ),          
                                ]
                              )
                            ),
                            
                            SizedBox(width: 10.w,),
                  
                            //delete button
                            InkWell(
                              onTap: () {
                                finService.deleteSelectedProductForQuote(widget.index)
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
          );
        }
      )
    );
  }
}