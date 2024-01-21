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
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/create_quotes/widgets/add_product_widget/added_service_widgets/added_services_listtile.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/create_quotes/widgets/create_quote_widgets/date_container_widget.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/create_receipt/date_selectors/receipt_date_selector.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/create_receipt/widgets/add_product_widget/add_product_bottomsheet.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/create_receipt/widgets/add_product_widget/added_service_widgets/view_added_services_details_for_receipt.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/create_receipt/widgets/create_invoice_widgets/send_receipt_bottomsheet.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/create_receipt/widgets/create_invoice_widgets/textfield_tool_for_receipt.dart';









class CreateReceiptPage extends StatefulWidget {
  CreateReceiptPage({super.key, required this.receiptNumber});
  final int receiptNumber;

  @override
  State<CreateReceiptPage> createState() => _CreateReceiptPageState();
}

class _CreateReceiptPageState extends State<CreateReceiptPage> {

  var controller = Get.put(FinancialsController());
  var service = Get.put(FinancialsService());
  var finPdfService = Get.put(FinancialsPdfService());
  var user_email = LocalStorage.getUseremail();
  var userProfileService = Get.put(AccOwnerProfileService());

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
                    "Receipt ${widget.receiptNumber}",
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
                          ClientEmailTextFieldForReceipt(
                            onChanged: (val) {
                              controller.receiptClientNameController.text = val;
                            },
                            hintText: "Receiver's name",
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            controller: controller.receiptClientNameController,
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
                          ClientEmailTextFieldForReceipt(
                            onChanged: (val) {
                              controller.receiptClientEmailController.text = val;
                            },
                            hintText: "Receiver's email address",
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            controller: controller.receiptClientEmailController,
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
                          ClientEmailTextFieldForReceipt(
                            onChanged: (val) {
                              controller.receiptClientPhoneNumberController.text = val;
                            },
                            hintText: "Receiver's mobile number",
                            keyboardType: TextInputType.phone,
                            textInputAction: TextInputAction.done,
                            controller: controller.receiptClientPhoneNumberController,
                          ),


                          SizedBox(height: 30.h,),

                          Text(
                            "Receipt Date",
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
                                  selectReceiptDateBottomSheet(
                                    context: context,
                                    onCancel: () {
                                      Get.back();
                                    },
                                    onApply: () {
                                      Get.back();
                                    },
                                  );
                                },
                                date: controller.updatedReceiptDate(initialDate: "Select Date"),
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
                                  addProductBottomSheetForReceipt(
                                    context: context
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
                        return service.selectedReceiptbslist.isNotEmpty ? ListView.builder(
                          scrollDirection: Axis.vertical,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          itemCount: service.selectedReceiptbslist.length,
                          itemBuilder: (BuildContext context, int index) {
                            final item = service.selectedReceiptbslist[index];
                            return AddedServicesTile(
                              onTap: (){
                                Get.to(() => ViewAddedServiceDetailsForReceipt(
                                  discounted_total: item['discounted_total'] ?? item['total'],
                                  appointment_type: item['appointment_type'],
                                  service_name: item['service_name'],
                                  total: item['total'],
                                  discount: item['discount'],
                                  rate: item['rate'],
                                  duration: item['duration'],
                                  index: index,
                                ));
                              },
                              productName: item['service_name'],
                              price: item['total'].toString(),
                              duration: item['duration'],
                            );
                          }
                        ) : SizedBox();
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
                                    "N${service.reactiveSubtotalForReceipt.value}",
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
                                    "${service.reactiveTotalDiscountForReceipt.value}%",
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
                                    "N${service.reactiveTotalVATForReceipt.value}",
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
                                    "Total",
                                    style: GoogleFonts.inter(
                                      color: AppColor.darkGreyColor,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500
                                    ),
                                  ),
                                  Text(
                                    "N${service.reactiveTotalForReceipt.value}",
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

                    //4 dropdown menu textfield for selcting mode of payment
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Mode of payment",
                            style: GoogleFonts.inter(
                              color: AppColor.blackColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500
                            ),
                          ),
                          SizedBox(height: 20.h,),
                          //DropDown Menu Button comes here
                          Obx(
                            () {
                              return DropdownButtonFormField<String>(
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                decoration: InputDecoration(        
                                  border: OutlineInputBorder(
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
                                value: controller.selectedModeOfPayment.value,
                                onChanged: (String? newValue) {
                                  controller.selectedModeOfPayment.value = newValue!;
                                  debugPrint("mode of payment: ${controller.selectedModeOfPayment.value}");
                                },
                                style: GoogleFonts.inter(
                                  color: AppColor.textGreyColor,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),

                                //dropdown menu item padding
                                //padding: EdgeInsets.symmetric(horizontal: 20.w),

                                items: controller.listOfModeOfPayments
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
                                }).toList(),
                              );
                            }
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

                    //5 write notes section
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
                          NotesTextFieldForReceipt(
                            onChanged: (val) {
                              // Check if character count exceeds the maximum
                              if (val.length > controller.maxLengthForReceipt) {
                                // Remove extra characters       
                                controller.receiptNoteController.text = val.substring(0, controller.maxLengthForReceipt);
                                debugPrint("you have reached max length");
                              } 
                              setState(() {}); // Update the UI
                            },
                            hintText: "Write a short note for the recipient.",
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            controller: controller.receiptNoteController,
                          ),
                          SizedBox(height: 20.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                '${controller.receiptNoteController.text.length}/${controller.maxLengthForReceipt}',
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
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                      child: ReusableButton(
                        color: AppColor.mainColor,
                        text: 'Send Receipt',
                        onPressed: () {
                          if(
                            controller.receiptClientNameController.text.isNotEmpty 
                            && controller.receiptClientEmailController.text.isNotEmpty 
                            && controller.receiptClientPhoneNumberController.text.isNotEmpty
                          ) {
                            sendReceiptBottomSheet(
                              context: context,
                              onShare: () {
                                service.createNewReceiptAndSendToClient(
                                  context: context, 
                                  client_name: controller.receiptClientNameController.text, 
                                  client_email: controller.receiptClientEmailController.text, 
                                  client_phone_number: controller.receiptClientPhoneNumberController.text, 
                                  note: controller.receiptNoteController.text,
                                  receipt_date: controller.updatedReceiptDate(initialDate: "(non)"), 
                                  mode_of_payment: controller.selectedModeOfPayment.value
                                ).whenComplete(() {
                                    finPdfService.shareReceiptPDF(
                                    context: context,
                                    receiptNumber: widget.receiptNumber,
                                    receiver_email: controller.receiptClientEmailController.text,
                                    receiver_name: controller.receiptClientNameController.text,
                                    receiver_phone_number: controller.receiptClientPhoneNumberController.text,
                                    receipt_status: "SENT VIA PDF",
                                    due_date: controller.updatedReceiptDate(initialDate: "(non)"),
                                    subtotal: service.reactiveSubtotalForReceipt.value,
                                    discount: service.reactiveTotalDiscountForReceipt.value,
                                    vat: service.reactiveTotalVATForReceipt.value,
                                    note: controller.receiptNoteController.text,
                                    grand_total: service.reactiveTotalForReceipt.value,
                                    serviceList: service.selectedReceiptbslist,
                                  ).whenComplete(() {
                                    controller.receiptClientEmailController.clear();
                                    controller.receiptClientNameController.clear();
                                    controller.receiptClientPhoneNumberController.clear();
                                    controller.receiptNoteController.clear();
                                    Get.back();
                                  });
                                });
                              },
                              onSave: () {
                                service.createNewReceiptAndSaveToDB(
                                  context: context, 
                                  client_name: controller.receiptClientNameController.text, 
                                  client_email: controller.receiptClientEmailController.text, 
                                  client_phone_number: controller.receiptClientPhoneNumberController.text, 
                                  note: controller.receiptNoteController.text,
                                  receipt_date: controller.updatedReceiptDate(initialDate: "(non)"), 
                                  mode_of_payment: controller.selectedModeOfPayment.value
                                ); //.whenComplete(() => Get.back());
                              },
                              onDownload: () {
                                finPdfService.downloadReceiptPDFToDevice(
                                  context: context,
                                  receiptNumber: widget.receiptNumber,
                                  receiver_email: controller.receiptClientEmailController.text,
                                  receiver_name: controller.receiptClientNameController.text,
                                  receiver_phone_number: controller.receiptClientPhoneNumberController.text,
                                  receipt_status: "SENT VIA PDF",
                                  due_date: controller.updatedReceiptDate(initialDate: "(non)"),
                                  subtotal: service.reactiveSubtotalForReceipt.value,
                                  discount: service.reactiveTotalDiscountForReceipt.value,
                                  vat: service.reactiveTotalVATForReceipt.value,
                                  note: controller.receiptNoteController.text,
                                  grand_total: service.reactiveTotalForReceipt.value,
                                  serviceList: service.selectedReceiptbslist,
                                ).whenComplete(() => Get.back());
                              },
                            );
                          }
                          else {
                            //failure snackbar
                            showMySnackBar(
                              context: context,
                              backgroundColor: AppColor.redColor,
                              message: "fields must not be empty"
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