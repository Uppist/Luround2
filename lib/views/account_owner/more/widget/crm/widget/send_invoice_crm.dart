import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/financials/main/financials_controller.dart';
import 'package:luround/services/account_owner/data_service/local_storage/local_storage.dart';
import 'package:luround/services/account_owner/more/financials/financials_pdf_service.dart';
import 'package:luround/services/account_owner/more/financials/financials_service.dart';
import 'package:luround/services/account_owner/profile_service/user_profile_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/loader.dart';
import 'package:luround/utils/components/my_snackbar.dart';
import 'package:luround/utils/components/reusable_button.dart';
import 'package:luround/utils/components/utils_textfield.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/create_invoice/date_selectors/due_date_selector.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/create_invoice/date_selectors/invocie_date_selector.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/create_invoice/widgets/add_product_widget/add_product_bottomsheet.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/create_invoice/widgets/add_product_widget/added_service_widgets/view_added_services_details.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/create_invoice/widgets/create_invoice_widgets/payment_method.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/create_invoice/widgets/create_invoice_widgets/send_invoice_bottomsheet.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/create_invoice/widgets/create_invoice_widgets/textfield_tool_for_invoice.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/create_quotes/widgets/add_product_widget/added_service_widgets/added_services_listtile.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/create_quotes/widgets/create_quote_widgets/date_container_widget.dart';









class SendInvoiceCRM extends StatefulWidget {
  const SendInvoiceCRM({super.key, required this.name, required this.email, required this.phone_number,});
  final String name;
  final String email;
  final String phone_number;

  @override
  State<SendInvoiceCRM> createState() => _SendInvoiceCRMState();
}

class _SendInvoiceCRMState extends State<SendInvoiceCRM> {
  
  var user_email = LocalStorage.getUseremail();
  var userProfileService = Get.put(AccOwnerProfileService());
  var controller = Get.put(FinancialsController());
  var service = Get.put(FinancialsService());
  var finPdfService = Get.put(FinancialsPdfService());
  int invoiceNumber = Random().nextInt(2000000);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20.h,),
            ///Navigation Section, Search TextField and Filter/////
            Container(
              padding: EdgeInsets.symmetric(horizontal: 7.w,),
              //height: 70, //65
              width: double.infinity,
              color: AppColor.bgColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h,),
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
                    "Invoice $invoiceNumber",
                    style: GoogleFonts.inter(
                      color: AppColor.textGreyColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500
                    ),
                  ),
                ],
              ),
            ),

            //Epanded single child scroll view////
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
                //padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //style
                    Container(
                      height: 7.h,
                      width: double.infinity,
                      color: AppColor.greyColor,
                    ),

                    //1 Header and Date Section
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Logged in user details
                          FutureBuilder(
                            future: userProfileService.getUserProfileDetails(email: user_email),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return Loader2();
                              }
                              if (snapshot.hasError) {
                                print(snapshot.error);
                              }
                              if (!snapshot.hasData) {
                                print("sn-trace: ${snapshot.stackTrace}");
                                print("sn-data: ${snapshot.data}");
                                return Loader2();   
                              }
             
                              if (snapshot.hasData) {
                                var data = snapshot.data!;
                                return Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical:10.h),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    //crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CircleAvatar(
                                        radius: 35.r,
                                        backgroundColor: AppColor.mainColor,
                                        backgroundImage: NetworkImage(
                                          data.photoUrl
                                        ),
                                      ),
                                      SizedBox(width: 20.w),
                                      Expanded(
                                        child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,                       
                                          children: [
                                            Text(
                                              data.displayName,
                                              style: GoogleFonts.inter(
                                                color: AppColor.darkGreyColor,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w600
                                              ),
                                            ),
                                            SizedBox(height: 5.h,),
                                            Text(
                                              data.email,
                                              style: GoogleFonts.inter(
                                                color: AppColor.textGreyColor,
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w400
                                              ),
                                            ),
                                          ],                      
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }
                              return Loader2();
                            }
                          ),
                          Divider(color: Colors.grey, thickness: 0.2,),
                          SizedBox(height: 30.h,),

                          //Name
                          Text(
                            "Send to",
                            style: GoogleFonts.inter(
                              color: AppColor.blackColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          SizedBox(height: 10.h,),
                          //SELECT CLIENT
                          /*SelectClientWidget(
                            clientName: "Select a client",
                            onTap: () {
                              selectClientBottomSheet(
                                context: context,
                              );
                            },
                          ),*/
                          UtilsTextField2(
                            onChanged: (val) {                 
                              controller.invoiceClientNameController.text = val; 
                            },
                            hintText: "Receiver's name",
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            initialValue: widget.name,
                          ),
                          
                          //Email
                          SizedBox(height: 30.h,),
                          Text(
                            "Email Address",
                            style: GoogleFonts.inter(
                              color: AppColor.blackColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          SizedBox(height: 10.h,),
                          UtilsTextField2(
                            onChanged: (val) {
                              controller.invoiceClientEmailController.text = val;
                            },
                            hintText: "Receiver's email address",
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            initialValue: widget.email,
                          ),

                          //Email
                          SizedBox(height: 30.h,),
                          Text(
                            "Phone Number",
                            style: GoogleFonts.inter(
                              color: AppColor.blackColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          SizedBox(height: 10.h,),
                          UtilsTextField2(
                            onChanged: (val) {
                              controller.invoiceClientPhoneNumberController.text = val;
                            },
                            hintText: "Receiver's mobile number",
                            keyboardType: TextInputType.phone,
                            textInputAction: TextInputAction.done,
                            initialValue: widget.phone_number,
                          ),


                          SizedBox(height: 30.h,),

                          Text(
                            "Invoice Date",
                            style: GoogleFonts.inter(
                              color: AppColor.blackColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          SizedBox(height: 20.h,),
                        
                          Obx(
                            () {
                              return DateContainer(
                                onTap: () {
                                  selectInvoiceDateBottomSheet(
                                    context: context,
                                    onCancel: () {
                                      Get.back();
                                    },
                                    onApply: () {
                                      controller.updatedInvoiceDate(initialDate: "Select Date");
                                      Get.back();
                                    },
                                  );
                                },
                                date: controller.updatedInvoiceDate(initialDate: "Select Date"),
                              );
                            }
                          ),                  
                          
                          SizedBox(height: 30.h,),
                          
                          Text(
                            "Due Date",
                            style: GoogleFonts.inter(
                              color: AppColor.blackColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          SizedBox(height: 20.h,),
                          Obx(
                            () {
                              return DateContainer(
                                onTap: () {
                                  selectDueDateBottomSheetForInvoice(
                                    context: context,
                                    onCancel: () {
                                      Get.back();
                                    },
                                    onApply: () {
                                      controller.updatedDueDateForInvoice(initialDate: "Select Date");
                                      Get.back();
                                    },
                                  );
                                },
                                date: controller.updatedDueDateForInvoice(initialDate: "Select Date"),
                              );
                            }
                          ),
                    
                        ],
                      ),
                    ),
                    SizedBox(height: 15.h,),
                    //style
                    Container(
                      height: 7.h,
                      width: double.infinity,
                      color: AppColor.greyColor,
                    ),
                    SizedBox(height: 20.h,),

                    //2 add services section
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0.h),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Add product or service*",
                                style: GoogleFonts.inter(
                                  color: AppColor.blackColor,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  addProductBottomSheetForInvoice(
                                    client_phone_number: controller.invoiceClientPhoneNumberController.text ,
                                    context: context, 
                                  );
                                },
                                child: SvgPicture.asset("assets/svg/add_icon.svg")
                              )
                            ],
                          ),
                          //Future builder list of selected services comes here
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h,),
                    //style
                    Container(
                      height: 7.h,
                      width: double.infinity,
                      color: AppColor.greyColor,
                    ),
                    SizedBox(height: 10.h,),

                    //To show the items that were added (Use Future builder to show the items addedd)
                    Obx(
                      () {
                        return //service.selectedInvoicebslist.isNotEmpty ? 
                        ListView.builder(
                          scrollDirection: Axis.vertical,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          itemCount: service.selectedInvoicebslist.length,
                          itemBuilder: (BuildContext context, int index) {
                            final item = service.selectedInvoicebslist[index];
                            return AddedServicesTile(
                              onTap: (){
                                Get.to(() => ViewAddedServiceDetailsForInvoice(
                                  client_phone_number: item['phone_number'],
                                  service_name: item['service_name'],
                                  service_id: item['service_id'],
                                  service_description: item['description'],
                                  discounted_total: item["discounted_total"].toString() ?? item['total'].toString(),
                                  meeting_type: item['appointment_type'],
                                  appointmentType: item['appointment_type'],
                                  index: index,
                                  rate: item['rate'],
                                  total: item['total'],
                                  discount: item['discount'],
                                  duration: item['duration'],
                                ));
                              },
                              productName: item['service_name'],
                              price: item['total'].toString(),
                              duration: item['duration'],
                            );
                          }
                        ); //: SizedBox();
                      }
                    ),

                    SizedBox(height: 20.h,),
                    Container(
                      height: 7.h,
                      width: double.infinity,
                      color: AppColor.greyColor,
                    ),
                    SizedBox(height: 20.h,),

                    //3 calculations
                    Obx(
                      () {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0),
                          child: Column(
                            children: [
                              //row1
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Subtotal",
                                    style: GoogleFonts.inter(
                                      color: AppColor.darkGreyColor,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500
                                    ),
                                  ),
                                  Text(
                                    "N${service.reactiveSubtotalForInvoice.value}",
                                    style: GoogleFonts.inter(
                                      color: AppColor.darkGreyColor,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 30.h,),
                              //row2
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Discount",
                                    style: GoogleFonts.inter(
                                      color: AppColor.darkGreyColor,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500
                                    ),
                                  ),
                                  Text(
                                    "${service.reactiveTotalDiscountForInvoice.value}%",
                                    style: GoogleFonts.inter(
                                      color: AppColor.darkGreyColor,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 30.h,),
                              //row3
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "VAT",
                                    style: GoogleFonts.inter(
                                      color: AppColor.darkGreyColor,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500
                                    ),
                                  ),
                                  Text(
                                    "N${service.reactiveTotalVATForInvoice.value}",
                                    style: GoogleFonts.inter(
                                      color: AppColor.darkGreyColor,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 30.h,),
                              //row4
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Grand Total",
                                    style: GoogleFonts.inter(
                                      color: AppColor.darkGreyColor,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500
                                    ),
                                  ),
                                  Text(
                                    "N${service.reactiveTotalForInvoice.value}",
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
                        );
                      }
                    ),
                    SizedBox(height: 20.h,),
                    //style
                    Container(
                      height: 7.h,
                      width: double.infinity,
                      color: AppColor.greyColor,
                    ),
                    SizedBox(height: 20.h,),

                    //4 write notes section
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Notes (optional)",
                            style: GoogleFonts.inter(
                              color: AppColor.blackColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          SizedBox(height: 20.h,),
                          NotesTextFieldForInvoice(
                            onChanged: (val) {
                              // Check if character count exceeds the maximum
                              if (val.length > controller.maxLengthForInvoice) {
                                // Remove extra characters       
                                controller.invoiceNoteController.text = val.substring(0, controller.maxLengthForInvoice);
                                debugPrint("you have reached max length");
                              } 
                              setState(() {}); // Update the UI
                            },
                            hintText: "Write a short note for the recipient.",
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            controller: controller.invoiceNoteController,
                          ),
                          SizedBox(height: 20.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                '${controller.invoiceNoteController.text.length}/${controller.maxLengthForInvoice}',
                                style: GoogleFonts.inter(
                                  color: AppColor.textGreyColor,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400
                                )
                              ),
                            ]
                          ),
                        ]
                      )
                    ),
                    SizedBox(height: 20.h,),  

                    //style
                    Container(
                      height: 7.h,
                      width: double.infinity,
                      color: AppColor.greyColor,
                    ),
                    SizedBox(height: 20.h,),
                    //5 Bank Payment Widget
                    //
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Payment",
                            style: GoogleFonts.inter(
                              color: AppColor.blackColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          SizedBox(height: 20.h,),
                          //List of banks
                          PaymentMethodForInvoice()
                        ]
                      )
                    ),

                    
                    SizedBox(height: 20.h,),
                    //style
                    Container(
                      height: 7.h,
                      width: double.infinity,
                      color: AppColor.greyColor,
                    ),
                    SizedBox(height: 20.h,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                      child: ReusableButton(
                        color: AppColor.mainColor,
                        text: 'Send Invoice',
                        onPressed: () {
                          if(service.selectedBankForInvoice.value.isNotEmpty) {
                            sendInvoiceBottomSheet(
                              context: context,
                              onShare: () {
                                service.createNewInvoiceAndSendToClient(
                                  context: context, 
                                  bank_name: service.selectedBankForInvoice.value,
                                  account_name: service.selectedAccNameForInvoice.value,
                                  account_number: service.selectedAccNumberForInvoice.value,
                                  client_name: widget.name, 
                                  client_email: widget.email, 
                                  client_phone_number: widget.phone_number, 
                                  note: controller.invoiceNoteController.text,
                                  invoice_date: controller.updatedInvoiceDate(initialDate: "(non)"), 
                                  due_date: controller.updatedDueDateForInvoice(initialDate: "(non)"),
                                  vat: service.reactiveTotalVATForInvoice.value,
                                  sub_total: service.reactiveSubtotalForInvoice.value,
                                  discount: service.reactiveTotalDiscountForInvoice.value,
                                  total: service.reactiveTotalForInvoice.value,
                                  booking_detail: service.selectedInvoicebslist
                                ).whenComplete(() {
                                    print("sent");
                                    setState(() {
                                      service.reactiveSubtotalForInvoice.value = '';
                                      service.reactiveTotalDiscountForInvoice.value = '';
                                      service.reactiveTotalVATForInvoice.value = '';
                                      service.reactiveTotalForInvoice.value = '';
                                    });
                                    Get.back();
                                });

                              },
                              onSave: () {
                                service.createNewInvoiceAndSaveToDB(
                                  context: context, 
                                  bank_name: service.selectedBankForInvoice.value,
                                  account_name: service.selectedAccNameForInvoice.value,
                                  account_number: service.selectedAccNumberForInvoice.value,
                                  client_name: widget.name, 
                                  client_email: widget.email, 
                                  client_phone_number: widget.phone_number,
                                  note: controller.invoiceNoteController.text,
                                  invoice_date: controller.updatedInvoiceDate(initialDate: "(non)"), 
                                  due_date: controller.updatedDueDateForInvoice(initialDate: "(non)"),
                                  vat: service.reactiveTotalVATForInvoice.value,
                                  sub_total: service.reactiveSubtotalForInvoice.value,
                                  discount: service.reactiveTotalDiscountForInvoice.value,
                                  total: service.reactiveTotalForInvoice.value,
                                  booking_detail: service.selectedInvoicebslist
                                ).whenComplete(() {
                                  controller.invoiceClientEmailController.clear();
                                  controller.invoiceClientNameController.clear();
                                  controller.invoiceClientPhoneNumberController.clear();
                                  controller.invoiceNoteController.clear();

                                  setState(() {
                                    service.reactiveSubtotalForInvoice.value = '';
                                    service.reactiveTotalDiscountForInvoice.value = '';
                                    service.reactiveTotalVATForInvoice.value = '';
                                    service.reactiveTotalForInvoice.value = '';
                                  });

                                  Get.back();
                                });
                              },
                              onDownload: () {
                                finPdfService.downloadInvoicePDFToDevice(
                                  sender_address: "",
                                  sender_phone_number: '',
                                  bank_name: service.selectedBankForInvoice.value,
                                  account_name: service.selectedAccNameForInvoice.value,
                                  account_number: service.selectedAccNumberForInvoice.value,
                                  context: context, 
                                  tracking_id: invoiceNumber.toString(),
                                  receiver_email: widget.email,
                                  receiver_name: widget.name,
                                  receiver_phone_number: widget.phone_number,
                                  note: controller.invoiceNoteController.text,
                                  invoice_status: "SENT",
                                  due_date: controller.updatedDueDateForInvoice(initialDate: "(non)"),
                                  subtotal: service.reactiveSubtotalForInvoice.value,
                                  discount: service.reactiveTotalDiscountForInvoice.value,
                                  vat: service.reactiveTotalVATForInvoice.value,
                                  grand_total: service.reactiveTotalForInvoice.value,
                                  serviceList: service.selectedInvoicebslist,
                                ).whenComplete(() {
                                  controller.invoiceClientEmailController.clear();
                                  controller.invoiceClientNameController.clear();
                                  controller.invoiceClientPhoneNumberController.clear();
                                  controller.invoiceNoteController.clear();

                                  setState(() {
                                    service.reactiveSubtotalForInvoice.value = '';
                                    service.reactiveTotalDiscountForInvoice.value = '';
                                    service.reactiveTotalVATForInvoice.value = '';
                                    service.reactiveTotalForInvoice.value = '';
                                  });

                                  Get.back();
                                });
                              },
                            );
                          }
                          else {
                            //failure snackbar
                            showMySnackBar(
                              context: context,
                              backgroundColor: AppColor.redColor,
                              message: "please select bank account"
                            );
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 20.h,),
                  ],
                ),
              )
            )

          ]
        )
      )
    );
  }
}