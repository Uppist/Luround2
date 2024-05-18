import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/financials/main/financials_controller.dart';
import 'package:luround/main.dart';
import 'package:luround/services/account_owner/data_service/local_storage/local_storage.dart';
import 'package:luround/services/account_owner/more/financials/financials_pdf_service.dart';
import 'package:luround/services/account_owner/more/financials/financials_service.dart';
import 'package:luround/services/account_owner/profile_service/user_profile_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/converters.dart';
import 'package:luround/utils/components/loader.dart';
import 'package:luround/utils/components/my_snackbar.dart';
import 'package:luround/utils/components/reusable_button.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/create_quotes/widgets/add_product_widget/add_product_bottomsheet.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/create_quotes/widgets/add_product_widget/added_service_widgets/added_services_listtile.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/create_quotes/widgets/create_quote_widgets/date_container_widget.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/create_quotes/date_selectors/due_date_selector.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/create_quotes/widgets/create_quote_widgets/payment_method.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/create_quotes/widgets/create_quote_widgets/send_quote_bottomsheet.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/create_quotes/widgets/create_quote_widgets/textfield_tool.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/create_quotes/date_selectors/quote_date_selector.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/create_quotes/widgets/add_product_widget/added_service_widgets/view_added_services_details.dart';









class CreateQuotePage extends StatefulWidget {
  CreateQuotePage({super.key, required this.quoteNumber});
  final int quoteNumber;

  @override
  State<CreateQuotePage> createState() => _CreateQuotePageState();
}

class _CreateQuotePageState extends State<CreateQuotePage> {
  
  var user_email = LocalStorage.getUseremail();
  var userProfileService = Get.put(AccOwnerProfileService());
  var controller = Get.put(FinancialsController());
  var service = Get.put(FinancialsService());
  var finPdfService = Get.put(FinancialsPdfService());

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
                        "Quote ${widget.quoteNumber}",
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
                                  ClientEmailTextField(
                                    onChanged: (val) {
                                      controller.quoteClientNameController.text = val;
                                    },
                                    hintText: "Receiver's name",
                                    keyboardType: TextInputType.name,
                                    textInputAction: TextInputAction.next,
                                    controller: controller.quoteClientNameController,
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
                                  ClientEmailTextField(
                                    onChanged: (val) {
                                      controller.quoteClientEmailController.text = val;
                                    },
                                    hintText: "Receiver's email address",
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.next,
                                    controller: controller.quoteClientEmailController,
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
                                  ClientEmailTextField(
                                    onChanged: (val) {
                                      controller.quoteClientPhoneNumberController.text = val;
                                    },
                                    hintText: "Receiver's mobile number",
                                    keyboardType: TextInputType.phone,
                                    textInputAction: TextInputAction.done,
                                    controller: controller.quoteClientPhoneNumberController,
                                  ),
                            
                            
                                  SizedBox(height: 30.h,),
                            
                                  Text(
                                    "Quote Date",
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
                                          selectQuoteDateBottomSheet(
                                            context: context,
                                            onCancel: () {
                                              Get.back();
                                            },
                                            onApply: () {
                                              controller.updatedQuoteDate(initialDate: "Select Date");
                                              Get.back();
                                            },
                                          );
                                        },
                                        date: controller.updatedQuoteDate(initialDate: "Select Date"),
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
                                          selectDueDateBottomSheet(
                                            context: context,
                                            onCancel: () {
                                              Get.back();
                                            },
                                            onApply: () {
                                              controller.updatedDueDate(initialDate: "Select Date");
                                              Get.back();
                                            },
                                          );
                                        },
                                        date: controller.updatedDueDate(initialDate: "Select Date"),
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
                                      addProductBottomSheetForQuote(context: context);
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
                            return ListView.builder(
                              scrollDirection: Axis.vertical,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              padding: EdgeInsets.symmetric(horizontal: 20.w),
                              itemCount: service.selectedQuotebslist.length,
                              itemBuilder: (context, index) {
                                final item = service.selectedQuotebslist[index];
                                return AddedServicesTile(
                                  onTap: (){
                                    Get.to(() => ViewAddedServiceDetails(
                                      service_id: item['service_id'],
                                      service_name: item['service_name'],
                                      //service_id: item['serviceID'],
                                      service_description: item['description'],
                                      discounted_total: item["discounted_total"].toString() ?? item['total'].toString(),
                                      meeting_type: item['appointment_type'],
                                      index: index,
                                      rate: item['rate'],
                                      total: item['total'], //total
                                      discount: item['discount'],
                                      duration: item['duration'],
                                    ));
                                  },
                                  productName: item['service_name'],
                                  price: item['total'].toString(),
                                  duration: item['duration'],
                                );
                              }
                            );
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
                                      InkWell(
                                        onTap: () {
                                          //service.showEverythingForQuoteList();
                                        },
                                        child: Text(
                                          "Subtotal",
                                          style: GoogleFonts.inter(
                                            color: AppColor.darkGreyColor,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500
                                          ),
                                        ),
                                      ),
                                      
                                      Text(
                                        "${currency(context).currencySymbol}${service.reactiveSubtotalForQuote.value}",
                                        style: GoogleFonts.inter(
                                          color: AppColor.darkGreyColor,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500
                                        ),
                                      )
                                      
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
                                        "${service.reactiveTotalDiscountForQuote.value}%",
                                        style: GoogleFonts.inter(
                                          color: AppColor.darkGreyColor,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500
                                        ),
                                      )
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
                                        "${currency(context).currencySymbol}${service.reactiveTotalVATForQuote.value}",
                                        style: GoogleFonts.inter(
                                          color: AppColor.darkGreyColor,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500
                                        ),
                                      )
                                            
                                    
                                    ],
                                  ),
                                  SizedBox(height: 30.h,),
                                  //row3
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
                                        "${currency(context).currencySymbol}${service.reactiveTotalForQoute.value}",
                                        style: GoogleFonts.inter(
                                          color: AppColor.darkGreyColor,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500
                                        ),
                                      )                        
                                      
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
                              NotesTextField(
                                onChanged: (val) {
                                  // Check if character count exceeds the maximum
                                  if (val.length > controller.maxLength) {
                                    // Remove extra characters       
                                    controller.quoteNoteController.text = val.substring(0, controller.maxLength);
                                    debugPrint("you have reached max length");
                                  } 
                                  setState(() {}); // Update the UI
                                },
                                hintText: "Write a short note for the recipient.",
                                keyboardType: TextInputType.text,
                                textInputAction: TextInputAction.done,
                                controller: controller.quoteNoteController,
                              ),
                              SizedBox(height: 20.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    '${controller.quoteNoteController.text.length}/${controller.maxLength}',
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
                              PaymentMethodForQuote()
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
                            text: 'Send Quote',
                            onPressed: () {
                              if(service.selectedBankForQuote.value.isNotEmpty && controller.quoteClientNameController.text.isNotEmpty && controller.quoteClientEmailController.text.isNotEmpty && controller.quoteClientPhoneNumberController.text.isNotEmpty) {
                                sendQuoteBottomSheet(
                                  context: context,
                                  onShare: () {
                                    service.createNewQuoteAndSendToClient(
                                      context: context, 
                                      bank_name: service.selectedBankForQuote.value,
                                      account_name: service.selectedAccNameForQuote.value,
                                      account_number: service.selectedAccNumberForQuote.value,
                                      client_name: controller.quoteClientNameController.text, 
                                      client_email: controller.quoteClientEmailController.text, 
                                      client_phone_number: controller.quoteClientPhoneNumberController.text, 
                                      note: controller.quoteNoteController.text,
                                      quote_date: controller.updatedQuoteDate(initialDate: "(non)"), 
                                      quote_due_date: controller.updatedDueDate(initialDate: "(non)"),
                                      vat: service.reactiveTotalVATForQuote.value,
                                      sub_total: service.reactiveSubtotalForQuote.value,
                                      discount: service.reactiveTotalDiscountForQuote.value,
                                      total: service.reactiveTotalForQoute.value,
                                      product_detail: service.selectedQuotebslist,
                                    ).whenComplete(() {
                                      print("sent");
                                      setState(() {
                                        service.reactiveSubtotalForQuote.value = '';
                                        service.reactiveTotalDiscountForQuote.value = '';
                                        service.reactiveTotalVATForQuote.value = '';
                                        service.reactiveTotalForQoute.value = '';
                                      });
                                    });                       
                                  },
                                  onSave: () {
                                    service.createNewQuoteAndSendToDB(
                                      context: context, 
                                      bank_name: service.selectedBankForQuote.value,
                                      account_name: service.selectedAccNameForQuote.value,
                                      account_number: service.selectedAccNumberForQuote.value,
                                      client_name: controller.quoteClientNameController.text, 
                                      client_email: controller.quoteClientEmailController.text, 
                                      client_phone_number: controller.quoteClientPhoneNumberController.text, 
                                      note: controller.quoteNoteController.text,
                                      quote_date: controller.updatedQuoteDate(initialDate: "(non)"), 
                                      quote_due_date: controller.updatedDueDate(initialDate: "(non)"),
                                      vat: service.reactiveTotalVATForQuote.value,
                                      sub_total: service.reactiveSubtotalForQuote.value,
                                      discount: service.reactiveTotalDiscountForQuote.value,
                                      total: service.reactiveTotalForQoute.value,
                                      product_detail: service.selectedQuotebslist,
                                    ).whenComplete(() {
                                      controller.quoteClientEmailController.clear();
                                      controller.quoteClientNameController.clear();
                                      controller.quoteClientPhoneNumberController.clear();
                                      controller.quoteNoteController.clear();
                                      setState(() {
                                        service.reactiveSubtotalForQuote.value = '';
                                        service.reactiveTotalDiscountForQuote.value = '';
                                        service.reactiveTotalVATForQuote.value = '';
                                        service.reactiveTotalForQoute.value = '';
                                      });
                                      Get.back();
                                    });
                                  },
                                  onDownload: () {
                                    finPdfService.downloadQuotePDFToDevice(
                                      context: context, 
                                      sender_address: "",
                                      sender_phone_number: '',
                                      bank_name: service.selectedBankForQuote.value,
                                      account_name: service.selectedAccNameForQuote.value,
                                      account_number: service.selectedAccNumberForQuote.value,
                                      tracking_id: widget.quoteNumber.toString(),
                                      receiver_email: controller.quoteClientEmailController.text,
                                      receiver_name: controller.quoteClientNameController.text,
                                      receiver_phone_number: controller.quoteClientPhoneNumberController.text,
                                      quote_status: "SENT",
                                      due_date: controller.updatedDueDate(initialDate: "(non)"),
                                      subtotal: service.reactiveSubtotalForQuote.value,
                                      discount: service.reactiveTotalDiscountForQuote.value,
                                      vat: service.reactiveTotalVATForQuote.value,
                                      note: controller.quoteNoteController.text,
                                      grand_total: service.reactiveTotalForQoute.value,
                                      serviceList: service.selectedQuotebslist,
                                    ).whenComplete(() {
                                      controller.quoteClientEmailController.clear();
                                      controller.quoteClientNameController.clear();
                                      controller.quoteClientPhoneNumberController.clear();
                                      controller.quoteNoteController.clear();
                                      setState(() {
                                        service.reactiveSubtotalForQuote.value = '';
                                        service.reactiveTotalDiscountForQuote.value = '';
                                        service.reactiveTotalVATForQuote.value = '';
                                        service.reactiveTotalForQoute.value = '';
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
          ),
        
      
    );
  }
}