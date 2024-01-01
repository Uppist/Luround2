import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luround/controllers/account_owner/financials/main/financials_controller.dart';
import 'package:luround/services/account_owner/more/financials/financials_service.dart';
import 'package:luround/utils/colors/app_theme.dart';
import 'package:luround/utils/components/reusable_button.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/create_invoice/date_selectors/due_date_selector.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/create_invoice/date_selectors/invocie_date_selector.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/create_invoice/widgets/add_product_widget/add_product_bottomsheet.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/create_invoice/widgets/add_product_widget/added_service_widgets/view_added_services_details.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/create_invoice/widgets/create_invoice_widgets/send_invoice_bottomsheet.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/create_invoice/widgets/create_invoice_widgets/textfield_tool_for_invoice.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/create_quotes/widgets/add_product_widget/added_service_widgets/added_services_listtile.dart';
import 'package:luround/views/account_owner/more/widget/financials/financials_screen/create_quotes/widgets/create_quote_widgets/date_container_widget.dart';









class CreateInvoicePage extends StatefulWidget {
  CreateInvoicePage({super.key, required this.invoiceNumber});
  final int invoiceNumber;

  @override
  State<CreateInvoicePage> createState() => _CreateInvoicePageState();
}

class _CreateInvoicePageState extends State<CreateInvoicePage> {

  var controller = Get.put(FinancialsController());
  var service = Get.put(FinancialsService());

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
                    "Invoice ${widget.invoiceNumber}",
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
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical:10.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              //crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 35.r,
                                  backgroundColor: AppColor.mainColor,
                                  //backgroundImage: ,
                                ),
                                SizedBox(width: 20.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,                       
                                    children: [
                                      Text(
                                        "Ivy Richie",
                                        style: GoogleFonts.inter(
                                          color: AppColor.darkGreyColor,
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600
                                        ),
                                      ),
                                      SizedBox(height: 5.h,),
                                      Text(
                                        "ivyleague@gmail.com",
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
                          ClientEmailTextFieldForInvoice(
                            onChanged: (val) {
                              controller.invoiceClientNameController.text = val;
                            },
                            hintText: "Receiver's name",
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            controller: controller.invoiceClientNameController,
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
                          ClientEmailTextFieldForInvoice(
                            onChanged: (val) {
                              controller.invoiceClientEmailController.text = val;
                            },
                            hintText: "Receiver's email address",
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            controller: controller.invoiceClientEmailController,
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
                          ClientEmailTextFieldForInvoice(
                            onChanged: (val) {
                              controller.invoiceClientPhoneNumberController.text = val;
                            },
                            hintText: "Receiver's mobile number",
                            keyboardType: TextInputType.phone,
                            textInputAction: TextInputAction.done,
                            controller: controller.invoiceClientPhoneNumberController,
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
                                  addProductBottomSheetForInvoice(context: context, service: service, controller: controller);
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
                    ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      itemCount: 2,
                      itemBuilder: (BuildContext context, int index) {
                        return AddedServicesTile(
                          onTap: (){
                            Get.to(() => ViewAddedServiceDetailsForInvoice());
                          },
                          productName: 'Personal Training',
                          price: '25,000',
                          duration: '1 hr',
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
                    Padding(
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
                                "N25,000",
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
                                "-N2,000",
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
                                "N200",
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
                                "N23,000",
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
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                      child: ReusableButton(
                        color: AppColor.mainColor,
                        text: 'Send Invoice',
                        onPressed: () {
                          sendInvoiceBottomSheet(
                            context: context,
                            onShare: () {},
                            onSave: () {},
                            onDownload: () {},
                          );
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