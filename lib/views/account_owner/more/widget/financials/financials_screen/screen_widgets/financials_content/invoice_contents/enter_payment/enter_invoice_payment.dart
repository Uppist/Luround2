import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/financials/invoice/enter_payment/enter_invoice_payment_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/loader.dart';
import 'package:luround/utils/components/my_snackbar.dart';
import 'package:luround/utils/components/utils_textfield.dart';






Future<void> enterInvoicePaymentBottomSheet({
  required BuildContext context, 
}) async{
  showModalBottomSheet(
    isScrollControlled: true,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 2,
    isDismissible: true,
    useSafeArea: true,
    backgroundColor: AppColor.bgColor,
    //barrierColor: Theme.of(context).colorScheme.background,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(15.r)
      )
    ),
    context: context,
    builder: (context) {
      return BodyWidget();
    }
  );
}



class BodyWidget extends StatefulWidget {
  BodyWidget({super.key});


  @override
  State<BodyWidget> createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<BodyWidget> {

  var service = Get.put(InvoicePaymentService());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return service.isLoading.value ? Expanded(child: Loader2()) : Container(
          //height: 200.h,
          width: double.infinity,
          color: AppColor.bgColor,
          //padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
          child: Wrap(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Record Payment",
                          style: GoogleFonts.inter(
                            color: AppColor.blackColor,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Icon(
                            CupertinoIcons.xmark,
                            color: AppColor.blackColor,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10.h,),
                    Divider(color: Colors.grey.withOpacity(0.5), thickness: 0.5,),
                    SizedBox(height: 30.h,),
                    Text(
                      "Amount Paid*",
                      style: GoogleFonts.inter(
                        color: AppColor.blackColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    SizedBox(height: 20.h,),      
                    //amount textfield
                    UtilsTextField2(
                      initialValue: '0.00',
                      onFocusChanged: (val) {},
                      onChanged: (val) {
                        setState(() {
                          service.amountTextController.text = val;
                          print(service.amountTextController.text);
                        });
                      },
                      hintText: "Enter amount paid by recepient",
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,  //.search,
                    ),
                
                    SizedBox(height: 30.h,),
        
                    Text(
                      "Payment Method",
                      style: GoogleFonts.inter(
                        color: AppColor.blackColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    SizedBox(height: 20.h,),
                    //DropDown Menu Button comes here
                    DropdownButtonFormField<String>(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(        
                        border: const OutlineInputBorder(
                          borderSide: BorderSide.none, // Remove the border
                        ),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColor.textGreyColor), // Set the color you prefer
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColor.blackColor), // Set the color you prefer
                        ),     
                        hintText: "Tap to select",
                        hintStyle: GoogleFonts.inter(color: AppColor.textGreyColor, fontSize: 14.sp, fontWeight: FontWeight.w400),              
                      ),
                      icon: Icon(
                        CupertinoIcons.chevron_down,
                        color: AppColor.blackColor,
                      ),
                      iconDisabledColor: AppColor.textGreyColor,
                      iconEnabledColor: AppColor.blackColor,
                      dropdownColor: AppColor.bgColor,
                      borderRadius: BorderRadius.circular(10.r),
                      value: service.payment_method.value,
                      onChanged: (String? newValue) {
                        service.payment_method.value = newValue!;
                        debugPrint("mode of payment: ${service.payment_method.value}");
                      },
                      style: GoogleFonts.inter(
                        color: AppColor.textGreyColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
        
                      //dropdown menu item padding
                      //padding: EdgeInsets.symmetric(horizontal: 20.w),
                      items: service.listOfModeOfPayments
                      .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: GoogleFonts.inter(
                              color: AppColor.darkGreyColor,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          );
                        }
                      ).toList(),
                    ),     
        
                    SizedBox(height: 40.h,),
        
                    //CANCEL AND SAVE BUTTON
                    Container(
                      height: 100.h,
                      alignment: Alignment.center,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColor.bgColor,
                        boxShadow: [
                          BoxShadow(
                            color: AppColor.darkGreyColor,
                          )
                        ]
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 20.w,), //vertical: 30.h
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Container(
                              height: 50.h,
                              width: 100.w,
                              alignment: Alignment.center,
                              //padding: EdgeInsets.symmetric(horizontal: 20.w, ),
                              decoration: BoxDecoration(
                                color: AppColor.bgColor,
                                border: Border.all(color: AppColor.darkGreyColor, width: 1.0),
                                borderRadius: BorderRadius.circular(12.r)
                              ),
                              child: Text(
                                "Cancel",
                                style: GoogleFonts.inter(
                                  color: AppColor.darkGreyColor,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500
                                )
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {

                              if(service.amountTextController.text.isNotEmpty) {
                                service.markInvoiceAsPaid(
                                  context: context, 
                                  amount_paid: service.amountTextController.text, 
                                  mode_of_payment: service.payment_method.value
                                );
                              }
                              else {
                                showMySnackBar(
                                  context: context, 
                                  message: "enter amount paid", 
                                  backgroundColor: AppColor.redColor
                                );
                              }
                        
                            },
                            child: Container(
                              height: 50.h,
                              width: 100.w,
                              alignment: Alignment.center,
                              //padding: EdgeInsets.symmetric(horizontal: 20.w, ),
                              decoration: BoxDecoration(
                                color: AppColor.mainColor,
                                //border: Border.all(color: AppColor.mainColor, width: 1.0),
                                borderRadius: BorderRadius.circular(12.r)
                              ),
                              child: Text(
                                "Save",
                                style: GoogleFonts.inter(
                                  color: AppColor.bgColor,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500
                                )
                              ),
                            ),
                          ),
                        ]
                      ),
                    )
                        
                  ]
                ),
              )
            ]
          )
        );
      }
    );               
  }
}